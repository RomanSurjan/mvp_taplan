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

  Color get appBarTextColor => isDark ? Colors.white : const Color.fromRGBO(22, 26, 29, 1);

  String get logoPath => isDark ? 'assets/images/logo_dock.png' : 'assets/images/logo_light.png';

  Color get dockColor =>
      isDark ? const Color.fromRGBO(52, 54, 62, 1) : const Color.fromRGBO(250, 255, 255, 1);

  Color get dockBorderColor =>
      isDark ? const Color.fromRGBO(67, 72, 78, 1) : const Color.fromRGBO(230, 241, 254, 1);

  Color get dockTrackColor =>
      isDark ? const Color.fromRGBO(73, 88, 99, 1) : const Color.fromRGBO(235, 239, 248, 1);

  Color get dockThumbColor =>
      isDark ? const Color.fromRGBO(129, 140, 147, 1) : const Color.fromRGBO(221, 232, 248, 1);

  Color get presentScreenLabelColor => isDark ? Colors.white : const Color.fromRGBO(65, 78, 88, 1);

  Color get presentScreenTextFieldColor =>
      isDark ? const Color.fromRGBO(52, 54, 62, 1) : const Color.fromRGBO(229, 232, 247, 1);

  Color get presentScreenTextFieldBorderColor =>
      isDark ? const Color.fromRGBO(66, 68, 77, 1) : const Color.fromRGBO(200, 210, 219, 1);

  Color get presentScreenCounterColor =>
      isDark ? AppTheme.presentScreenCounterColor : const Color.fromRGBO(229, 232, 247, 0.8);

  Color get timeScreenTextColor => isDark ? Colors.white : const Color.fromRGBO(98, 118, 132, 1);

  Color get timeScreenPickTextColor =>
      isDark ? const Color.fromRGBO(244, 199, 217, 1) : const Color.fromRGBO(98, 118, 132, 1);

  Color get postcardShadowColor =>
      isDark ? const Color(0x3F000000) : const Color.fromRGBO(0, 0, 0, 0.15);

  Color get postcardContainerColor =>
      isDark ? const Color.fromRGBO(66, 68, 77, 1) : const Color.fromRGBO(166, 173, 181, 1);

  Color get postcardContainerBorderColor =>
      isDark ? const Color.fromRGBO(66, 68, 77, 1) : const Color.fromRGBO(230, 241, 254, 1);

  Color get postcardContainerTextColor =>
      isDark ? Colors.white : const Color.fromRGBO(166, 173, 181, 1);

  Color get soloBuyTextColor =>
      isDark ? const Color.fromRGBO(240, 247, 254, 1) : const Color.fromRGBO(65, 78, 88, 1);

  Color get soloBuyDateBorderColor =>
      isDark ? AppTheme.borderColor : const Color.fromRGBO(230, 241, 254, 1);

  Color get soloBuyDateContainerColor =>
      isDark ? const Color.fromRGBO(55, 57, 65, 1) : const Color.fromRGBO(250, 255, 255, 1);

  Color get pickUpBorerColor =>
      isDark ? AppTheme.pickUpButtonColor : const Color.fromRGBO(166, 173, 181, 1);

  Color get activePickColor =>
      isDark ? Colors.white.withOpacity(0.08) : const Color.fromRGBO(13, 70, 102, 0.05);

  Color get unActivePickColor =>
      isDark ? Colors.white.withOpacity(0.04) : const Color.fromRGBO(13, 70, 102, 0.05);

  Color get activeTextColor => isDark ? Colors.white : const Color.fromRGBO(98, 118, 132, 1);

  Color get birthdayLabelShowcase =>
      isDark ? const Color.fromRGBO(188, 192, 200, 1) : const Color.fromRGBO(65, 78, 88, 1);

  Color get secondaryTextColorShowcase =>
      isDark ? const Color.fromRGBO(143, 153, 163, 1) : const Color.fromRGBO(98, 118, 132, 1);

  List<Color> get calendarGradient => isDark
      ? [
          const Color.fromRGBO(70, 72, 81, 1),
          const Color.fromRGBO(40, 43, 51, 1),
        ]
      : [
          const Color.fromRGBO(255, 255, 255, 1),
          const Color.fromRGBO(224, 236, 250, 1),
        ];

  ThemeState copyWith({bool? isDark}) {
    return ThemeState(
      isDark: isDark ?? this.isDark,
    );
  }
}
