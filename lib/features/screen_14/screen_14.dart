import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_event.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_14/screen_addInformation.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen14 extends StatefulWidget {
  const Screen14({super.key});

  @override
  State<Screen14> createState() => _Screen14State();
}

class _Screen14State extends State<Screen14> {
  static const keyboardTitle = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  static const keyboardSubtitle = [
    '',
    'A B C',
    'D E F',
    'G H I',
    'J K L',
    'M N O',
    'P Q R S',
    'T U V',
    'W X W Z',
  ];

  List<Color> logIn = [
    const Color.fromRGBO(98, 198, 170, 0.1),
    const Color.fromRGBO(68, 168, 140, 0.1),
    const Color.fromRGBO(82, 182, 154, 0.5),
  ];
  List<Color> repeatMessage = [
    const Color.fromRGBO(98, 198, 170, 0.1),
    const Color.fromRGBO(68, 168, 140, 0.1),
    const Color.fromRGBO(82, 182, 154, 0.5),
  ];

  bool isPicked = false;
  List<String> code = ['_', ' ', ' ', ' '];

  double getHeight(BuildContext context, double height) {
    return height / 768 * MediaQuery.of(context).size.height;
  }

  double getWidth(BuildContext context, double width) {
    return width / 375 * MediaQuery.of(context).size.width;
  }

  bool isActiveRepeatMessage = false;
  bool isActiveLogIn = false;
  late Color borderColorField;
  bool isStop = false;

  void changeCode(String digit) {
    if (digit != '-1') {
      for (int i = 0; i < 4; i++) {
        if (i == 0) {
          if ((code[0] == '' && code[1] == ' ' && code[2] == ' ' && code[3] == ' ') ||
              (code[0] == '_' && code[1] == ' ' && code[2] == ' ' && code[3] == ' ')) {
            code[0] = digit;
            code[1] = '_';
            break;
          }
        } else if (((code[i - 1] != '_') || (code[i - 1] != '')) &&
            ((code[i] == '_') || (code[i] == ''))) {
          code[i] = digit;
          if (i != 3) code[i + 1] = '_';
          break;
        }
      }
    } else {
      if (code[0] != '_' && code[0] != '') {
        for (int i = 1; i < 4; i++) {
          if (code[i] == '_' || code[i] == ' ' || code[i] == '') {
            code[i] = ' ';
            code[i - 1] = '_';
            break;
          }
        }
        if (code[3] != '_' && code[3] != ' ') code[3] = '_';
      }
    }
    if (code[3] != '_' && code[3] != ' ') {
      isActiveLogIn = true;
      logIn = [
        const Color.fromRGBO(98, 198, 170, 0.3),
        const Color.fromRGBO(68, 168, 140, 0.3),
        const Color.fromRGBO(110, 210, 182, 1),
      ];
    } else {
      isActiveLogIn = false;
      logIn = [
        const Color.fromRGBO(98, 198, 170, 0.1),
        const Color.fromRGBO(68, 168, 140, 0.1),
        const Color.fromRGBO(82, 182, 154, 0.5),
      ];
    }
    setState(() {});
  }

  late Timer repeatCodeTimer;

  @override
  void initState() {
    super.initState();

    //context.read<AuthorizationBloc>().add(GetCodeEvent());
    context.read<AuthorizationBloc>().add(GetDataEvent());

    //TODO Разобраться с кодом  
    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        if (code[0] == '_') {
          code[0] = '';
          setState(() {});
          Timer(
            const Duration(milliseconds: 500),
            () {
              if (code[0] == '') code[0] = '_';
              setState(() {});
            },
          );
        }
      },
    );
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (code[1] == '_') {
        code[1] = '';
        setState(() {});
        Timer(
          const Duration(milliseconds: 500),
          () {
            if (code[1] == '') code[1] = '_';
            setState(() {});
          },
        );
      }
    });
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!mounted) {
        timer.cancel();
      }
      if (code[2] == '_') {
        code[2] = '';
        setState(() {});
        Timer(
          const Duration(milliseconds: 500),
          () {
            if (code[2] == '') code[2] = '_';
            setState(() {});
          },
        );
      }
    });
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!mounted) {
        timer.cancel();
      }
      if (code[3] == '_') {
        code[3] = '';
        setState(() {});
        Timer(
          const Duration(milliseconds: 500),
          () {
            if (code[3] == '') code[3] = '_';
            setState(() {});
          },
        );
      }
    });
    repeatCodeTimer = Timer(
      const Duration(seconds: 30),
      () {
        repeatMessage = [
          const Color.fromRGBO(98, 198, 170, 0.3),
          const Color.fromRGBO(68, 168, 140, 0.3),
          const Color.fromRGBO(110, 210, 182, 1),
        ];
        isActiveRepeatMessage = true;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthState>(builder: (context, authState) {
      return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          borderColorField = state.isDark
              ? const Color.fromRGBO(124, 68, 121, 1)
              : const Color.fromRGBO(238, 173, 235, 1);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor:
                state.isDark ? AppTheme.backgroundColor : const Color.fromRGBO(240, 247, 254, 1),
            appBar: CustomAppBarRegistration(
              onBack: () {
                authState = UnAuthorizationState();
                Navigator.pop(context);
              },
              name: 'Сервис желанных подарков',
            ),
            body: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(context, 16),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(context, 11),
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Image.asset(
                              'assets/images/image 304.png',
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: SizedBox(
                              height: getHeight(context, 80),
                              child: SvgPicture.asset(
                                state.isDark ? 'assets/svg/logo_light.svg' : 'assets/svg/logo.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(context, 16),
                      ),
                      Text(
                        'В течение 30 секунд код придет на телефон,\nтелеграмм или почту, предоставленные Вами',
                        style: TextLocalStyles.roboto400.copyWith(
                          fontSize: 15.5,
                          color: state.isDark
                              ? const Color.fromRGBO(233, 235, 237, 1)
                              : const Color.fromRGBO(22, 26, 29, 1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: getHeight(context, 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < 4; i++) fieldCode(context, i),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(context, 10),
                      ),
                      SizedBox(
                        height: 44,
                        width: getWidth(context, 344),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                splashColor: isActiveRepeatMessage ? null : Colors.transparent,
                                highlightColor: isActiveRepeatMessage ? null : Colors.transparent,
                                onTap: isActiveRepeatMessage
                                    ? () {
                                        context.read<AuthorizationBloc>().add(GetCodeEvent());
                                        repeatMessage = [
                                          const Color.fromRGBO(98, 198, 170, 0.1),
                                          const Color.fromRGBO(68, 168, 140, 0.1),
                                          const Color.fromRGBO(82, 182, 154, 0.5),
                                        ];
                                        isActiveRepeatMessage = false;

                                        setState(() {});
                                        Timer(
                                          const Duration(seconds: 30),
                                          () {
                                            repeatMessage = [
                                              const Color.fromRGBO(98, 198, 170, 0.3),
                                              const Color.fromRGBO(68, 168, 140, 0.3),
                                              const Color.fromRGBO(110, 210, 182, 1),
                                            ];
                                            isActiveRepeatMessage = true;
                                            setState(() {});
                                          },
                                        );
                                      }
                                    : null,
                                child: SizedBox.expand(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          repeatMessage[0],
                                          repeatMessage[1],
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: const Color.fromRGBO(98, 198, 170, 1),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: getHeight(context, 5),
                                      ),
                                      child: Text(
                                        'Послать код\n повторно',
                                        textAlign: TextAlign.center,
                                        style: TextLocalStyles.roboto500.copyWith(
                                          color: repeatMessage[2],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                splashColor: isActiveLogIn ? null : Colors.transparent,
                                highlightColor: isActiveLogIn ? null : Colors.transparent,
                                onTap: () {
                                  String codeStr = code.join();
                                  if (isActiveLogIn) {
                                    if (codeStr == '0000') {
                                      //authState.code) {
                                      isStop = true;
                                      setState(() {});
                                      Timer(
                                        const Duration(milliseconds: 500),
                                        () {
                                          if (authState.authToken != null &&
                                              authState.region == null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => const ScreenAddInformation(),
                                              ),
                                            );
                                          } else {
                                            Navigator.pushReplacementNamed(
                                                context, '/nb/journal_1/');
                                          }
                                        },
                                      );
                                    } else {
                                      for (int i = 0; i < 4; i++) {
                                        changeCode('-1');
                                      }
                                      borderColorField = Colors.red;
                                      setState(() {});

                                      Timer(
                                        const Duration(milliseconds: 500),
                                        () {
                                          borderColorField = context.read<ThemeBloc>().state.isDark
                                              ? const Color.fromRGBO(124, 68, 121, 1)
                                              : const Color.fromRGBO(238, 173, 235, 1);
                                        },
                                      );
                                    }
                                  }
                                },
                                child: SizedBox.expand(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          logIn[0],
                                          logIn[1],
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: const Color.fromRGBO(98, 198, 170, 1),
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
                                            color: logIn[2],
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          width: getWidth(context, 10),
                                        ),
                                        SvgPicture.asset(
                                          'assets/svg/arrow.svg',
                                          fit: BoxFit.scaleDown,
                                          colorFilter: ColorFilter.mode(logIn[2], BlendMode.srcIn),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 56),
                      ),
                      for (int i = 0; i < 3; i++) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int k = 0; k < 3; k++)
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  changeCode(keyboardTitle[k + i * 3]);
                                  setState(() {});
                                },
                                child: buttonKeyboard(
                                  context,
                                  title: keyboardTitle[k + i * 3],
                                  subtitle: keyboardSubtitle[k + i * 3],
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(context, 8),
                        ),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: getWidth(context, 106),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              changeCode('0');

                              setState(() {});
                            },
                            child: buttonKeyboard(
                              context,
                              title: '0',
                              subtitle: '',
                            ),
                          ),
                          SizedBox(
                            width: getWidth(context, 106),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                changeCode('-1');
                                setState(() {});
                              },
                              child: SvgPicture.asset('assets/svg/erase.svg'),
                            ),
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
    });
  }

  @override
  void dispose() {
    repeatCodeTimer.cancel();
    super.dispose();
  }

  Widget buttonKeyboard(
    BuildContext context, {
    required String title,
    required String subtitle,
  }) {
    return SizedBox(
      height: 54,
      width: 106,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(98, 198, 170, 0.3),
              Color.fromRGBO(68, 168, 140, 0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color.fromRGBO(98, 198, 170, 1),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextLocalStyles.roboto400.copyWith(
                  color: context.read<ThemeBloc>().state.isDark
                      ? const Color.fromRGBO(233, 84, 155, 1)
                      : const Color.fromRGBO(233, 84, 155, 1),
                  fontSize: 24,
                ),
              ),
              Text(
                subtitle,
                style: TextLocalStyles.roboto400.copyWith(
                  color: context.read<ThemeBloc>().state.isDark
                      ? const Color.fromRGBO(200, 210, 219, 1)
                      : const Color.fromRGBO(57, 57, 57, 1),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldCode(BuildContext context, int index) {
    return SizedBox(
      width: 76,
      height: 86,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.read<ThemeBloc>().state.isDark
              ? const Color.fromRGBO(55, 57, 65, 1)
              : const Color.fromRGBO(255, 255, 255, 1),
          border: Border.all(
            color: borderColorField,
            width: 2,
          ),
        ),
        child: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            child: Text(
              code[index],
              style: TextStyle(
                color: context.read<ThemeBloc>().state.isDark
                    ? const Color.fromRGBO(255, 255, 255, 1)
                    : const Color.fromRGBO(88, 88, 88, 1),
                fontSize: code[index] == '_' ? 34 : 40,
                fontFamily: 'Digital',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
