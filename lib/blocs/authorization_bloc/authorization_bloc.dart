import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';

import 'authorization_event.dart';
import 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthState> {
  AuthorizationBloc() : super(UnAuthorizationState()) {
    on<SwitchAuthorizationEvent>(_onSwitchAuthorization);
    on<ChangeDataEvent>(_onChangeData);
    on<LoginEvent>(_onLogin);
    on<GetDataEvent>(_onGetData);
    on<RegisterEvent>(_onRegister);
    on<GetCodeEvent>(_onGetCode);
  }

  _onSwitchAuthorization(SwitchAuthorizationEvent event, Emitter<AuthState> emitter) {
    emitter(
      AuthorizationState().copyWith(
        authToken: event.authToken,
        code: event.code,
      ),
    );
  }

  _onGetCode(GetCodeEvent event, Emitter<AuthState> emitter) async {
    if(state.phone != null) {
      try {
        final formData = FormData.fromMap({
          'phoneNumber': state.phone!.substring(1,),
        });
        final response = await Dio().post(
          'https://qviz.fun/api/v1/confirm/',
          data: formData,
          options: Options(
            validateStatus: (status) {
              if (status == null) return false;
              return status < 500;
            },
          ),
        );

        emitter(
          AuthorizationState().copyWith(
            code: response.data['code'].toString(),
            authToken: state.authToken,
          ),
        );
      } catch (e) {
        rethrow;
      }
    }
  }

  _onChangeData(ChangeDataEvent event, Emitter<AuthState> emitter) async {
    late FormData formData;
    if (event.photo != null) {
      final photo = MultipartFile.fromBytes(
        event.photo!,
        filename: 'image.png',
        contentType: MediaType("image", "png"),
      );
      formData = FormData.fromMap({
        'username': event.username,
        'region': event.region,
        'email': event.email,
        'user_photo': photo,
        'birthday' : event.birthday,
        'sex' : event.sex ? 'True' : 'False',
      });
    } else {
      formData = FormData.fromMap({
        'username': event.username,
        'region': event.region,
        'email': event.email,
        'birthday' : event.birthday,
        'sex' : event.sex ? 'True' : 'False',
      });
    }
    try {
      await Dio().post(
        'https://qviz.fun/api/v1/change/user/data/',
        data: formData,
        options: Options(
          validateStatus: (status) {
            if (status == null) return false;
            return status < 500;
          },
          headers: {
            'Authorization': "Token ${state.authToken}",
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  _onRegister(RegisterEvent event, Emitter<AuthState> emitter) async {
    late FormData formData;
    if (event.image != null) {
      final photo = MultipartFile.fromBytes(
        event.image!,
        filename: 'image.png',
        contentType: MediaType("image", "png"),
      );
      formData = FormData.fromMap({
        'username': 'User',
        'password': event.password,
        'phoneNumber': event.phone,
        'telegram': event.telegram,
        'email': event.email,
        'user_photo': photo,
      });
    } else {
      formData = FormData.fromMap({
        'username': 'User',
        'password': event.password,
        'phoneNumber': event.phone,
        'telegram': event.telegram,
        'email': event.email,
      });
    }
    try {
      final response = await Dio().post(
        'https://qviz.fun/api/v1/auth/users/',
        data: formData,
        options: Options(
          validateStatus: (status) {
            if (status == null) return false;
            return status < 500;
          },
        ),
      );
      emitter(
        AuthorizationState().copyWith(
          sex: response.data['sex'],
          phone: response.data['phoneNumber'].runtimeType == (List<dynamic>)
              ? response.data['phoneNumber'][0]
              : response.data['phoneNumber'],
          email: response.data['email'],
          username: response.data['username'],
          telegram: response.data['telegram'].runtimeType == (List<dynamic>)
              ? response.data['telegram'][0]
              : response.data['telegram'],
          photo: response.data['user_photo'],
          id: response.data['id'],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  _onLogin(LoginEvent event, Emitter<AuthState> emitter) async {
    try {
      final response = await Dio().post(
        'https://qviz.fun/auth/token/login/',
        data: {
          'phoneNumber': event.phone,
          'password': event.password,
        },
        options: Options(
          validateStatus: (status) {
            if (status == null) return false;
            return status < 500;
          },
        ),
      );

      emitter(
        AuthorizationState().copyWith(
          authToken: response.data['auth_token'],
          phone: event.phone,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  _onGetData(GetDataEvent event, Emitter<AuthState> emitter) async {
    final dio = Dio();
    final response = await dio.post(
      'https://qviz.fun/api/v1/get/user/data/',
      options: Options(
        headers: {
          'Authorization': "Token ${state.authToken}",
        },
      ),
    );
    emitter(
      AuthorizationState().copyWith(
        phone: response.data['phoneNumber'],
        birthday: response.data['birthday'],
        username: response.data['username'],
        region: response.data['region'],
        photo: response.data['photo'],
        email: response.data['email'],
        sex: response.data['sex'],
        telegram: response.data['telegram'],
        authToken: state.authToken,
      ),
    );
  }
}
