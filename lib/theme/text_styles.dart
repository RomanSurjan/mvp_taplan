import 'package:flutter/material.dart';
import 'package:mvp_taplan/theme/colors.dart';

class TextLocalStyles {
  static const roboto400 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppTheme.mainGreenColor,
  );
  static const roboto600 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppTheme.mainGreenColor,
  );
  static const roboto500 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppTheme.mainGreenColor,
  );

  static const mono400 = TextStyle(
    fontFamily: 'MonoType',
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontStyle: FontStyle.italic,
  );
}

const TextStyle appBarNameTextStyle =
    TextStyle(color: AppTheme.mainWhiteColor, fontSize: 18, fontFamily: 'Roboto');

const TextStyle moneyCollectedScaleWidgetLeftTextStyle =
    TextStyle(color: AppTheme.mainGreenColor, fontSize: 16, fontFamily: 'Roboto');

const TextStyle moneyCollectedScaleWidgetRightTextStyle =
    TextStyle(color: AppTheme.mainPinkColor, fontSize: 16, fontFamily: 'Roboto');

const TextStyle presentScreenTextStyle =
    TextStyle(color: AppTheme.presentScreenTextColor, fontSize: 16, fontFamily: 'Roboto');

const TextStyle presentScreenCounterUpTextStyle =
    TextStyle(color: AppTheme.presentScreenCounterTextColor, fontSize: 30, fontFamily: 'Gputeks');

const TextStyle presentScreenCounterBottomTextStyle =
    TextStyle(color: AppTheme.presentScreenCounterTextColor, fontSize: 14, fontFamily: 'Roboto');
