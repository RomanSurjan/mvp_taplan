// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_event.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_event.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_12/screen_pickImage.dart';
import 'package:mvp_taplan/features/screen_14/screen_14.dart';
import 'package:mvp_taplan/features/screen_15_registration/screen_15.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen12 extends StatefulWidget {
  final bool isPressed;

  const Screen12({
    super.key,
    required this.isPressed,
  });

  @override
  State<Screen12> createState() => _Screen12State();
}

class _Screen12State extends State<Screen12> {
  bool isPicked = false;
  Color textColor = const Color.fromRGBO(188, 192, 200, 1);
  Color textColorDark = const Color.fromRGBO(98, 118, 132, 1);
  TextEditingController name = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');
  TextEditingController phone = TextEditingController(text: '');
  TextEditingController telegram = TextEditingController(text: '');
  TextEditingController email = TextEditingController(text: '');
  TextEditingController city = TextEditingController(text: '');
  late List<Color> textFieldColor;
  bool isOk = true;
  String authToken = '';
  bool isActiveLogin = false;
  bool isActiveReg = false;
  String code = '';
  bool isPressedPassword = true;
  late Map responseData;

  bool isPressed = true;
  String? id;

  Uint8List? image;

  double getHeight(BuildContext context, double height) {
    return height / 768 * MediaQuery.of(context).size.height;
  }

  double getWidth(BuildContext context, double width) {
    return width / 375 * MediaQuery.of(context).size.width;
  }

  void _logIn(String password, String phoneNumber) async {
    try {
      final response = await Dio().post(
        'https://qviz.fun/auth/token/login/',
        data: {
          'phoneNumber': phoneNumber,
          'password': password,
        },
        options: Options(
          validateStatus: (status) {
            if (status == null) return false;
            return status < 500;
          },
        ),
      );
      authToken = response.data['auth_token'] ?? '';
      code = phoneNumber.substring(8);
      if (authToken == '') {
        textFieldColor[0] = Colors.red;
        textFieldColor[1] = Colors.red;

        setState(() {});
      } else {
        textFieldColor[0] = const Color.fromRGBO(66, 157, 132, 1);
        textFieldColor[1] = const Color.fromRGBO(66, 157, 132, 1);
        setState(() {});
        context.read<AuthorizationBloc>().add(
              SwitchAuthorizationEvent(
                authToken: authToken,
                code: phoneNumber.substring(8),
              ),
            );
        Future.delayed(
          const Duration(milliseconds: 400),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const Screen14(),
              ),
            );
          },
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  void _register(
    String password,
    String phoneNumber,
    String telegram,
    String email,
    Uint8List? image,
  ) async {
    if (phoneNumber[0] != '+') {
      phoneNumber = '+$phoneNumber';
    }
    FormData formData;
    if (image != null) {
      final photo = MultipartFile.fromBytes(
        image,
        filename: 'image.png',
        contentType: MediaType("image", "png"),
      );
      formData = FormData.fromMap({
        'username': 'User',
        'password': password,
        'phoneNumber': phoneNumber,
        'telegram': telegram,
        'email': email,
        'user_photo': photo,
      });
    } else {
      formData = FormData.fromMap({
        'username': 'User',
        'password': password,
        'phoneNumber': phoneNumber,
        'telegram': telegram,
        'email': email,
      });
    }

    try {
      final response = await Dio().post(
        'https://qviz.fun/api/v1/auth/users/',
        data: formData,
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      code = phoneNumber.substring(8);
      id = response.data['id'];
      responseData = response.data;
      if (id != null) {
        textFieldColor[0] = const Color.fromRGBO(66, 157, 132, 1);
        textFieldColor[1] = const Color.fromRGBO(66, 157, 132, 1);
        textFieldColor[2] = const Color.fromRGBO(66, 157, 132, 1);
        setState(() {});
        context.read<AuthorizationBloc>().add(
              SwitchAuthorizationEvent(
                authToken: '',
                code: phoneNumber.substring(8),
              ),
            );
        Future.delayed(
          const Duration(milliseconds: 400),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const Screen14(),
              ),
            );
          },
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  void _chekData() {
    isActiveLogin = true;
    isActiveReg = true;
    String value = phone.text;
    RegExp regExp = RegExp(r"^\+{0,1}\d{11}$");
    if (!regExp.hasMatch(value)) {
      isActiveLogin = false;
      isActiveReg = false;
    }
    value = password.text;
    if (!(value.length > 7)) {
      isActiveLogin = false;
      isActiveReg = false;
    }
    value = telegram.text;
    regExp = RegExp(r"^@\w{1,}$");
    if (!regExp.hasMatch(value)) {
      isActiveReg = false;
    }
    value = email.text;
    regExp = RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+$");
    if (!regExp.hasMatch(value)) {
      isActiveReg = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    textFieldColor = [
      context.read<ThemeBloc>().state.postcardContainerBorderColor,
      context.read<ThemeBloc>().state.postcardContainerBorderColor,
      context.read<ThemeBloc>().state.postcardContainerBorderColor
    ];
    isPicked = widget.isPressed;
    if (isPicked) {
      textColor = const Color.fromRGBO(98, 198, 170, 1);
    } else {
      textColor = const Color.fromRGBO(188, 192, 200, 1);
    }
    if (isPicked) {
      textColorDark = const Color.fromRGBO(98, 198, 170, 1);
    } else {
      textColorDark = const Color.fromRGBO(98, 118, 132, 1);
    }
    telegram.addListener(
      () {
        String value = telegram.text;
        RegExp regExp = RegExp(r"@\w+");
        String tag = '@';
        Iterable matches = regExp.allMatches(value);
        if (matches.isEmpty) {
          telegram.value = telegram.value.copyWith(
            text: tag,
            selection:
                TextSelection(baseOffset: tag.length, extentOffset: tag.length),
            composing: TextRange.empty,
          );
        }

        tag = value.substring(0);
        telegram.value = telegram.value.copyWith(
          text: tag,
          selection: TextSelection(
            baseOffset: tag.length,
            extentOffset: tag.length,
          ),
          composing: TextRange.empty,
        );

        _chekData();
      },
    );
    phone.addListener(() {
      String value = phone.text;
      RegExp regExp = RegExp(r"^\+\d{0,11}$");
      String tag = '+7';
      if (phone.text.isEmpty || phone.text == '+') {
        phone.value = phone.value.copyWith(
          text: tag,
          selection: TextSelection(
            baseOffset: tag.length,
            extentOffset: tag.length,
          ),
          composing: TextRange.empty,
        );
      } else if (!regExp.hasMatch(value)) {
        String text = value.substring(0, value.length - 1);
        phone.value = phone.value.copyWith(
          text: text,
          selection: TextSelection(
            baseOffset: text.length,
            extentOffset: text.length,
          ),
          composing: TextRange.empty,
        );
      }
      _chekData();
    });

    password.addListener(() {
      _chekData();
    });

    email.addListener(() {
      _chekData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: state.isDark
              ? AppTheme.backgroundColor
              : const Color.fromRGBO(240, 247, 254, 1),
          appBar: CustomAppBarRegistration(
            name: 'Сервис желанных подарков',
            onTheme: () {
              context.read<ThemeBloc>().add(
                    SwitchThemeEvent(isDark: !state.isDark),
                  );

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
                    context.read<ThemeBloc>().state.postcardContainerBorderColor
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
                      height: getHeight(context, 11),
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 1),
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Image.asset('assets/images/image 304.png'),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            children: [
                              // SizedBox(
                              //   height: getHeight(context, 18),
                              // ),
                              SizedBox(
                                height: getHeight(context, 80),
                                child: SvgPicture.asset(
                                    context.read<ThemeBloc>().state.isDark
                                        ? 'assets/svg/logo_light.svg'
                                        : 'assets/svg/logo.svg'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 11),
                    ),
                    Text(
                      'Данные для входа или регистрации:',
                      style: TextLocalStyles.roboto400.copyWith(
                        color: state.isDark
                            ? Colors.white
                            : const Color.fromRGBO(22, 26, 29, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 6),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: textFieldRegistration(
                            context,
                            295,
                            'Телефон',
                            phone,
                            false,
                            textFieldColor[0],
                          ),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        iconTextFieldRegistration(
                          context,
                          'assets/svg/registration_phone.svg',
                          false,
                          const Color.fromRGBO(110, 210, 182, 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 8),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: textFieldRegistration(
                            context,
                            343,
                            'Пароль(не менее 8-ми символов)',
                            password,
                            isPressedPassword,
                            textFieldColor[1],
                          ),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        InkWell(
                          onTap: () {
                            isPressedPassword = !isPressedPassword;
                            setState(() {});
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: getHeight(context, 52),
                            width: getHeight(context, 52),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: context
                                      .read<ThemeBloc>()
                                      .state
                                      .postcardContainerBorderColor,
                                  width: 1.2,
                                ),
                                //color: Color.fromRGBO(52, 54, 62, 1),
                                gradient: context.read<ThemeBloc>().state.isDark
                                    ? !isPressedPassword
                                        ? const LinearGradient(
                                            colors: [
                                                Color.fromRGBO(74, 79, 85, 1),
                                                Color.fromRGBO(44, 49, 55, 1),
                                              ],
                                            end: Alignment.topLeft,
                                            begin: Alignment.bottomRight)
                                        : const LinearGradient(
                                            colors: [
                                                Color.fromRGBO(74, 79, 85, 1),
                                                Color.fromRGBO(44, 49, 55, 1),
                                              ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight)
                                    : !isPressedPassword
                                        ? const LinearGradient(
                                            colors: [
                                                Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                Color.fromRGBO(
                                                    224, 236, 250, 1),
                                              ],
                                            end: Alignment.topLeft,
                                            begin: Alignment.bottomRight)
                                        : const LinearGradient(
                                            colors: [
                                                Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                Color.fromRGBO(
                                                    224, 236, 250, 1),
                                              ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight),
                                boxShadow: context
                                        .read<ThemeBloc>()
                                        .state
                                        .isDark
                                    ? [
                                        const BoxShadow(
                                          offset: Offset(4, 4),
                                          blurRadius: 10,
                                          color:
                                              Color.fromRGBO(27, 32, 38, 0.4),
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
                                          color: Color.fromRGBO(
                                              154, 189, 230, 0.25),
                                        ),
                                        const BoxShadow(
                                          offset: Offset(-4, -4),
                                          blurRadius: 10,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ],
                              ),
                              child: Image.asset(
                                'assets/images/password.png',
                                fit: BoxFit.scaleDown,
                                color: const Color.fromRGBO(255, 112, 162, 1),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 7),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        splashColor: isActiveLogin ? null : Colors.transparent,
                        highlightColor:
                            isActiveLogin ? null : Colors.transparent,
                        onTap: isActiveLogin
                            ? () {
                                isOk = true;

                                String value = phone.text;
                                RegExp regExp = RegExp(r"^\+{0,1}\d{11}$");
                                if (regExp.hasMatch(value)) {
                                  textFieldColor[0] =
                                      const Color.fromRGBO(66, 157, 132, 1);
                                } else {
                                  textFieldColor[0] = Colors.red;
                                  isOk = false;
                                }

                                value = password.text;
                                if (value.length > 7) {
                                  textFieldColor[1] =
                                      const Color.fromRGBO(66, 157, 132, 1);
                                } else {
                                  textFieldColor[1] = Colors.red;
                                  isOk = false;
                                }
                                if (isOk == true) {
                                  _logIn(password.text, phone.text);
                                }
                                Timer(const Duration(milliseconds: 500), () {
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
                                            .postcardContainerBorderColor
                                      ];
                                      setState(() {});
                                    },
                                  );
                                  setState(() {});
                                });
                              }
                            : null,
                        child: SizedBox(
                          height: getHeight(context, 48),
                          width: getWidth(context, 160),
                          child: SizedBox(
                            width: getWidth(context, 160),
                            height: getHeight(context, 48),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: isActiveLogin
                                    ? const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(98, 198, 170, 0.3),
                                          Color.fromRGBO(68, 168, 140, 0.3),
                                        ],
                                      )
                                    : const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(98, 198, 170, 0.1),
                                          Color.fromRGBO(68, 168, 140, 0.1),
                                        ],
                                      ),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isActiveLogin
                                      ? const Color.fromRGBO(98, 198, 170, 1)
                                      : const Color.fromRGBO(98, 198, 170, 0.5),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Войти',
                                    textAlign: TextAlign.center,
                                    style: TextLocalStyles.roboto500.copyWith(
                                        color: isActiveLogin
                                            ? const Color.fromRGBO(
                                                110, 210, 182, 1)
                                            : const Color.fromRGBO(
                                                110, 210, 182, 0.5),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: getWidth(context, 5),
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/arrow.svg',
                                    fit: BoxFit.scaleDown,
                                    colorFilter: ColorFilter.mode(
                                        isActiveLogin
                                            ? const Color.fromRGBO(
                                                110, 210, 182, 1)
                                            : const Color.fromRGBO(
                                                110, 210, 182, 0.5),
                                        BlendMode.srcIn),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 9),
                    ),
                    Text(
                      'Введите ваши данные для регистрации:',
                      style: TextLocalStyles.roboto400.copyWith(
                          color: state.isDark
                              ? Colors.white
                              : const Color.fromRGBO(22, 26, 29, 1),
                          fontSize: 17.5),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: textFieldRegistration(
                            context,
                            343,
                            isPressed ? '@' : 'example@mail.ru',
                            isPressed ? telegram : email,
                            false,
                            textFieldColor[2],
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
                          borderRadius: BorderRadius.circular(8),
                          child: iconTextFieldRegistration(
                            context,
                            'assets/svg/registration_telegram.svg',
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
                          borderRadius: BorderRadius.circular(8),
                          child: iconTextFieldRegistration(
                            context,
                            'assets/svg/registration_email.svg',
                            !isPressed,
                            const Color.fromRGBO(241, 171, 193, 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 54),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: getHeight(context, 48),
                          width: getHeight(context, 48),
                          child: image == null
                              ? CircleAvatar(
                                  backgroundImage: const AssetImage(
                                      'assets/images/upload_image.png'),
                                  backgroundColor: state.isDark
                                      ? AppTheme.backgroundColor
                                      : const Color.fromRGBO(240, 247, 254, 1),
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
                                    builder: (_) => const PickImageScreen()));
                            setState(() {});
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: getHeight(context, 44),
                                width: getWidth(context, 283),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: state.isDark
                                          ? const Color.fromRGBO(52, 54, 62, 1)
                                          : const Color.fromRGBO(
                                              250, 255, 255, 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: getHeight(context, 30),
                                        width: getHeight(context, 30),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: state.isDark
                                                ? const Color.fromRGBO(
                                                    62, 64, 72, 1)
                                                : const Color.fromRGBO(
                                                    237, 244, 251, 1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/svg/plus.svg',
                                            colorFilter: const ColorFilter.mode(
                                                Color.fromRGBO(
                                                    157, 167, 176, 1),
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Загрузить фотографию',
                                        style:
                                            TextLocalStyles.roboto400.copyWith(
                                          color: state.isDark
                                              ? const Color.fromRGBO(
                                                  255, 255, 255, 1)
                                              : const Color.fromRGBO(
                                                  22, 26, 29, 1),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getHeight(context, 44),
                                width: getWidth(context, 283),
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(4),
                                  color: const Color.fromRGBO(98, 198, 170, 1),
                                  dashPattern: const [6, 6],
                                  //padding: EdgeInsets.all(6),
                                  child: const ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
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
                      height: getHeight(context, 36),
                    ),
                    SizedBox(
                      height: getHeight(context, 48),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              isPicked = !isPicked;
                              if (isPicked) {
                                textColor =
                                    const Color.fromRGBO(98, 198, 170, 1);
                              } else {
                                textColor =
                                    const Color.fromRGBO(188, 192, 200, 1);
                              }
                              if (isPicked) {
                                textColorDark =
                                    const Color.fromRGBO(98, 198, 170, 1);
                              } else {
                                textColorDark =
                                    const Color.fromRGBO(98, 118, 132, 1);
                              }
                              setState(() {});
                            },
                            child: SizedBox(
                              height: getHeight(context, 24),
                              width: getHeight(context, 24),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: state.isDark
                                      ? const Color.fromRGBO(52, 54, 62, 1)
                                      : const Color.fromRGBO(250, 255, 255, 1),
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                    color: context
                                        .read<ThemeBloc>()
                                        .state
                                        .postcardContainerBorderColor,
                                    width: 1.5,
                                  ),
                                ),
                                child: isPicked
                                    ? SvgPicture.asset('assets/svg/check.svg')
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: getWidth(context, 10),
                          ),
                          SizedBox(
                            width: getWidth(context, 307),
                            child: Text(
                              'Подтверждаю, что мною полностью прочитаны, поняты и приняты условия Договора оферты и Политика кондифенциальности',
                              style: TextLocalStyles.roboto400.copyWith(
                                color: state.isDark ? textColor : textColorDark,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () async {
                          isPicked = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Screen15Reg(
                                        isPressed: false,
                                      )));
                          if (isPicked) {
                            textColor = const Color.fromRGBO(98, 198, 170, 1);
                          } else {
                            textColor = const Color.fromRGBO(188, 192, 200, 1);
                          }
                          if (isPicked) {
                            textColorDark =
                                const Color.fromRGBO(98, 198, 170, 1);
                          } else {
                            textColorDark =
                                const Color.fromRGBO(98, 118, 132, 1);
                          }
                          setState(() {});
                        },
                        child: Text(
                          'ПРОЧИТАТЬ',
                          style: TextLocalStyles.roboto400.copyWith(
                            color: const Color.fromRGBO(127, 164, 234, 1),
                            fontSize: 14,
                            letterSpacing: 0.28,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 67),
                    ),
                    buttonGreen(context, 48, 343, 'Зарегистрироваться', 16, () {
                      isOk = true;
                      if (!isPicked) {
                        textColor = Colors.red;
                        isOk = false;
                      }
                      textColorDark = Colors.red;
                      String value = phone.text;
                      RegExp regExp = RegExp(r"^\+{0,1}\d{11}$");
                      if (regExp.hasMatch(value)) {
                        textFieldColor[0] =
                            const Color.fromRGBO(66, 157, 132, 1);
                      } else {
                        textFieldColor[0] = Colors.red;
                        isOk = false;
                      }

                      value = password.text;
                      if (value.length > 7) {
                        textFieldColor[1] =
                            const Color.fromRGBO(66, 157, 132, 1);
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
                        isPressed = false;
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
                        isPressed = true;
                      }
                      if (isOk == true) {
                        _register(password.text, phone.text, telegram.text,
                            email.text, image);
                      }
                      Timer(const Duration(milliseconds: 500), () {
                        if (id != '') {
                          if (responseData['phoneNumber'][0] ==
                                  "пользователь с таким phoneNumber уже существует." ||
                              responseData['phoneNumber'][0] ==
                                  "Введен некорректный номер телефона.") {
                            textFieldColor[0] = Colors.red;
                          }

                          if (responseData['telegram'][0] ==
                              "пользователь с таким telegram уже существует.") {
                            textFieldColor[2] = Colors.red;
                            isPressed = true;
                          }

                          setState(() {});
                        }
                        setState(() {});
                        Timer(
                          const Duration(seconds: 2),
                          () {
                            textColor = const Color.fromRGBO(188, 192, 200, 1);
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
                                  .postcardContainerBorderColor
                            ];
                            setState(() {});
                          },
                        );
                      });
                    }, isActiveReg),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buttonGreen(
      BuildContext context, height, width, title, fontSize, onTap, isActive) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: isActive ? onTap : () {},
      child: SizedBox(
        width: getWidth(context, width),
        height: getHeight(context, height),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [
                      Color.fromRGBO(98, 198, 170, 0.3),
                      Color.fromRGBO(68, 168, 140, 0.3),
                    ],
                  )
                : const LinearGradient(
                    colors: [
                      Color.fromRGBO(98, 198, 170, 0.1),
                      Color.fromRGBO(68, 168, 140, 0.1),
                    ],
                  ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive
                  ? const Color.fromRGBO(98, 198, 170, 1)
                  : const Color.fromRGBO(98, 198, 170, 0.5),
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
      controller, isPassword, textFieldColor) {
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
        obscureText: isPassword,
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
}
