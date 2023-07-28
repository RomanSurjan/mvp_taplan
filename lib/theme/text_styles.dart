import 'package:flutter/material.dart';
import 'package:mvp_taplan/theme/colors.dart';

class TextLocalStyles {
  static const roboto400 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w200,
    color: AppTheme.mainGreenColor,
  );
  static const roboto600 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppTheme.mainGreenColor,
  );
  static const roboto500 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppTheme.mainGreenColor,
  );

  static const mono400 = TextStyle(
    fontFamily: 'MonoType',
    fontSize: 20,
    fontWeight: FontWeight.w100,
    color: Colors.black,
    fontStyle: FontStyle.italic,
  );

  static const gputeks500 = TextStyle(
    fontFamily: 'Gputeks',
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );
}
