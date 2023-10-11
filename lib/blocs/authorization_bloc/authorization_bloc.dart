import 'package:flutter_bloc/flutter_bloc.dart';

import 'authorization_event.dart';
import 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc() : super(AuthorizationState()) {
    on<SwitchAuthorizationEvent>(_onSwitchAuthorization);
  }

  _onSwitchAuthorization(SwitchAuthorizationEvent event, Emitter<AuthorizationState> emitter) {
    emitter(
      state.copyWith(
        authToken: event.authToken,
        code: event.code,
      ),
    );
  }
}
