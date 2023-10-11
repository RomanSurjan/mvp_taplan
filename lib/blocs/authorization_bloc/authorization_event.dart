
abstract class AuthorizationEvent{

}

class SwitchAuthorizationEvent extends AuthorizationEvent{
  final String authToken;
  final String code;
  SwitchAuthorizationEvent({required this.authToken, required this.code});
}