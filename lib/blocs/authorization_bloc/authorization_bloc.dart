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
  }

  _onSwitchAuthorization(
      SwitchAuthorizationEvent event, Emitter<AuthState> emitter) {
    emitter(
      AuthorizationState().copyWith(
        authToken: event.authToken,
        code: event.code,
      ),
    );
  }

  _onChangeData(ChangeDataEvent event, Emitter<AuthState> emitter) {
    emitter(
      AuthorizationState().copyWith(
        phone: event.phone,
        birthday: event.birthday,
        username: event.username,
        region: event.region,
        photo: event.photo,
        email: event.email,
        sex: event.sex,
        telegram: event.telegram,
      ),
    );
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
      final code = event.phone.substring(8);
      emitter(
        AuthorizationState().copyWith(
          code: code,
          sex: response.data['sex'],
          phone: response.data['phoneNumber'].runtimeType ==
                  (List<dynamic>)
              ? response.data['phoneNumber'][0]
              : response.data['phoneNumber'],
          email: response.data['email'],
          username: response.data['username'],
          telegram: response.data['telegram'].runtimeType ==
              (List<dynamic>)
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
      final code = event.phone.substring(8);

      emitter(
        AuthorizationState().copyWith(
          code: code,
          authToken: response.data['auth_token'],
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
        birthday: response.data['phoneNumber'],
        username: response.data['username'],
        region: response.data['region'],
        photo: response.data['photo'],
        email: response.data['email'],
        sex: response.data['sex'],
        telegram: response.data['telegram'],
      ),
    );
  }
}
