import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';

import 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState()) {
    on<SwitchThemeEvent>(_onSwitchTheme);
  }

  _onSwitchTheme(SwitchThemeEvent event, Emitter<ThemeState> emitter) {
    emitter(
      state.copyWith(
        isDark: event.isDark,
      ),
    );
  }
}
