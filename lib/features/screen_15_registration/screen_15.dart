import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';


class Screen15Reg extends StatefulWidget {
  final bool isPressed;

  const Screen15Reg({super.key, required this.isPressed});

  @override
  State<Screen15Reg> createState() => _Screen15RegState();
}

class _Screen15RegState extends State<Screen15Reg> {
  String dock = '';
  double getHeight(BuildContext context, double height){
    return height / 768 * MediaQuery.of(context).size.height;
  }

  double getWidth(BuildContext context, double width){
    return width / 375 * MediaQuery.of(context).size.width;
  }

  void getDock() async {
    final dio = Dio();
    final response = await dio.get('https://qviz.fun/api/v1/agreement/');

    dock = response.data['agreement'];

    setState(() {});
  }

  bool isPicked = false;

  Color textColor = const Color.fromRGBO(188, 192, 200, 1);

  @override
  void initState() {
    super.initState();
    getDock();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: state.isDark
            ? AppTheme.backgroundColor
            : const Color.fromRGBO(240, 247, 254, 1),
        appBar: CustomAppBarRegistration(
          onBack: (){
            Navigator.pop(context, isPicked);
          },
          name: 'Сервис желанных подарков',
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getWidth(context, 16),
            ),
            child:
                BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: getHeight(context, 11),
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Image.asset('assets/images/image 304.png'),
                      ),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: getHeight(context, 18),
                            ),
                            SvgPicture.asset(
                                !context.read<ThemeBloc>().state.isDark
                                    ? 'assets/svg/logo.svg'
                                    : 'assets/svg/logo_light.svg'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getHeight(context, 31),
                  ),
                  SizedBox(
                    width: getWidth(context, 343),
                    height: getHeight(context, 406),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: state.dockColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: state.dockBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getHeight(context, 3)),
                        child: RawScrollbar(
                          thumbVisibility: true,
                          trackVisibility: true,
                          thickness: 5,
                          radius: const Radius.circular(2),
                          trackRadius: const Radius.circular(2),
                          padding: const EdgeInsets.only(right: 2),
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
                  SizedBox(
                    height: getHeight(context, 20),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          isPicked = !isPicked;
                          if (isPicked) {
                            textColor = const Color.fromRGBO(98, 198, 170, 1);
                          } else {
                            textColor = const Color.fromRGBO(188, 192, 200, 1);
                          }
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
                            color: textColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getHeight(context, 49),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buttonGreen(44, 342, 'Скачать\nв Pdf формате', 14, () {}),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      );
    });
  }

  Widget buttonGreen(height, width, title, fontSize, onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: SizedBox(
        width: getWidth(context, width),
        height: getHeight(context, height),
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
}
