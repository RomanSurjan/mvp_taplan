import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Map<String, dynamic> data;
    if (event.photo != null) {
      final photo = MultipartFile.fromBytes(
        event.photo!,
        filename: 'image.png',
        contentType: MediaType("image", "png"),
      );
      data = {
        'username': event.username,
        'region': event.region,
        'email': event.email,
        'user_photo': photo,
        'birthday' : event.birthday,
        'sex' : event.sex ? 'True' : 'False',
        'telegram' : event.telegram,
      };
    } else {
      data = {
        'username': event.username,
        'region': event.region,
        'email': event.email,
        'birthday' : event.birthday,
        'sex' : event.sex ? 'True' : 'False',
        'telegram' : event.telegram,
      };
    }
    if(event.telegram.isEmpty) {
      data.remove('telegram');
    }
    if(event.email.isEmpty)
    {
      data.remove('email');
    }
    formData = FormData.fromMap(data);
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
    String phone = event.phone;
    if(!event.phone.contains('+'))
      {
        phone = '+$phone';
      }
    Map<String, dynamic> data;
    if (event.image != null) {
      final photo = MultipartFile.fromBytes(
        event.image!,
        filename: 'image.png',
        contentType: MediaType("image", "png"),
      );
      data = {
        'username': 'User',
        'password': event.password,
        'phoneNumber': phone,
        'telegram': event.telegram,
        'email': event.email,
        'user_photo': photo,
        'agreement' : true,
      };
    } else {
      data = {
        'username': 'User',
        'password': event.password,
        'phoneNumber': phone,
        'telegram': event.telegram,
        'email': event.email,
        'agreement' : true,
      };
    }
    if(event.telegram.isEmpty) {
      data.remove('telegram');
    }
    if(event.email.isEmpty)
      {
        data.remove('email');
      }
    formData = FormData.fromMap(data);

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
          passwordErr: response.data['password'],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  _onLogin(LoginEvent event, Emitter<AuthState> emitter) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      String phone = event.phone;
      if(!event.phone.contains('+'))
      {
        phone = '+$phone';
      }
      final response = await Dio().post(
        'https://qviz.fun/auth/token/login/',
        data: {
          'phoneNumber': phone,
          'password': event.password,
        },
        options: Options(
          validateStatus: (status) {
            if (status == null) return false;
            return status < 500;
          },
        ),
      );

      prefs.setString('auth_token', response.data['auth_token']);

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
    final prefs = await SharedPreferences.getInstance();

    final dio = Dio();
    final response = await dio.post(
      'https://qviz.fun/api/v1/get/user/data/',
      options: Options(
        headers: {
          'Authorization': "Token ${prefs.getString('auth_token')}",
        },
      ),
    );
    emitter(
      AuthorizationState().copyWith(
        phone: response.data['phoneNumber'],
        birthday: response.data['birthday'],
        username: response.data['username'],
        region: response.data['region'],
        photo: response.data['user_photo'],
        email: response.data['email'],
        sex: response.data['sex'],
        telegram: response.data['telegram'].runtimeType == Null ? '' : response.data['telegram'],
        authToken: state.authToken,
      ),
    );
  }
}
