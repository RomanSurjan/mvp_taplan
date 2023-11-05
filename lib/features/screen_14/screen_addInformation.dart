// ignore_for_file: file_names

import 'dart:async';
import 'dart:typed_data';


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_event.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_event.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_12/screen_pickImage.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

import '../screen_30/screen_30.dart';

class ScreenAddInformation extends StatefulWidget {
  const ScreenAddInformation({
    super.key,
  });

  @override
  State<ScreenAddInformation> createState() => _ScreenAddInformationState();
}

class _ScreenAddInformationState extends State<ScreenAddInformation> {
  Color textColor = const Color.fromRGBO(188, 192, 200, 1);
  Color textColorDark = const Color.fromRGBO(98, 118, 132, 1);
  TextEditingController name = TextEditingController(text: '');
  TextEditingController birthday = TextEditingController(text: '');
  TextEditingController phone = TextEditingController(text: '');
  TextEditingController telegram = TextEditingController(text: '');
  TextEditingController email = TextEditingController(text: '');
  TextEditingController city = TextEditingController(text: '');
  TextEditingController country = TextEditingController(text: '');
  late List<Color> textFieldColor;
  bool isOk = false;
  bool sex = false;

  bool isPressed = true;
  late String imageContact;

  int isPressedContactData = 0;

  Uint8List? image;

  double getHeight(BuildContext context, double height) {
    return height / 768 * MediaQuery.of(context).size.height;
  }

  double getWidth(BuildContext context, double width) {
    return width / 375 * MediaQuery.of(context).size.width;
  }

  void _checkData() {
    isOk = true;
    String value = email.text;
    RegExp regExp = RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+$");
    if (!regExp.hasMatch(value)) {
      isOk = false;
    }
    if (city.text.isEmpty) {
      isOk = false;
    }
    if (country.text.isEmpty) {
      isOk = false;
    }
    if (name.text.isEmpty) {
      isOk = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    textFieldColor = [
      context.read<ThemeBloc>().state.postcardContainerBorderColor,
      context.read<ThemeBloc>().state.postcardContainerBorderColor,
      context.read<ThemeBloc>().state.postcardContainerBorderColor,
      context.read<ThemeBloc>().state.postcardContainerBorderColor,
    ];

    //context.read<AuthorizationBloc>().add(GetDataEvent());
    phone = TextEditingController(text: context.read<AuthorizationBloc>().state.phone);
    telegram = TextEditingController(text: context.read<AuthorizationBloc>().state.telegram);

    name.addListener(() {
      _checkData();
    });
    email.addListener(() {
      _checkData();
    });
    city.addListener(() {
      _checkData();
    });
    country.addListener(() {
      _checkData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthState>(
      builder: (context, state) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor:
                  state.isDark ? AppTheme.backgroundColor : const Color.fromRGBO(240, 247, 254, 1),
              appBar: CustomAppBarRegistration(
                name: 'Ввод личных данных\nнового пользователя',
                onTheme: () {
                  context.read<ThemeBloc>().add(SwitchThemeEvent(isDark: !state.isDark));
                  setState(() {});

                  Timer(
                    const Duration(),
                    () {
                      textFieldColor = [
                        context.read<ThemeBloc>().state.postcardContainerBorderColor,
                        context.read<ThemeBloc>().state.postcardContainerBorderColor,
                        context.read<ThemeBloc>().state.postcardContainerBorderColor,
                        context.read<ThemeBloc>().state.postcardContainerBorderColor,
                      ];
                      setState(() {});
                    },
                  );
                },
              ),
              body: SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: getHeight(context, 41),
                        ),
                        SizedBox(
                          width: getWidth(context, 350),
                          child: textFieldRegistration(
                              context, 350, 'Имя', name, false, textFieldColor[0], true),
                        ),
                        SizedBox(
                          height: getHeight(context, 13),
                        ),
                        SizedBox(
                          height: getHeight(context, 71),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: getWidth(context, 235),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Дата рождения',
                                      style: TextLocalStyles.roboto400.copyWith(
                                        color: state.isDark
                                            ? Colors.white
                                            : const Color.fromRGBO(22, 26, 29, 1),
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    textFieldRegistration(context, 235, 'ДД.ММ.ГГГГ', birthday,
                                        false, textFieldColor[1], true),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Пол',
                                    style: TextLocalStyles.roboto400.copyWith(
                                      color: state.isDark
                                          ? Colors.white
                                          : const Color.fromRGBO(22, 26, 29, 1),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  SizedBox(
                                    width: getWidth(context, 94),
                                    height: getHeight(context, 52),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: context.read<ThemeBloc>().state.isDark
                                            ? const Color.fromRGBO(52, 54, 62, 1)
                                            : const Color.fromRGBO(250, 255, 255, 1),
                                        border: Border.all(
                                            color: context.read<ThemeBloc>().state.isDark
                                                ? const Color.fromRGBO(65, 67, 76, 1)
                                                : const Color.fromRGBO(230, 241, 254, 1),
                                            width: 1.2),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: getWidth(context, 20),
                                          ),
                                          SizedBox(
                                            width: 10,
                                            child: Text(
                                              sex ? 'М' : 'Ж',
                                              style: TextLocalStyles.roboto500.copyWith(
                                                color: const Color.fromRGBO(157, 167, 176, 1),
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          SizedBox(
                                            width: getWidth(context, 17),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              sex = !sex;
                                              setState(() {});
                                            },
                                            child: SizedBox(
                                              height: getHeight(context, 36),
                                              width: getHeight(context, 36),
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(98, 198, 170, 0.25),
                                                  border: Border.all(
                                                      color: const Color.fromRGBO(98, 198, 170, 1),
                                                      width: 1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    'assets/svg/arrow_down.svg',
                                                    width: getWidth(context, 24),
                                                    height: getHeight(context, 24),
                                                    colorFilter: const ColorFilter.mode(
                                                        Color.fromRGBO(82, 182, 154, 1),
                                                        BlendMode.srcIn),
                                                    // fit: BoxFit.scaleDown,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getHeight(context, 15),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Контактные данные',
                            style: TextLocalStyles.roboto400.copyWith(
                                color: state.isDark
                                    ? Colors.white
                                    : const Color.fromRGBO(22, 26, 29, 1),
                                fontSize: 14,
                                height: 16.41 / 14),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: textFieldRegistration(
                                context,
                                186,
                                isPressedContactData == 0
                                    ? 'Телефон'
                                    : isPressedContactData == 1
                                        ? '@'
                                        : 'example@mail.ru',
                                isPressedContactData == 0
                                    ? phone
                                    : isPressedContactData == 1
                                        ? telegram
                                        : email,
                                false,
                                textFieldColor[2],
                                isPressedContactData == 2 ? true : false,
                              ),
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            InkWell(
                              onTap: () {
                                isPressedContactData = 0;
                                setState(() {});
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: iconTextFieldRegistration(
                                context,
                                'assets/svg/registration_phone.svg',
                                isPressedContactData == 0,
                                const Color.fromRGBO(110, 210, 182, 1),
                              ),
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            InkWell(
                              onTap: () {
                                isPressedContactData = 1;
                                setState(() {});
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: iconTextFieldRegistration(
                                context,
                                'assets/svg/registration_telegram.svg',
                                isPressedContactData == 1,
                                const Color.fromRGBO(163, 153, 210, 1),
                              ),
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            InkWell(
                              onTap: () {
                                isPressedContactData = 2;
                                setState(() {});
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: iconTextFieldRegistration(
                                context,
                                'assets/svg/registration_email.svg',
                                isPressedContactData == 2,
                                const Color.fromRGBO(241, 171, 193, 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(context, 13),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Контактные данные',
                            style: TextLocalStyles.roboto400.copyWith(
                                color: state.isDark
                                    ? Colors.white
                                    : const Color.fromRGBO(22, 26, 29, 1),
                                fontSize: 14,
                                height: 16.41 / 14),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: textFieldRegistration(
                                  context,
                                  343,
                                  isPressed ? 'Россия' : 'Москва',
                                  isPressed ? country : city,
                                  false,
                                  textFieldColor[3],
                                  true),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                if (isPressed == false) isPressed = !isPressed;
                                setState(() {});
                              },
                              child: iconCountry(
                                context,
                                isPressed,
                                const Color.fromRGBO(163, 153, 210, 1),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            InkWell(
                              onTap: () {
                                if (isPressed == true) isPressed = !isPressed;
                                setState(() {});
                              },
                              child: iconCity(
                                context,
                                !isPressed,
                                const Color.fromRGBO(241, 171, 193, 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(context, 25),
                        ),
                        Text(
                          'Редактировать данные при повторном входе\nможно будет в группе контактов “Семья”',
                          style: TextLocalStyles.roboto400.copyWith(
                            color: state.isDark
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(57, 57, 57, 1),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: getHeight(context, 32),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: getHeight(context, 62),
                              width: getHeight(context, 62),
                              child: image == null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          const AssetImage('assets/images/upload_image.png'),
                                      backgroundColor: state.isDark
                                          ? AppTheme.backgroundColor
                                          : const Color.fromRGBO(240, 247, 254, 1),
                                    )
                                  : Image.memory(
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const Expanded(child: SizedBox()),
                            InkWell(
                              onTap: () async {
                                image = await Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const PickImageScreen()));
                                setState(() {});
                              },
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: getHeight(context, 52),
                                    width: getWidth(context, 270),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: state.isDark
                                              ? const Color.fromRGBO(52, 54, 62, 1)
                                              : const Color.fromRGBO(250, 255, 255, 1),
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: getHeight(context, 36),
                                            width: getHeight(context, 36),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(98, 198, 170, 0.1),
                                                border: Border.all(
                                                    color: const Color.fromRGBO(98, 198, 170, 1)),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Align(
                                                child: SvgPicture.asset(
                                                  'assets/svg/miniplus.svg',
                                                  colorFilter: const ColorFilter.mode(
                                                      Color.fromRGBO(82, 182, 154, 1),
                                                      BlendMode.srcIn),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Загрузить фотографию',
                                            style: TextLocalStyles.roboto400.copyWith(
                                              color: state.isDark
                                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                                  : const Color.fromRGBO(22, 26, 29, 1),
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getHeight(context, 52),
                                    width: getWidth(context, 270),
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(4),
                                      color: const Color.fromRGBO(98, 198, 170, 1),
                                      dashPattern: const [6, 6],
                                      //padding: EdgeInsets.all(6),
                                      child: const ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        child: SizedBox(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getHeight(context, 61),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: buttonGreen(
                            context,
                            height: 52,
                            width: 166,
                            title: 'Сохранить',
                            fontSize: 16,
                            onTap: () {
                              String birthdayDDMMYY = '';

                              textFieldColor[1] = const Color.fromRGBO(66, 157, 132, 1);
                              String dmy = birthday.text;
                              int? day = int.tryParse(dmy.substring(0, dmy.indexOf('.', 0)));
                              dmy = dmy.substring(dmy.indexOf('.', 0) + 1);
                              int? month = int.tryParse(dmy.substring(0, dmy.indexOf('.', 0)));
                              dmy = dmy.substring(dmy.indexOf('.', 0) + 1);
                              int? year = int.tryParse(dmy.substring(
                                0,
                              ));
                              if (day! < 1 || day > 31 || month! < 1 || month > 12) {
                                textFieldColor[1] = Colors.red;
                                isOk = false;
                              } else {
                                birthdayDDMMYY = '$year-$month-$day';
                              }

                              print(isOk);

                              print(birthdayDDMMYY);
                              if (isOk) {
                                context.read<AuthorizationBloc>().add(
                                      ChangeDataEvent(
                                        username: name.text,
                                        photo: image,
                                        region: '${country.text}, ${city.text}',
                                        birthday: birthdayDDMMYY,
                                        sex: sex,
                                        email: email.text,
                                      ),
                                    );
                                Timer(
                                  const Duration(milliseconds: 500),
                                      () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const Screen30(bloggerId: 45),
                                        ),
                                      );
                                  },
                                );
                              } else {
                                setState(() {});
                                Timer(
                                  const Duration(seconds: 2),
                                  () {
                                    textColor = const Color.fromRGBO(188, 192, 200, 1);
                                    textColorDark = const Color.fromRGBO(98, 118, 132, 1);
                                    textFieldColor = [
                                      context.read<ThemeBloc>().state.postcardContainerBorderColor,
                                      context.read<ThemeBloc>().state.postcardContainerBorderColor,
                                      context.read<ThemeBloc>().state.postcardContainerBorderColor,
                                      context.read<ThemeBloc>().state.postcardContainerBorderColor
                                    ];
                                    setState(() {});
                                  },
                                );
                              }
                            },
                            isActive: isOk,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget iconTextFieldRegistration(BuildContext context, icon, isPressed, color) {
    return SizedBox(
      height: getHeight(context, 52),
      width: getHeight(context, 52),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: context.read<ThemeBloc>().state.postcardContainerBorderColor,
            width: 1.2,
          ),
          //color: Color.fromRGBO(52, 54, 62, 1),
          gradient: context.read<ThemeBloc>().state.isDark
              ? isPressed
                  ? const LinearGradient(colors: [
                      Color.fromRGBO(74, 79, 85, 1),
                      Color.fromRGBO(44, 49, 55, 1),
                    ], end: Alignment.topLeft, begin: Alignment.bottomRight)
                  : const LinearGradient(colors: [
                      Color.fromRGBO(74, 79, 85, 1),
                      Color.fromRGBO(44, 49, 55, 1),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)
              : isPressed
                  ? const LinearGradient(colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(224, 236, 250, 1),
                    ], end: Alignment.topLeft, begin: Alignment.bottomRight)
                  : const LinearGradient(colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(224, 236, 250, 1),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: context.read<ThemeBloc>().state.isDark
              ? [
                  const BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 10,
                    color: Color.fromRGBO(27, 32, 38, 0.4),
                  ),
                  const BoxShadow(
                    offset: Offset(-4, -4),
                    blurRadius: 10,
                    color: Color.fromRGBO(50, 55, 61, 1),
                  ),
                ]
              : [
                  const BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 10,
                    color: Color.fromRGBO(154, 189, 230, 0.25),
                  ),
                  const BoxShadow(
                    offset: Offset(-4, -4),
                    blurRadius: 10,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ],
        ),
        child: SvgPicture.asset(
          icon,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget iconCountry(BuildContext context, isPressed, color) {
    return SizedBox(
      height: getHeight(context, 52),
      width: getHeight(context, 52),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: context.read<ThemeBloc>().state.postcardContainerBorderColor,
            width: 1.2,
          ),
          //color: Color.fromRGBO(52, 54, 62, 1),
          gradient: context.read<ThemeBloc>().state.isDark
              ? isPressed
                  ? const LinearGradient(colors: [
                      Color.fromRGBO(74, 79, 85, 1),
                      Color.fromRGBO(44, 49, 55, 1),
                    ], end: Alignment.topLeft, begin: Alignment.bottomRight)
                  : const LinearGradient(colors: [
                      Color.fromRGBO(74, 79, 85, 1),
                      Color.fromRGBO(44, 49, 55, 1),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)
              : isPressed
                  ? const LinearGradient(colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(224, 236, 250, 1),
                    ], end: Alignment.topLeft, begin: Alignment.bottomRight)
                  : const LinearGradient(colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(224, 236, 250, 1),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: context.read<ThemeBloc>().state.isDark
              ? [
                  const BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 10,
                    color: Color.fromRGBO(27, 32, 38, 0.4),
                  ),
                  const BoxShadow(
                    offset: Offset(-4, -4),
                    blurRadius: 10,
                    color: Color.fromRGBO(50, 55, 61, 1),
                  ),
                ]
              : [
                  const BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 10,
                    color: Color.fromRGBO(154, 189, 230, 0.25),
                  ),
                  const BoxShadow(
                    offset: Offset(-4, -4),
                    blurRadius: 10,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              child: Image.asset(
                'assets/images/image 415.png',
                fit: BoxFit.fill,
              ),
            ),
            Image.asset(
              'assets/images/image 414.png',
              height: getHeight(context, 25),
              fit: BoxFit.fitHeight,
            )
          ],
        ),
      ),
    );
  }

  Widget iconCity(BuildContext context, isPressed, color) {
    return SizedBox(
      height: getHeight(context, 52),
      width: getHeight(context, 52),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: context.read<ThemeBloc>().state.postcardContainerBorderColor,
            width: 1.2,
          ),
          gradient: context.read<ThemeBloc>().state.isDark
              ? isPressed
                  ? const LinearGradient(colors: [
                      Color.fromRGBO(74, 79, 85, 1),
                      Color.fromRGBO(44, 49, 55, 1),
                    ], end: Alignment.topLeft, begin: Alignment.bottomRight)
                  : const LinearGradient(colors: [
                      Color.fromRGBO(74, 79, 85, 1),
                      Color.fromRGBO(44, 49, 55, 1),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)
              : isPressed
                  ? const LinearGradient(colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(224, 236, 250, 1),
                    ], end: Alignment.topLeft, begin: Alignment.bottomRight)
                  : const LinearGradient(colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(224, 236, 250, 1),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: context.read<ThemeBloc>().state.isDark
              ? [
                  const BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 10,
                    color: Color.fromRGBO(27, 32, 38, 0.4),
                  ),
                  const BoxShadow(
                    offset: Offset(-4, -4),
                    blurRadius: 10,
                    color: Color.fromRGBO(50, 55, 61, 1),
                  ),
                ]
              : [
                  const BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 10,
                    color: Color.fromRGBO(154, 189, 230, 0.25),
                  ),
                  const BoxShadow(
                    offset: Offset(-4, -4),
                    blurRadius: 10,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ],
        ),
        child: Image.asset(
          'assets/images/image 416.png',
          height: getHeight(context, 35),
        ),
      ),
    );
  }

  Widget textFieldRegistration(
      BuildContext context, width, hintText, controller, isbirthday, textFieldColor, isActive) {
    final OutlineInputBorder outlinedBorder = OutlineInputBorder(
        borderSide: BorderSide(
      color: textFieldColor,
      width: 1.2,
    ));
    return SizedBox(
      height: getHeight(context, 52),
      child: TextField(
        textInputAction: TextInputAction.done,
        controller: controller,
        enabled: isActive,
        textAlignVertical: const TextAlignVertical(y: 0.5),
        style: TextLocalStyles.roboto400.copyWith(
          color: context.read<ThemeBloc>().state.isDark
              ? const Color.fromRGBO(244, 199, 217, 1)
              : const Color.fromRGBO(166, 173, 181, 1),
          fontSize: 16,
          // height:
        ),
        obscureText: isbirthday,
        decoration: InputDecoration(
          border: outlinedBorder.copyWith(borderRadius: BorderRadius.circular(6)),
          focusedBorder: outlinedBorder.copyWith(borderRadius: BorderRadius.circular(6)),
          enabledBorder: outlinedBorder.copyWith(borderRadius: BorderRadius.circular(6)),
          disabledBorder: outlinedBorder.copyWith(borderRadius: BorderRadius.circular(6)),
          hintText: hintText,
          hintStyle: TextLocalStyles.roboto400.copyWith(
              color: context.read<ThemeBloc>().state.isDark
                  ? const Color.fromRGBO(105, 113, 119, 1)
                  : const Color.fromRGBO(166, 173, 181, 1),
              fontSize: getHeight(context, 14),
              height: 22 / 14),
          fillColor: context.read<ThemeBloc>().state.isDark
              ? const Color.fromRGBO(52, 54, 62, 1)
              : const Color.fromRGBO(250, 255, 255, 1),
          filled: true,
        ),
      ),
    );
  }
}
