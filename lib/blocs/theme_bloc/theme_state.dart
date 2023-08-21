import 'package:flutter/material.dart';
import 'package:mvp_taplan/theme/colors.dart';

class ThemeState {
  final bool isDark;

  ThemeState({this.isDark = true});

  Color get appBarColor => isDark ? AppTheme.appBarMainColor : Colors.white;

  List<Color> get appBarButtonGradient => isDark
      ? [
          AppTheme.appBarButtonFillColor2,
          AppTheme.appBarButtonFillColor1,
        ]
      : [
          Colors.white,
          const Color.fromRGBO(224, 236, 250, 1),
        ];

  List<Color> get appBarButtonBorder => isDark
      ? [
          AppTheme.appBarButtonFirstBorderColor,
          AppTheme.appBarButtonSecondBorderColor,
        ]
      : [
          const Color.fromRGBO(230, 241, 254, 1),
          const Color.fromRGBO(252, 253, 254, 1),
        ];
  Color get appBarTextColor => isDark? Colors.white : const Color.fromRGBO(22, 26, 29, 1);
  
  ThemeState copyWith({bool? isDark}) {
    return ThemeState(
      isDark: isDark ?? this.isDark,
    );
  }
}
