import 'dart:typed_data';

abstract class AuthorizationEvent {}

class SwitchAuthorizationEvent extends AuthorizationEvent {
  final String authToken;
  final String code;

  SwitchAuthorizationEvent({
    required this.authToken,
    required this.code,
  });
}

class GetDataEvent extends AuthorizationEvent {
  GetDataEvent();
}

class LoginEvent extends AuthorizationEvent {
  final String phone;
  final String password;

  LoginEvent({
    required this.phone,
    required this.password,
  });
}

class RegisterEvent extends AuthorizationEvent {
  final String phone;
  final String password;
  final String telegram;
  final String email;
  final Uint8List? image;

  RegisterEvent({
    required this.phone,
    required this.password,
    required this.telegram,
    required this.email,
    required this.image,
  });
}

class ChangeDataEvent extends AuthorizationEvent {
  final String email;
  final String username;
  final Uint8List? photo;
  final String region;
  final String birthday;
  final bool sex;
  final String telegram;

  ChangeDataEvent({
    required this.username,
    required this.photo,
    required this.region,
    required this.birthday,
    required this.sex,
    required this.email,
    required this.telegram,
  });
}

class GetCodeEvent extends AuthorizationEvent {
  GetCodeEvent();
}
