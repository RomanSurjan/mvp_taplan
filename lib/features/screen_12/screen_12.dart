import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_event.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
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
  TextEditingController name = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');
  TextEditingController phone = TextEditingController(text: '');
  TextEditingController telegram = TextEditingController(text: '');
  TextEditingController email = TextEditingController(text: '');
  TextEditingController city = TextEditingController(text: '');
  List<Color> textFieldColor = List.generate(3, (index) => const Color.fromRGBO(66, 157, 132, 1));
  bool isOk = true;
  bool isActiveLogin = false;
  bool isActiveReg = false;
  bool isPressedPassword = true;

  bool isPressed = true;

  Uint8List? image;

  double getHeight(BuildContext context, double height) {
    return height / 768 * MediaQuery.of(context).size.height;
  }

  double getWidth(BuildContext context, double width) {
    return width / 375 * MediaQuery.of(context).size.width;
  }

  void _checkData() {
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
    if (!isPicked) isActiveReg = false;
    setState(() {});
  }

  void telegramListener() {
    String value = telegram.text;
    RegExp regExp = RegExp(r"^@\w+$");
    String tag = '@';
    Iterable matches = regExp.allMatches(value);
    if (matches.isEmpty) {
      telegram.value = telegram.value.copyWith(
        text: tag,
        selection: TextSelection(baseOffset: tag.length, extentOffset: tag.length),
        composing: TextRange.empty,
      );
    }
    _checkData();
  }

  void phoneListener() {
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
    _checkData();
  }

  @override
  void initState() {
    super.initState();

    isPicked = widget.isPressed;
    telegram.addListener(
      () {
        telegramListener();
      },
    );
    phone.addListener(() {
      phoneListener();
    });

    password.addListener(() {
      _checkData();
    });

    email.addListener(() {
      _checkData();
    });
  }

  @override
  void dispose() {
    phone.removeListener(() {
      phoneListener();
    });
    password.removeListener(() {
      _checkData();
    });
    email.removeListener(() {
      _checkData();
    });
    telegram.removeListener(() {
      telegramListener();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor:
                  state.isDark ? AppTheme.backgroundColor : const Color.fromRGBO(240, 247, 254, 1),
              appBar: const CustomAppBarRegistration(
                name: 'Сервис желанных подарков',
              ),
              body: SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                    child: Column(
                      children: [
                        SizedBox(height: getHeight(context, 11)),
                        Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: Image.asset('assets/images/image 304.png'),
                            ),
                            Align(
                              alignment: AlignmentDirectional.center,
                              child: SizedBox(
                                height: getHeight(context, 80),
                                child: SvgPicture.asset(
                                  state.isDark
                                      ? 'assets/svg/logo_light.svg'
                                      : 'assets/svg/logo.svg',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getHeight(context, 11)),
                        Text(
                          'Данные для входа или регистрации:',
                          style: TextLocalStyles.roboto400.copyWith(
                            color:
                                state.isDark ? Colors.white : const Color.fromRGBO(22, 26, 29, 1),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: getHeight(context, 6)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: textFieldRegistration(
                                context,
                                hintText: 'Телефон',
                                controller: phone,
                                isPassword: false,
                                textFieldBorderColor:
                                    isOk ? state.postcardContainerBorderColor : textFieldColor[0],
                              ),
                            ),
                            const SizedBox(width: 9),
                            iconTextFieldRegistration(
                              context,
                              icon: 'assets/svg/registration_phone.svg',
                              isPressed: false,
                              color: const Color.fromRGBO(110, 210, 182, 1),
                            ),
                          ],
                        ),
                        SizedBox(height: getHeight(context, 8)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: textFieldRegistration(
                                context,
                                hintText: 'Пароль(не менее 8-ми символов)',
                                controller: password,
                                isPassword: isPressedPassword,
                                textFieldBorderColor:
                                    isOk ? state.postcardContainerBorderColor : textFieldColor[1],
                              ),
                            ),
                            const SizedBox(width: 9),
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
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                      color: state.postcardContainerBorderColor,
                                      width: 1.2,
                                    ),
                                    gradient: state.isDark
                                        ? !isPressedPassword
                                            ? const LinearGradient(
                                                colors: [
                                                  Color.fromRGBO(74, 79, 85, 1),
                                                  Color.fromRGBO(44, 49, 55, 1),
                                                ],
                                                begin: Alignment.bottomRight,
                                                end: Alignment.topLeft,
                                              )
                                            : const LinearGradient(
                                                colors: [
                                                  Color.fromRGBO(74, 79, 85, 1),
                                                  Color.fromRGBO(44, 49, 55, 1),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                        : !isPressedPassword
                                            ? const LinearGradient(
                                                colors: [
                                                  Color.fromRGBO(255, 255, 255, 1),
                                                  Color.fromRGBO(224, 236, 250, 1),
                                                ],
                                                end: Alignment.topLeft,
                                                begin: Alignment.bottomRight,
                                              )
                                            : const LinearGradient(
                                                colors: [
                                                  Color.fromRGBO(255, 255, 255, 1),
                                                  Color.fromRGBO(224, 236, 250, 1),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                    boxShadow: state.isDark
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
                                    'assets/images/password.png',
                                    fit: BoxFit.scaleDown,
                                    color: const Color.fromRGBO(255, 112, 162, 1),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: getHeight(context, 7)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            splashColor: isActiveLogin ? null : Colors.transparent,
                            highlightColor: isActiveLogin ? null : Colors.transparent,
                            onTap: isActiveLogin
                                ? () {
                                    context.read<AuthorizationBloc>().add(
                                          LoginEvent(
                                            phone: phone.text,
                                            password: password.text,
                                          ),
                                        );
                                    textFieldColor[2] = state.postcardContainerBorderColor;
                                    //TODO
                                    Timer(
                                      const Duration(milliseconds: 700),
                                          () {
                                            if (context.read<AuthorizationBloc>().state.authToken != null) {
                                              isOk = false;
                                              textFieldColor[0] = const Color.fromRGBO(66, 157, 132, 1);
                                              textFieldColor[1] = const Color.fromRGBO(66, 157, 132, 1);
                                              setState(() {});
                                              Timer(
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
                                            } else {
                                              textFieldColor[0] = Colors.red;
                                              textFieldColor[1] = Colors.red;
                                              isOk = false;
                                              setState(() {});
                                            }
                                            Timer(
                                              const Duration(seconds: 2),
                                                  () {
                                                isOk = true;
                                                setState(() {});
                                              },
                                            );
                                      },
                                    );

                                  }
                                : null,
                            child: SizedBox(
                              height: getHeight(context, 48),
                              width: getWidth(context, 160),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: isActiveLogin
                                        ? [
                                            const Color.fromRGBO(98, 198, 170, 0.3),
                                            const Color.fromRGBO(68, 168, 140, 0.3),
                                          ]
                                        : [
                                            const Color.fromRGBO(98, 198, 170, 0.1),
                                            const Color.fromRGBO(68, 168, 140, 0.1),
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
                                            ? const Color.fromRGBO(110, 210, 182, 1)
                                            : const Color.fromRGBO(110, 210, 182, 0.5),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: getWidth(context, 5)),
                                    SvgPicture.asset(
                                      'assets/svg/arrow.svg',
                                      fit: BoxFit.scaleDown,
                                      colorFilter: ColorFilter.mode(
                                        isActiveLogin
                                            ? const Color.fromRGBO(110, 210, 182, 1)
                                            : const Color.fromRGBO(110, 210, 182, 0.5),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: getHeight(context, 9)),
                        Text(
                          'Введите ваши данные для регистрации:',
                          style: TextLocalStyles.roboto400.copyWith(
                            color:
                                state.isDark ? Colors.white : const Color.fromRGBO(22, 26, 29, 1),
                            fontSize: 17.5,
                          ),
                        ),
                        SizedBox(height: getHeight(context, 1)),
                        Row(
                          children: [
                            Expanded(
                              child: textFieldRegistration(
                                context,
                                hintText: isPressed ? '@' : 'example@mail.ru',
                                controller: isPressed ? telegram : email,
                                isPassword: false,
                                textFieldBorderColor:
                                    isOk ? state.postcardContainerBorderColor : textFieldColor[2],
                              ),
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                if (isPressed == false) isPressed = !isPressed;
                                setState(() {});
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: iconTextFieldRegistration(
                                context,
                                icon: 'assets/svg/registration_telegram.svg',
                                isPressed: isPressed,
                                color: const Color.fromRGBO(163, 153, 210, 1),
                              ),
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () {
                                if (isPressed == true) isPressed = !isPressed;
                                setState(() {});
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: iconTextFieldRegistration(
                                context,
                                icon: 'assets/svg/registration_email.svg',
                                isPressed: !isPressed,
                                color: const Color.fromRGBO(241, 171, 193, 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getHeight(context, 54)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: getHeight(context, 48),
                              width: getHeight(context, 48),
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
                                image = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PickImageScreen(),
                                  ),
                                );
                                setState(() {});
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                //TODO
                                children: [
                                  SizedBox(
                                    height: getHeight(context, 44),
                                    width: getWidth(context, 283),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: state.isDark
                                            ? const Color.fromRGBO(52, 54, 62, 1)
                                            : const Color.fromRGBO(250, 255, 255, 1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: getHeight(context, 30),
                                            width: getHeight(context, 30),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: state.isDark
                                                    ? const Color.fromRGBO(62, 64, 72, 1)
                                                    : const Color.fromRGBO(237, 244, 251, 1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/svg/plus.svg',
                                                colorFilter: const ColorFilter.mode(
                                                  Color.fromRGBO(157, 167, 176, 1),
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Загрузить фотографию',
                                            style: TextLocalStyles.roboto400.copyWith(
                                              color: state.isDark
                                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                                  : const Color.fromRGBO(22, 26, 29, 1),
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
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getHeight(context, 36)),
                        SizedBox(
                          height: getHeight(context, 48),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  isPicked = !isPicked;
                                  _checkData();
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
                                        color: state.postcardContainerBorderColor,
                                        width: 1.5,
                                      ),
                                    ),
                                    child:
                                        isPicked ? SvgPicture.asset('assets/svg/check.svg') : null,
                                  ),
                                ),
                              ),
                              SizedBox(width: getWidth(context, 10)),
                              SizedBox(
                                width: getWidth(context, 307),
                                child: Text(
                                  'Подтверждаю, что мною полностью прочитаны, поняты и приняты условия Договора оферты и Политика кондифенциальности',
                                  style: TextLocalStyles.roboto400.copyWith(
                                    color: isPicked
                                        ? const Color.fromRGBO(98, 198, 170, 1)
                                        : const Color.fromRGBO(124, 127, 136, 1),
                                    fontSize: getHeight(context, 13),
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
                                  ),
                                ),
                              );
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
                        const Expanded(child: SizedBox()),
                        buttonGreen(
                          context,
                          height: 48,
                          width: 343,
                          title: 'Зарегистрироваться',
                          isActive: isActiveReg,
                          fontSize: 16,
                          onTap: () {
                            context.read<AuthorizationBloc>().add(
                                  RegisterEvent(
                                    phone: phone.text,
                                    password: password.text,
                                    telegram: telegram.text,
                                    email: email.text,
                                    image: image,
                                  ),
                                );
                            //TODO СМОТреть изменения из блока
                            Timer(
                              const Duration(milliseconds: 700),
                                  () {
                                    textFieldColor = List.generate(3, (index) => const Color.fromRGBO(66, 157, 132, 1));
                                    if (context.read<AuthorizationBloc>().state.id != null) {
                                      isOk = false;
                                      setState(() {});
                                      Timer(
                                        const Duration(milliseconds: 600),
                                            () {
                                          print('Ok');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => const Screen14(),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      if (context.read<AuthorizationBloc>().state.phone ==
                                          "пользователь с таким phoneNumber уже существует." ||
                                          context.read<AuthorizationBloc>().state.phone == "Введен некорректный номер телефона.") {
                                        textFieldColor[0] = Colors.red;
                                      }
                                      if (context.read<AuthorizationBloc>().state.telegram ==
                                          "пользователь с таким telegram уже существует.") {
                                        textFieldColor[2] = Colors.red;
                                        isPressed = true;
                                      }
                                      if(context.read<AuthorizationBloc>().state.phone.isNull &&  context.read<AuthorizationBloc>().state.telegram.isNull)
                                        {
                                          textFieldColor[1] = Colors.red;
                                        }
                                      isOk = false;
                                      setState(() {});
                                    }

                                    Timer(
                                      const Duration(seconds: 2),
                                          () {
                                        isOk = true;
                                        setState(() {});
                                      },
                                    );

                              },
                            );

                          },
                        ),
                        SizedBox(height: getHeight(context, 20)),
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
}
