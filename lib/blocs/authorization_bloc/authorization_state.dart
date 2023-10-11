class AuthorizationState {
  final String authToken;
  final String code;

  AuthorizationState({
    this.authToken = '',
    this.code = '',
  });

  AuthorizationState copyWith({String? authToken, String? code}) {
    return AuthorizationState(
      authToken: authToken ?? this.authToken,
      code: code ?? this.code,
    );
  }
}
