// ignore_for_file: file_names

import 'dart:async';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_event.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_26/screen_26.dart';
import 'package:mvp_taplan/features/screen_35/screen_35.dart';
import 'package:mvp_taplan/models/buttons.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class ScreenSendWishlist extends StatefulWidget {
  const ScreenSendWishlist({
    super.key,
  });

  @override
  State<ScreenSendWishlist> createState() => _ScreenSendWishlistState();
}

class _ScreenSendWishlistState extends State<ScreenSendWishlist> {
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
  bool isOk = true;
  final TextEditingController _textFieldScroll = TextEditingController(text: 'Привет,\nя прошел(а) тест на определение желанных подарков, от которых я испытываю искренюю радость. Я хотел(а) бы получить один из этих подарков, что удовлетоврит мою потребность в эстетическом удовольствии, гармонии и внимании близкого человека.Буду искренне благодарен(а) желанному подарку.');

  bool isPressedBirthday = true;

  bool isPressed = true;
  List<bool> buttonNavIsPressed = [false, false, false, true, false];

  int isPressedContactData = 0;
  late int id;

  Uint8List? image;

  static const List<String> buttonGroupText = [
    "Авторские\nбукеты",
    "Ювелирные\nукрашение",
    "Картины\nхудожников",
    "Авторские\nфотографии",
    "Скульптура\nи декор",
  ];
  static const List<String> buttonGroupPicture = [
    "assets/images/icon60-1.png",
    "assets/images/icon61-1.png",
    "assets/images/icon64-1.png",
    "assets/images/icon65-1.png",
    "assets/images/icon62-1.png",
  ];

  List<bool> buttonGroupIsPressed = [true, false, false, false, false];

  double getHeight(BuildContext context, double height) {
    return height / 768 * MediaQuery.of(context).size.height;
  }

  double getWidth(BuildContext context, double width) {
    return width / 375 * MediaQuery.of(context).size.width;
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

    telegram.addListener(() {
      String value = telegram.text;
      RegExp regExpTaghandle = RegExp(r"@\w+");
      String tag = '@';
      Iterable matches = regExpTaghandle.allMatches(value);
      if (matches.isEmpty) {
        telegram.value = telegram.value.copyWith(
          text: tag,
          selection:
              TextSelection(baseOffset: tag.length, extentOffset: tag.length),
          composing: TextRange.empty,
        );
      }
      for (var match in matches) {
        // tagHandle = value.substring(match.start, match.end);
        // _callToAction(tagHandle);
        tag = value.substring(match.start, match.end);
        telegram.value = telegram.value.copyWith(
          text: tag,
          selection:
              TextSelection(baseOffset: tag.length, extentOffset: tag.length),
          composing: TextRange.empty,
        );
        break;
      }
    });
    phone.addListener(() {
      String value = phone.text;
      RegExp regExpTaghandle = RegExp(r"^\+\d{0,11}$");
      String tag = '+7';
      if (phone.text.isEmpty || phone.text == '+') {
        phone.value = phone.value.copyWith(
          text: tag,
          selection:
              TextSelection(baseOffset: tag.length, extentOffset: tag.length),
          composing: TextRange.empty,
        );
      } else if (regExpTaghandle.hasMatch(value)) {
        //print('phone true');
      } else {
        String text = value.substring(0, value.length - 1);
        phone.value = phone.value.copyWith(
          text: text,
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: state.isDark
                  ? AppTheme.backgroundColor
                  : const Color.fromRGBO(240, 247, 254, 1),
              appBar: CustomAppBarRegistration(
                name: 'Сообщить о\nСписке желаний',
                onTheme: () {
                  context
                      .read<ThemeBloc>()
                      .add(SwitchThemeEvent(isDark: !state.isDark));
                  setState(() {});

                  Timer(
                    const Duration(),
                    () {
                      textFieldColor = [
                        context
                            .read<ThemeBloc>()
                            .state
                            .postcardContainerBorderColor,
                        context
                            .read<ThemeBloc>()
                            .state
                            .postcardContainerBorderColor,
                        context
                            .read<ThemeBloc>()
                            .state
                            .postcardContainerBorderColor,
                        context
                            .read<ThemeBloc>()
                            .state
                            .postcardContainerBorderColor,
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
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: getHeight(context, 18),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Повод и текст сообщения: ',
                                style: TextLocalStyles.roboto400.copyWith(
                                  color: const Color.fromRGBO(240, 247, 254, 1),
                                  fontSize: 15,
                                  height: 17.58 / 15,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                SizedBox(
                                  width: getWidth(context, 343),
                                  child: textFieldRegistration(
                                    context,
                                    343,
                                    'Просто так',
                                    name,
                                    false,
                                    textFieldColor[0],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(18),
                                      onTap: () {},
                                      child: SizedBox(
                                        height: getHeight(context, 36),
                                        width: getHeight(context, 36),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: state.isDark ? const Color.fromRGBO(62, 64, 72, 1) : const Color.fromRGBO(219,233,244,1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/svg/arrow_right_mini.svg',
                                            width: getWidth(context, 24),
                                            height: getHeight(context, 24),
                                            fit: BoxFit.scaleDown,
                                            colorFilter: const ColorFilter.mode(
                                                Color.fromRGBO(175, 182, 189, 1),
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getHeight(context, 6),
                            ),
                            SizedBox(
                              height: getHeight(context, 115),
                              width: getWidth(context, 343),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: context.read<ThemeBloc>().state.postcardContainerBorderColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  color: state.isDark ? const Color.fromRGBO(52, 54, 62, 1) : const Color.fromRGBO(250,255,255,1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: RawScrollbar(
                                      thumbVisibility: true,
                                      radius: Radius.circular(getWidth(context, 8)),
                                      thickness: 5,
                                      trackVisibility: true,
                                      trackColor: state.isDark ? const Color.fromRGBO(61, 63, 71, 1) : Colors.transparent,
                                      thumbColor:
                                          state.isDark ? const Color.fromRGBO(73, 75, 83, 1) : const Color.fromRGBO(137,137,139, 1),
                                      trackRadius:
                                          Radius.circular(getWidth(context, 2)),
                                      // here's the actual text box
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 10),
                                        child: TextField(
                                          maxLines: null,
                                          controller: _textFieldScroll,
                                          style: TextLocalStyles.roboto400.copyWith(
                                            color: context
                                                    .read<ThemeBloc>()
                                                    .state
                                                    .isDark
                                                ? const Color.fromRGBO(
                                                    200, 210, 219, 1)
                                                : const Color.fromRGBO(
                                                    166, 173, 181, 1),
                                            fontSize: 14,
                                            // height:
                                          ),
                                          decoration: InputDecoration.collapsed(
                                            hintText: 'Текст сообщения',
                                            hintStyle: TextLocalStyles.roboto400
                                                .copyWith(
                                                    color: context
                                                            .read<ThemeBloc>()
                                                            .state
                                                            .isDark
                                                        ? const Color.fromRGBO(
                                                            105, 113, 119, 1)
                                                        : const Color.fromRGBO(
                                                            166, 173, 181, 1),
                                                    fontSize: 14,
                                                    height: 22 / 14),
                                          ),
                                        ),
                                      ),
                                      // ends the actual text box
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(context, 9),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Введите контактные данные для пересылки',
                                style: TextLocalStyles.roboto400.copyWith(
                                  color: state.isDark
                                      ? const Color.fromRGBO(240, 247, 254, 1)
                                      : const Color.fromRGBO(22, 26, 29, 1),
                                  fontSize: 15,
                                  height: 17.58 / 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getWidth(context, 343),
                              child: textFieldRegistration(
                                context,
                                343,
                                'Имя человека, для сообщения о желании',
                                name,
                                false,
                                textFieldColor[0],
                              ),
                            ),
                            SizedBox(
                              height: getHeight(context, 6),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: textFieldRegistration(
                                    context,
                                    167,
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
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
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
                                  width: 6,
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
                                  width: 6,
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
                                'Или данные tg-чата для пересылки',
                                style: TextLocalStyles.roboto400.copyWith(
                                    color: state.isDark
                                        ? const Color.fromRGBO(240, 247, 254, 1)
                                        : const Color.fromRGBO(22, 26, 29, 1),
                                    fontSize: 15,
                                    height: 16.41 / 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(context, 2),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: getWidth(context, 284),
                                  height: getHeight(context, 48),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: context.read<ThemeBloc>().state.isDark
                                          ? const Color.fromRGBO(52, 54, 62, 1)
                                          : const Color.fromRGBO(250, 255, 255, 1),
                                      border: Border.all(
                                        color: context
                                                .read<ThemeBloc>()
                                                .state
                                                .isDark
                                            ? const Color.fromRGBO(65, 67, 76, 1)
                                            : const Color.fromRGBO(
                                                230, 241, 254, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 12),
                                            child: Text(
                                              'Ваши группы из списка контактов',
                                              style: TextLocalStyles.roboto500
                                                  .copyWith(
                                                color: const Color.fromRGBO(
                                                    105, 113, 119, 1),
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: InkWell(
                                              onTap: () {},
                                              child: SvgPicture.asset(
                                                state.isDark ? 'assets/svg/more_button.svg' : 'assets/svg/more_button_light.svg',
                                                width: getWidth(context, 24),
                                                height: getHeight(context, 24),
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  onTap: () {},
                                  child: SizedBox(
                                    height: getHeight(context, 36),
                                    width: getHeight(context, 36),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            98, 198, 170, 0.25),
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                98, 198, 170, 1),
                                            width: 1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/svg/plus.svg',
                                        width: getWidth(context, 24),
                                        height: getHeight(context, 24),
                                        fit: BoxFit.scaleDown,
                                        colorFilter: const ColorFilter.mode(Color.fromRGBO(98, 198, 170, 1), BlendMode.srcIn),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getHeight(context, 20),
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Отправить список желаний',
                                style: TextLocalStyles.roboto400.copyWith(
                                  color: state.isDark
                                      ? const Color.fromRGBO(240, 247, 254, 1)
                                      : const Color.fromRGBO(22, 26, 29, 1),
                                  fontSize: 15,
                                  height: 17.58 / 15,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (int i = 0; i < 5; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                    child: ButtonGroupWish(
                                      colorMain:
                                          const Color.fromRGBO(110, 210, 182, 1),
                                      picture: buttonGroupPicture[i],
                                      colorCount:
                                          const Color.fromRGBO(198, 237, 226, 1),
                                      text: buttonGroupText[i],
                                      isPressed: buttonGroupIsPressed[i],
                                      onTap: () {
                                        buttonGroupIsPressed[i] = !buttonGroupIsPressed[i];
                                        setState(() {});
                                      },
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: getHeight(context, 32),
                            ),
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: getHeight(context, 52),
                                      width: getWidth(context, 166),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(98, 198, 170, 0.25),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: getHeight(context, 24),
                                              width: getHeight(context, 24),
                                              child: DecoratedBox(
                                                decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(98, 198, 170, 1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Align(
                                                  child: SizedBox(
                                                    height: getHeight(context, 24),
                                                    width: getHeight(context, 24),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/miniplus.svg',
                                                      colorFilter: const ColorFilter.mode(
                                                          Color.fromRGBO(240, 247, 254, 1),
                                                          BlendMode.srcIn),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              'Загрузить видео\n(до 10 Мбайт)',
                                              style: TextLocalStyles.roboto400.copyWith(
                                                color: const Color.fromRGBO(110, 210, 182, 1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w200,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: getHeight(context, 52),
                                      width: getWidth(context, 166),
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(6),
                                        color: const Color.fromRGBO(98, 198, 170, 1),
                                        dashPattern: const [13, 13],
                                        //padding: EdgeInsets.all(6),
                                        child: const ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                          child: SizedBox(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                buttonGreen(
                                  context,
                                  52,
                                  166,
                                  'Отправить',
                                  16,
                                  () {
                                    isOk = true;

                                    String value = phone.text;
                                    RegExp regExp = RegExp(r"^\+{0,1}\d{11}$");
                                    if (regExp.hasMatch(value)) {
                                      textFieldColor[2] =
                                          const Color.fromRGBO(66, 157, 132, 1);
                                    } else {
                                      textFieldColor[2] = Colors.red;
                                      isOk = false;
                                      isPressedContactData = 0;
                                    }

                                    value = birthday.text;
                                    // String birthdayDDMMYY = '';

                                    regExp = RegExp(r"^\d{1,2}\.\d{1,2}.\d{4}");
                                    if (regExp.hasMatch(value)) {
                                      textFieldColor[1] =
                                          const Color.fromRGBO(66, 157, 132, 1);
                                      String dmy = birthday.text;
                                      int? day = int.tryParse(
                                          dmy.substring(0, dmy.indexOf('.', 0)));
                                      dmy = dmy.substring(dmy.indexOf('.', 0) + 1);
                                      int? month = int.tryParse(
                                          dmy.substring(0, dmy.indexOf('.', 0)));
                                      dmy = dmy.substring(dmy.indexOf('.', 0) + 1);
                                      // int? year = int.tryParse(dmy.substring(
                                      //   0,
                                      // ));
                                      if (day! < 1 ||
                                          day > 31 ||
                                          month! < 1 ||
                                          month > 12) {
                                        textFieldColor[1] = Colors.red;
                                        isOk = false;
                                      } else {
                                        // birthdayDDMMYY = '$year-$month-$day';
                                      }
                                    } else {
                                      textFieldColor[1] = Colors.red;
                                      isOk = false;
                                    }

                                    value = email.text;
                                    regExp = RegExp(
                                        r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+$");
                                    if (regExp.hasMatch(value)) {
                                      textFieldColor[2] =
                                          const Color.fromRGBO(66, 157, 132, 1);
                                    } else {
                                      textFieldColor[2] = Colors.red;
                                      isOk = false;
                                      isPressedContactData = 2;
                                    }

                                    value = telegram.text;
                                    regExp = RegExp(r"^@\w+$");
                                    if (regExp.hasMatch(value)) {
                                      if (textFieldColor[2] != Colors.red) {
                                        textFieldColor[2] =
                                            const Color.fromRGBO(66, 157, 132, 1);
                                      }
                                    } else {
                                      textFieldColor[2] = Colors.red;
                                      isOk = false;
                                      isPressedContactData = 1;
                                    }

                                    value = name.text;
                                    if (value.isNotEmpty) {
                                      textFieldColor[0] =
                                          const Color.fromRGBO(66, 157, 132, 1);
                                    } else {
                                      textFieldColor[0] = Colors.red;
                                      isOk = false;
                                    }
                                    value = country.text;
                                    if (value.isNotEmpty) {
                                      textFieldColor[3] =
                                          const Color.fromRGBO(66, 157, 132, 1);
                                    } else {
                                      textFieldColor[3] = Colors.red;
                                      isOk = false;
                                      isPressed = true;
                                    }
                                    value = city.text;
                                    if (value.isNotEmpty) {
                                      textFieldColor[3] =
                                          const Color.fromRGBO(66, 157, 132, 1);
                                    } else {
                                      textFieldColor[3] = Colors.red;
                                      isOk = false;
                                      isPressed = false;
                                    }

                                    if (isOk) {
                                    } else {
                                      setState(() {});
                                      Timer(
                                        const Duration(seconds: 2),
                                        () {
                                          textColor = const Color.fromRGBO(
                                              188, 192, 200, 1);
                                          textColorDark =
                                              const Color.fromRGBO(98, 118, 132, 1);
                                          textFieldColor = [
                                            context
                                                .read<ThemeBloc>()
                                                .state
                                                .postcardContainerBorderColor,
                                            context
                                                .read<ThemeBloc>()
                                                .state
                                                .postcardContainerBorderColor,
                                            context
                                                .read<ThemeBloc>()
                                                .state
                                                .postcardContainerBorderColor,
                                            context
                                                .read<ThemeBloc>()
                                                .state
                                                .postcardContainerBorderColor
                                          ];
                                          setState(() {});
                                        },
                                      );
                                    }
                                  },
                                  true,
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      bottomNavBar(context),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return SizedBox(
      height: getHeight(context, 83),
      width: getWidth(context, 375),
      child: ColoredBox(
        color: context.read<ThemeBloc>().state.isDark
            ? const Color.fromRGBO(0, 0, 0, 0.25)
            : const Color.fromRGBO(235, 242, 249, 1),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth(context, 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNavButton(
                picture: 'assets/svg/home.svg',
                isPressed: buttonNavIsPressed[0],
                onTap: () {
                  buttonNavIsPressed[0] = !buttonNavIsPressed[0];
                  setState(() {});
                },
              ),
              BottomNavButton(
                picture: 'assets/svg/book_heart.svg',
                isPressed: buttonNavIsPressed[1],
                onTap: () {
                  buttonNavIsPressed[1] = !buttonNavIsPressed[1];
                  setState(() {});
                },
              ),
              BottomNavCenterButton(
                  isPressed: buttonNavIsPressed[2],
                  onTap: () {
                    buttonNavIsPressed[2] = !buttonNavIsPressed[2];
                    setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Screen26(),
                      ),
                    );
                  }),
              BottomNavButton(
                picture: 'assets/svg/sharenav.svg',
                isPressed: buttonNavIsPressed[3],
                onTap: () {
                  setState(() {});
                },
              ),
              BottomNavButton(
                picture: 'assets/svg/stars.svg',
                isPressed: buttonNavIsPressed[4],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Screen35(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconTextFieldRegistration(
      BuildContext context, icon, isPressed, color) {
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

  Widget buttonGreen(
      BuildContext context, height, width, title, fontSize, onTap, active) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: SizedBox(
        width: getWidth(context, width),
        height: getHeight(context, height),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: active
                ? const LinearGradient(
                    colors: [
                      Color.fromRGBO(98, 198, 170, 0.1),
                      Color.fromRGBO(68, 168, 140, 0.1),
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromRGBO(98, 198, 170, 1),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextLocalStyles.roboto500.copyWith(
                color: const Color.fromRGBO(110, 210, 182, 0.5),
                fontSize: fontSize,
                height: 16.41 / 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldRegistration(BuildContext context, width, hintText,
      controller, isbirthday, textFieldColor) {
    final OutlineInputBorder outlinedBorder = OutlineInputBorder(
        borderSide: BorderSide(
      color: textFieldColor,
      width: 1.2,
    ));
    return SizedBox(
      height: getHeight(context, 48),
      child: TextField(
        textInputAction: TextInputAction.done,
        controller: controller,
        textAlignVertical: const TextAlignVertical(y: 0.5),
        style: TextLocalStyles.roboto400.copyWith(
          color: context.read<ThemeBloc>().state.isDark
              ? const Color.fromRGBO(200, 210, 219, 1)
              : const Color.fromRGBO(166, 173, 181, 1),
          fontSize: 14,
          // height:
        ),
        obscureText: isbirthday,
        decoration: InputDecoration(
          border:
              outlinedBorder.copyWith(borderRadius: BorderRadius.circular(6)),
          focusedBorder:
              outlinedBorder.copyWith(borderRadius: BorderRadius.circular(6)),
          enabledBorder:
              outlinedBorder.copyWith(borderRadius: BorderRadius.circular(6)),
          hintText: hintText,
          hintStyle: TextLocalStyles.roboto400.copyWith(
              color: context.read<ThemeBloc>().state.isDark
                  ? const Color.fromRGBO(105, 113, 119, 1)
                  : const Color.fromRGBO(166, 173, 181, 1),
              fontSize: 14,
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


