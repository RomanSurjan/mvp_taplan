import 'package:flutter/material.dart';

class AppTheme {
  final bool isDark;

  static const LinearGradient mainGreenGradient = LinearGradient(
    colors: [
      Color(0xFF62C6AA),
      Color(0xFF44A88C),
    ],
  );
  static const LinearGradient mainPurpleGradient = LinearGradient(
    colors: [
      Color(0xFFB1A8E0),
      Color(0xFFA196D1),
    ],
  );

  static const LinearGradient mainPinkGradient = LinearGradient(
    colors: [
      Color.fromRGBO(180, 69, 135, 1),
      Color.fromRGBO(180, 69, 135, 0.6),
    ],
  );

  static const LinearGradient mainGreyGradient = LinearGradient(
    colors: [
      Color.fromRGBO(194, 196, 204, 1),
      Color.fromRGBO(160, 165, 181, 1),
    ],
  );

  static const LinearGradient moneyCollectedScaleWidgetGradientColor1 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF4D8C7E),
      Color(0xFF44A88C)
    ],
  );

  static const LinearGradient moneyCollectedScaleWidgetGradientColor2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFB34887),
      Color(0xFF7E3D68)
    ],
  );

  static const LinearGradient greenButtonGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF62C6AA),
      Color(0xFF44A88C)
    ],
  );

  static const LinearGradient purpleButtonGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFB1A8E0),
      Color(0xFFA196D1)
    ],
  );

  static const Color appBarMainColor = Color(0xFF282A31);
  static const Color appBarButtonIconColor = Color(0xFFA6ADB5);
  static const Color appBarButtonBorderColor1 = Color(0xFF1C1F26);
  static const Color appBarButtonBorderColor2 = Color(0xFF4B4F5F);
  static const Color appBarButtonFillColor1 = Color(0xFF282B33);
  static const Color appBarButtonFillColor2 = Color(0xFF464851);

  static const Color backgroundColor = Color(0xFF2F313A);

  static const Color inactiveButtonFillColor = Color(0xFF393B43);
  static const Color inactiveButtonBorderColor = Color(0xFF48474F);

  static const Color mainBlueColor = Color(0xFF7FA4EA);
  static const Color mainGreenColor = Color(0xFF52B69A);
  static const Color mainPinkColor = Color(0xFFCE3B82);
  static const Color mainWhiteColor = Color(0xFFFFFFFF);

  static const Color presentScreenTextColor = Color(0xFFC8D2DB);
  static const Color presentScreenCounterColor = Color(0xFF282A31);
  static const Color presentScreenCounterTextColor = Color(0xFFC1B8ED);

  static const Color wishListScaleLeftColor = Color(0xFF44A88C);
  static const Color wishListScaleRightColor = Color(0xFFB44887);

  static const Color appBarManeColor = Color.fromRGBO(40, 42, 49, 1);
  static const Color appBarButtonFirstBorderColor = Color(0xFF1C1F26);
  static const Color appBarButtonSecondBorderColor = Color(0xFF4B4F5F);

  static const Color borderColor = Color(0xFF3B3D48);
  static const Color pickUpTextColor = Color(0xFF697177);
  static const Color pickUpContainerColor = Color(0xFF373941);
  static const Color pickUpButtonColor = Color(0xFF3E4048);
  static const Color pickUpBorderColor = Color(0xFF48474F);

  static const buttonIconColor = Color(0xFFA6ADB5);

  static const yearArrowTailColor = Color(0xFF9DA7B0);
  static const yearCircularFaceDecorColor = Color(0xFF547CC7);

  static const defaultGroupButtonColor = Color(0xFF6ED2B6);

  static const familyGroupButtonColor = Color(0xFF53AABE);
  static const friendsGroupButtonColor = Color(0xFF678FDA);
  static const relativesGroupButtonColor = Color(0xFF7B6CE8);
  static const colleaguesGroupButtonColor = Color(0xFFB668EC);
  static const partnersGroupButtonColor = Color(0xFFEC69E4);
  static const groupButtonsCountTextColor = Color(0xFF393939);

  static const celebrateIconDefaultColor = Color(0xFF9388CC);

  static const LinearGradient moneyScaleStickColor = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color.fromRGBO(75, 175, 147, 1),
      Color.fromRGBO(119, 217, 190, 1),
      Color.fromRGBO(68, 168, 140, 1),
    ],
  );
  static const Color moneyScaleGreenColor = Color.fromRGBO(127, 164, 234, 0.81);


  AppTheme.light({
    this.isDark = false,
  });

  AppTheme.dark({
    this.isDark = true,
  });
}
