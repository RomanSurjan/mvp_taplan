import 'dart:typed_data';

abstract class AuthState {
  final String? authToken;
  final String? code;
  final String? phone;
  final String? birthday;
  final String? username;
  final String? region;
  final Uint8List? photo;
  final String? email;
  final bool? sex;
  final String? telegram;
  final int? id;

  AuthState({
    this.authToken,
    this.code,
    this.phone,
    this.birthday,
    this.username,
    this.region,
    this.photo,
    this.email,
    this.sex,
    this.telegram,
    this.id,
  });
}

class AuthorizationState extends AuthState {
  AuthorizationState({
    super.authToken,
    super.code,
    super.phone,
    super.birthday,
    super.username,
    super.region,
    super.photo,
    super.email,
    super.sex,
    super.telegram,
    super.id,
  });

  AuthorizationState copyWith({
    String? authToken,
    String? code,
    String? phone,
    String? birthday,
    String? username,
    String? region,
    Uint8List? photo,
    String? email,
    bool? sex,
    String? telegram,
    int? id,
  }) {
    return AuthorizationState(
      authToken: authToken ?? this.authToken,
      code: code ?? this.code,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      username: username ?? this.username,
      region: region ?? this.region,
      photo: photo ?? this.photo,
      email: email ?? this.email,
      sex: sex ?? this.sex,
      telegram: telegram ?? this.telegram,
      id: id ?? this.id,
    );
  }
}

class UnAuthorizationState extends AuthState {
  UnAuthorizationState();
}
