import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen15 extends StatefulWidget {
  const Screen15({Key? key}) : super(key: key);

  @override
  State<Screen15> createState() => _Screen15State();
}

class _Screen15State extends State<Screen15> {
  String dock = '';

  void getDock() async {
    final dio = Dio();
    final response = await dio.get('https://qviz.fun/api/v1/agreement/');

    dock = response.data['agreement'];

    setState(() {});
  }

  void getChecker() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final checker = prefs.getBool('checker');

    if (checker != null) {
      isPicked = checker;
    }
    setState(() {});
  }

  void setChecker(bool checker) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('checker', checker);
  }

  @override
  void initState() {
    super.initState();
    getDock();
    getChecker();
  }

  bool isPicked = false;

  Color textColor = AppTheme.mainGreenColor;

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Пользовательское соглашение\n(публичная оферта)',
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth(context, 16),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getHeight(context, 30),
            ),
            Image.asset(
              'assets/images/logo_dock.png',
            ),
            SizedBox(
              height: getHeight(context, 31),
            ),
            Expanded(
              child: SizedBox(
                width: getWidth(context, 343),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(52, 54, 62, 1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromRGBO(67, 72, 78, 1),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: getHeight(context, 10)),
                    child: RawScrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      radius: const Radius.circular(2),
                      thumbColor: const Color.fromRGBO(129, 140, 147, 1),
                      trackColor: const Color.fromRGBO(73, 88, 99, 1),
                      child: SingleChildScrollView(
                        primary: true,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: getHeight(context, 10),
                            horizontal: getWidth(context, 16),
                          ),
                          child: Text(
                            dock,
                            style: TextLocalStyles.roboto400.copyWith(
                              fontSize: 12,
                              color: Colors.white,
                              height: 14.06 / 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context, 24),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    isPicked = !isPicked;
                    setChecker(isPicked);
                    setState(() {});
                  },
                  child: SizedBox(
                    height: getHeight(context, 24),
                    width: getHeight(context, 24),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(52, 54, 62, 1),
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          color: const Color.fromRGBO(66, 68, 77, 1),
                          width: 1.5,
                        ),
                      ),
                      child: isPicked ? SvgPicture.asset('assets/svg/check.svg') : null,
                    ),
                  ),
                ),
                SizedBox(
                  width: getWidth(context, 10),
                ),
                Text(
                  'Подтверждаю, что мною полностью прочитны,\nпоняты и приняты условия Договора оферты\nи Политика конфиденциальности',
                  style: TextLocalStyles.roboto400.copyWith(
                    fontSize: 14,
                    height: 14.06 / 12,
                    color: textColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getHeight(context, 25),
            ),
            Row(
              children: [
                MvpGradientButton(
                  label: 'Скачать\nв Pdf формате',
                  gradient: AppTheme.mainGreyGradient,
                  width: getWidth(context, 164),
                ),
                SizedBox(
                  width: getWidth(context, 15),
                ),
                MvpGradientButton(
                  label: 'Перейти\nк оплате',
                  gradient: AppTheme.mainGreenGradient,
                  width: getWidth(context, 164),
                  onTap: () {
                    if (!isPicked) {
                      textColor = Colors.red;
                      setState(() {});
                      Timer(
                        const Duration(seconds: 2),
                        () {
                          textColor = AppTheme.mainGreenColor;
                          setState(() {});
                        },
                      );
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: getHeight(context, 95),
            ),
          ],
        ),
      ),
    );
  }
}
