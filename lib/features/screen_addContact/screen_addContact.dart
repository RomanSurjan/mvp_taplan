// ignore_for_file: file_names

import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_event.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_12/screen_pickImage.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class ScreenAddContact extends StatefulWidget {
  final int groupId;
  final Map contacts;

  const ScreenAddContact({
    super.key,
    required this.groupId,
    required this.contacts,
  });

  @override
  State<ScreenAddContact> createState() => _ScreenAddContactState();
}

class _ScreenAddContactState extends State<ScreenAddContact> {
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
  bool sex = false;
  String authToken = '';
  bool isActive = false;
  String code = '';
  bool isPressedBirthday = true;

  //late Map contacts;
  List<String> groupName = [
    'Семья',
    'Друзья',
    'Близкие',
    'Коллеги',
    'Партнеры'
  ];
  int idGroup = 0;
  late String group;

  Map buffContacts = {};
  Map visibleContacts = {};

  bool isPressed = true;

  int isPressedContactData = 0;
  late int id;

  Uint8List? image;

  double getHeight(BuildContext context, double height) {
    return height / 768 * MediaQuery.of(context).size.height;
  }

  double getWidth(BuildContext context, double width) {
    return width / 375 * MediaQuery.of(context).size.width;
  }

  void _saveContact(
    String name,
    String phoneNumber,
    String birthday,
    String sex,
    String telegram,
    String region,
    String cat,
    Uint8List? image,
  ) async {
    FormData formData;
    if (image != null) {
      // var photo = MultipartFile.fromBytes(
      //   image,
      //   filename: 'image.png',
      //   contentType: MediaType("image", "png"),
      // );
      formData = FormData.fromMap({
        'name': name,
        'birthday': birthday,
        'phoneNumber': phoneNumber,
        'telegram': telegram,
        'email': email.text,
        'region': region,
        'cat': cat,
        //'person_photo': photo,
      });
    } else {
      formData = FormData.fromMap({
        'name': name,
        'birthday': birthday,
        'phoneNumber': phoneNumber,
        'telegram': telegram,
        'email': email.text,
        'region': region,
        'cat': cat,
      });
    }

    try {
      final response = await Dio().post(
        'https://qviz.fun/api/v1/people/',
        data: formData,
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
            'Authorization':
                "Token ${context.read<AuthorizationBloc>().state.authToken}",
          },
        ),
      );
      if (response.data['id'] != null) {
        textFieldColor[0] = const Color.fromRGBO(66, 157, 132, 1);
        textFieldColor[1] = const Color.fromRGBO(66, 157, 132, 1);
        textFieldColor[2] = const Color.fromRGBO(66, 157, 132, 1);
        textFieldColor[3] = const Color.fromRGBO(66, 157, 132, 1);
        setState(() {});

        Future.delayed(const Duration(milliseconds: 400), () {
          Navigator.pop(context);
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();

    log(widget.contacts['people'].length.toString());

    int length = 0;
    for (int k = 0;
        k < int.parse(widget.contacts['people'].length.toString());
        k++) {
      if (widget.contacts['people'][k]['cat'] == (widget.groupId + 1)) {
        buffContacts[widget.contacts['people'][k]['id']] =
            widget.contacts['people'][k];
      }
    }

    visibleContacts.clear();

    buffContacts.forEach((key, value) {
      visibleContacts[length] = buffContacts[key];
      visibleContacts[length]['add'] = true;
      length++;
    });
    log(visibleContacts.length.toString());
    log(visibleContacts.toString());

    group = groupName[widget.groupId];
    idGroup = widget.groupId;

    id = visibleContacts.length;

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
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      builder: (context, state) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: state.isDark
                  ? AppTheme.backgroundColor
                  : const Color.fromRGBO(240, 247, 254, 1),
              appBar: CustomAppBarRegistration(
                name:
                    'Данные члена группы\n“$group” (${id + 1}/${visibleContacts.length + 1})',
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
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getHeight(context, 41),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: getWidth(context, 235),
                              child: textFieldRegistration(
                                context,
                                235,
                                'Имя члена группы',
                                name,
                                false,
                                textFieldColor[0],
                              ),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () {
                                id--;
                                if (id < 0) {
                                  id = visibleContacts.length;
                                  name = TextEditingController(text: '');
                                  birthday = TextEditingController(text: '');
                                  phone = TextEditingController(text: '');
                                  telegram = TextEditingController(text: '');
                                  email = TextEditingController(text: '');
                                  city = TextEditingController(text: '');
                                  country = TextEditingController(text: '');
                                } else {
                                  name = TextEditingController(
                                      text: visibleContacts[id]['name']);
                                  birthday = TextEditingController(
                                      text: visibleContacts[id]['birthday']
                                          .toString());
                                  phone = TextEditingController(
                                      text: visibleContacts[id]['phone']);
                                  telegram = TextEditingController(
                                      text: visibleContacts[id]['telegram']);
                                  email = TextEditingController(
                                      text: visibleContacts[id]['email']);
                                  city = TextEditingController(
                                      text: visibleContacts[id]['region']);
                                }
                                setState(() {});
                              },
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
                                    'assets/svg/arrow_left_mini.svg',
                                    width: getWidth(context, 24),
                                    height: getHeight(context, 24),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () {
                                id++;
                                if (id == visibleContacts.length) {
                                  name = TextEditingController(text: '');
                                  birthday = TextEditingController(text: '');
                                  phone = TextEditingController(text: '');
                                  telegram = TextEditingController(text: '');
                                  email = TextEditingController(text: '');
                                  city = TextEditingController(text: '');
                                  country = TextEditingController(text: '');
                                } else {
                                  if (id > visibleContacts.length) {
                                    id = 0;
                                  }
                                  name = TextEditingController(
                                      text: visibleContacts[id]['name']);
                                  birthday = TextEditingController(
                                      text: visibleContacts[id]['birthday']
                                          .toString());
                                  phone = TextEditingController(
                                      text: visibleContacts[id]['phone']);
                                  telegram = TextEditingController(
                                      text: visibleContacts[id]['telegram']);
                                  email = TextEditingController(
                                      text: visibleContacts[id]['email']);
                                  city = TextEditingController(
                                      text: visibleContacts[id]['region']);
                                  //country = TextEditingController(text: visibleContacts[id]['region'].substring(visibleContacts[id]['region'].toString().indexOf('-')+1,),);
                                }
                                setState(() {});
                              },
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
                                    'assets/svg/arrow_right_mini.svg',
                                    width: getWidth(context, 24),
                                    height: getHeight(context, 24),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                                            : const Color.fromRGBO(
                                                22, 26, 29, 1),
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    textFieldRegistration(
                                      context,
                                      235,
                                      'ДД.ММ.ГГГГ',
                                      birthday,
                                      false,
                                      textFieldColor[1],
                                    ),
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
                                        color: context
                                                .read<ThemeBloc>()
                                                .state
                                                .isDark
                                            ? const Color.fromRGBO(
                                                52, 54, 62, 1)
                                            : const Color.fromRGBO(
                                                250, 255, 255, 1),
                                        border: Border.all(
                                            color: context
                                                    .read<ThemeBloc>()
                                                    .state
                                                    .isDark
                                                ? const Color.fromRGBO(
                                                    65, 67, 76, 1)
                                                : const Color.fromRGBO(
                                                    230, 241, 254, 1),
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
                                              style: TextLocalStyles.roboto500
                                                  .copyWith(
                                                color: const Color.fromRGBO(
                                                    157, 167, 176, 1),
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
                                                  color: const Color.fromRGBO(
                                                      98, 198, 170, 0.25),
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromRGBO(
                                                              98, 198, 170, 1),
                                                      width: 1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    'assets/svg/arrow_down.svg',
                                                    width:
                                                        getWidth(context, 24),
                                                    height:
                                                        getHeight(context, 24),
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            Color.fromRGBO(82,
                                                                182, 154, 1),
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
                              ),
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
                          height: getHeight(context, 10),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Статус отношений',
                            style: TextLocalStyles.roboto400.copyWith(
                                color: state.isDark
                                    ? Colors.white
                                    : const Color.fromRGBO(22, 26, 29, 1),
                                fontSize: 14,
                                height: 16.41 / 14),
                          ),
                        ),
                        SizedBox(
                          width: getWidth(context, 343),
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
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: getWidth(context, 15),
                                ),
                                Text(
                                  group,
                                  style: TextLocalStyles.roboto500.copyWith(
                                    color: context
                                            .read<ThemeBloc>()
                                            .state
                                            .isDark
                                        ? Colors.white
                                        : const Color.fromRGBO(57, 57, 57, 1),
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  width: getWidth(context, 70),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(18),
                                      onTap: () {
                                        idGroup--;
                                        if (idGroup < 0) idGroup = 4;
                                        group = groupName[idGroup];

                                        int length = 0;
                                        buffContacts.clear();
                                        for (int k = 0;
                                            k <
                                                int.parse(widget
                                                    .contacts['people'].length
                                                    .toString());
                                            k++) {
                                          if (widget.contacts['people'][k]
                                                  ['cat'] ==
                                              (idGroup + 1)) {
                                            buffContacts[
                                                    widget.contacts['people'][k]
                                                        ['id']] =
                                                widget.contacts['people'][k];
                                          }
                                        }

                                        visibleContacts.clear();

                                        buffContacts.forEach((key, value) {
                                          visibleContacts[length] =
                                              buffContacts[key];
                                          visibleContacts[length]['add'] = true;
                                          length++;
                                        });
                                        log(visibleContacts.length.toString());
                                        log(visibleContacts.toString());

                                        id = visibleContacts.length;

                                        setState(() {});
                                      },
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
                                            'assets/svg/arrow_left_mini.svg',
                                            width: getWidth(context, 24),
                                            height: getHeight(context, 24),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 9,
                                    ),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(18),
                                      onTap: () {
                                        idGroup++;
                                        if (idGroup > 4) idGroup = 0;
                                        group = groupName[idGroup];

                                        int length = 0;
                                        buffContacts.clear();
                                        for (int k = 0;
                                            k <
                                                int.parse(widget
                                                    .contacts['people'].length
                                                    .toString());
                                            k++) {
                                          if (widget.contacts['people'][k]
                                                  ['cat'] ==
                                              (idGroup + 1)) {
                                            buffContacts[
                                                    widget.contacts['people'][k]
                                                        ['id']] =
                                                widget.contacts['people'][k];
                                          }
                                        }

                                        visibleContacts.clear();

                                        buffContacts.forEach((key, value) {
                                          visibleContacts[length] =
                                              buffContacts[key];
                                          visibleContacts[length]['add'] = true;
                                          length++;
                                        });
                                        log(visibleContacts.length.toString());
                                        log(visibleContacts.toString());

                                        id = visibleContacts.length;

                                        setState(() {});
                                      },
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
                                            'assets/svg/arrow_right_mini.svg',
                                            width: getWidth(context, 24),
                                            height: getHeight(context, 24),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getWidth(context, 8),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getHeight(context, 25),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: getHeight(context, 62),
                              width: getHeight(context, 62),
                              child: image == null
                                  ? CircleAvatar(
                                      backgroundImage: const AssetImage(
                                          'assets/images/upload_image.png'),
                                      backgroundColor: state.isDark
                                          ? AppTheme.backgroundColor
                                          : const Color.fromRGBO(
                                              240, 247, 254, 1),
                                    )
                                  : Image.memory(
                                      image!,
                                      fit: BoxFit.cover,
                                    ), //Image.file(imageFile!),),
                            ),
                            const Expanded(child: SizedBox()),
                            InkWell(
                              onTap: () async {
                                image = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const PickImageScreen()));
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
                                              ? const Color.fromRGBO(
                                                  52, 54, 62, 1)
                                              : const Color.fromRGBO(
                                                  250, 255, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: getHeight(context, 36),
                                            width: getHeight(context, 36),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    98, 198, 170, 0.1),
                                                border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        98, 198, 170, 1)),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Align(
                                                child: SvgPicture.asset(
                                                  'assets/svg/miniplus.svg',
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          Color.fromRGBO(
                                                              82, 182, 154, 1),
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
                                            style: TextLocalStyles.roboto400
                                                .copyWith(
                                              color: state.isDark
                                                  ? const Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : const Color.fromRGBO(
                                                      22, 26, 29, 1),
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
                                      color:
                                          const Color.fromRGBO(98, 198, 170, 1),
                                      dashPattern: const [6, 6],
                                      //padding: EdgeInsets.all(6),
                                      child: const ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
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
                          height: getHeight(context, 48),
                        ),
                        Row(
                          children: [
                            buttonGreen(
                                context,
                                52,
                                166,
                                'Календарь событий\nчлена группы',
                                16,
                                () {},
                                false),
                            const SizedBox(
                              width: 11,
                            ),
                            buttonGreen(
                              context,
                              52,
                              166,
                              'Сохранить',
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
                                String birthdayDDMMYY = '';

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
                                  int? year = int.tryParse(dmy.substring(
                                    0,
                                  ));
                                  if (day! < 1 ||
                                      day > 31 ||
                                      month! < 1 ||
                                      month > 12) {
                                    textFieldColor[1] = Colors.red;
                                    isOk = false;
                                  } else {
                                    birthdayDDMMYY = '$year-$month-$day';
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
                                  _saveContact(
                                      name.text,
                                      phone.text,
                                      birthdayDDMMYY,
                                      sex.toString(),
                                      telegram.text,
                                      city.text,
                                      (idGroup + 1).toString(),
                                      image);
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
                ),
              ),
            );
          },
        );
      },
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
                      Color.fromRGBO(98, 198, 170, 0.3),
                      Color.fromRGBO(68, 168, 140, 0.3),
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
                color: const Color.fromRGBO(110, 210, 182, 1),
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
      height: getHeight(context, 52),
      child: TextField(
        textInputAction: TextInputAction.done,
        controller: controller,
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
