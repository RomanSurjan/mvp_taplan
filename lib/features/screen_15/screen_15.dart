import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_bloc.dart';
import 'package:mvp_taplan/blocs/paymennt_bloc/payment_bloc.dart';
import 'package:mvp_taplan/blocs/paymennt_bloc/payment_event.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Screen15 extends StatefulWidget {
  final MvpPresentModel currentModel;

  const Screen15({
    super.key,
    required this.currentModel,
  });

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


  void setChecker(bool checker) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('checker', checker);
  }

  @override
  void initState() {
    super.initState();
    getDock();
  }

  bool isPicked = false;

  Color textColor = AppTheme.mainGreenColor;

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      fontSize: 17,
      appBarLabel: 'Пользовательское соглашение\n(публичная оферта)',
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth(context, 16),
        ),
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: getHeight(context, 5),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/sk_logo_main.png',
                ),
              ),
              SizedBox(
                height: getHeight(context, 4),
              ),
              Image.asset(
                state.logoPath,
              ),
              SizedBox(
                height: getHeight(context, 31),
              ),
              Expanded(
                child: SizedBox(
                  width: getWidth(context, 343),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: state.dockColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: state.dockBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: getHeight(context, 10)),
                      child: RawScrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        radius: const Radius.circular(2),
                        thumbColor: state.dockThumbColor,
                        trackColor: state.dockTrackColor,
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
                                color: state.appBarTextColor,
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
                      //setChecker(isPicked);
                      setState(() {});
                    },
                    child: SizedBox(
                      height: getHeight(context, 24),
                      width: getHeight(context, 24),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: state.dockColor,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: state.dockBorderColor,
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
                    opacity: 0.3,
                    label: 'Скачать\nв pdf формате',
                    gradient: AppTheme.mainGreyGradient,
                    width: getWidth(context, 164),
                    onTap: () async{
                      final Uri url = Uri.parse('https://qviz.fun/media/agreement_v3/agreement.pdf/');
                      if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                      }

                    },
                  ),
                  SizedBox(
                    width: getWidth(context, 15),
                  ),
                  MvpGradientButton(
                    label: 'Перейти\nк оплате',
                    gradient: AppTheme.mainGreenGradient,
                    width: getWidth(context, 164),
                    onTap: ()async {
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
                      } else {
                        context.read<PaymentBloc>().add(InitPaymentEvent(context.read<BuyTogetherBloc>().state.additionalSum));
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context, 95),
              ),
            ],
          );
        }),
      ),
    );
  }
}
