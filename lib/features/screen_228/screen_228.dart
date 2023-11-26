import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_state.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen228 extends StatefulWidget {
  final String? a;

  const Screen228({super.key, this.a = 'AAAAAAAAAAAAAAAAAAAa'});

  @override
  State<Screen228> createState() => _Screen228State();
}

class _Screen228State extends State<Screen228> {
  bool isPickedFirst = true;
  bool isPickedSecond = true;
  bool isPickedThird = true;
  Color textColorFirst = const Color.fromRGBO(188, 192, 200, 1);
  Color textColorSecond = const Color.fromRGBO(188, 192, 200, 1);
  Color textColorThird = const Color.fromRGBO(188, 192, 200, 1);

  Response? response2;

  void getInfo() async {
    response2 = await Dio().post(
      'https://qviz.fun/api/v1/get/date/about/order/',
      data: {
        'order_id': widget.a,
      },
    );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (response2 == null) {
      return const CircularProgressIndicator();
    }
    return MvpScaffoldModel(
      onBack: (){
        Navigator.pushReplacementNamed(context, '/nb/journal_1/');
      },
      appBarLabel: 'Платеж на подарок принят ',
      child: BlocBuilder<WishListBloc, WishListState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getWidth(context, 16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getHeight(context, 12),
                ),
                SizedBox(
                  height: getHeight(context, 202),
                  width: getWidth(context, 343),
                  child: Image.network(
                    response2!.data['present_info']['present_photo_2'],
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 5),
                ),
                Center(
                  child: Text(
                    response2!.data['present_info']['present_name'],
                    style: TextLocalStyles.roboto500.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 8),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cобрано ${sumToString(response2!.data['present_info']['invested'])}',
                      style: TextLocalStyles.roboto600.copyWith(
                        fontSize: 16,
                        color: AppTheme.mainGreenColor,
                      ),
                    ),
                    Text(
                      'Внесено ${sumToString(response2!.data['amount'])}',
                      style: TextLocalStyles.roboto600.copyWith(
                        fontSize: 16,
                        color: AppTheme.moneyScaleGreenColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(context, 5),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: response2!.data['present_info']['invested'],
                      child: Container(
                        height: 38,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(1.5),
                            bottomLeft: Radius.circular(1.5),
                          ),
                          gradient: AppTheme.moneyCollectedScaleWidgetGradientColor1,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.5),
                        color: AppTheme.mainGreenColor,
                      ),
                    ),
                    if (response2!.data['amount'] > 0) ...[
                      Expanded(
                        flex: response2!.data['amount'],
                        child: Container(
                          height: 38,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(1.5),
                              bottomLeft: Radius.circular(1.5),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(127, 164, 234, 1),
                                Color.fromRGBO(127, 164, 234, 0.9),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.5),
                          color: AppTheme.mainGreenColor,
                        ),
                      ),
                    ],
                    Expanded(
                      flex: response2!.data['present_info']['total'] -
                          response2!.data['present_info']['invested'] -
                          response2!.data['amount'],
                      child: Container(
                        height: 38,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(1.5),
                            bottomRight: Radius.circular(1.5),
                          ),
                          gradient: AppTheme.moneyCollectedScaleWidgetGradientColor2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(context, 5),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Осталось ${sumToString(response2!.data['present_info']['total'] - response2!.data['present_info']['invested'])}',
                    style: TextLocalStyles.roboto600.copyWith(
                      fontSize: 16,
                      color: AppTheme.mainPinkColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 21),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Дата и время вручения подарка',
                    style: TextLocalStyles.roboto400.copyWith(
                        color: context.read<ThemeBloc>().state.isDark
                            ? const Color.fromRGBO(240, 247, 254, 1)
                            : const Color.fromRGBO(22, 26, 29, 1),
                        fontSize: 15,
                        height: 16.41 / 14),
                  ),
                ),

                Row(
                  children: [
                    SizedBox(
                      width: getWidth(context, 167),
                      height: getHeight(context, 48),
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
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  '07.12.2023',
                                  style: TextLocalStyles.roboto500.copyWith(
                                    color: const Color.fromRGBO(200, 210, 219, 1),
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
                                    'assets/svg/more_button.svg',
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
                    const Expanded(
                      child: SizedBox.shrink(),
                    ),
                    SizedBox(
                      width: getWidth(context, 167),
                      height: getHeight(context, 48),
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
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  '21:30',
                                  style: TextLocalStyles.roboto500.copyWith(
                                    color: const Color.fromRGBO(200, 210, 219, 1),
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
                                    'assets/svg/more_button.svg',
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
                  ],
                ),
                SizedBox(
                  height: getHeight(context, 30),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        isPickedFirst = !isPickedFirst;
                        if (isPickedFirst) {
                          textColorFirst = const Color.fromRGBO(98, 198, 170, 1);
                        } else {
                          textColorFirst = const Color.fromRGBO(188, 192, 200, 1);
                        }
                        setState(() {});
                      },
                      child: SizedBox(
                        height: getHeight(context, 24),
                        width: getHeight(context, 24),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.read<ThemeBloc>().state.dockColor,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: context.read<ThemeBloc>().state.dockBorderColor,
                              width: 1.5,
                            ),
                          ),
                          child: isPickedFirst
                              ? SvgPicture.asset('assets/svg/check.svg')
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getWidth(context, 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: SizedBox(
                        width: getWidth(context, 307),
                        child: Text(
                          "Деньги на подарок внесены",
                          textAlign: TextAlign.justify,
                          style: TextLocalStyles.roboto400.copyWith(
                            color: textColorFirst,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(context, 7),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        isPickedSecond = !isPickedSecond;
                        if (isPickedSecond) {
                          textColorSecond = const Color.fromRGBO(98, 198, 170, 1);
                        } else {
                          textColorSecond = const Color.fromRGBO(188, 192, 200, 1);
                        }
                        setState(() {});
                      },
                      child: SizedBox(
                        height: getHeight(context, 24),
                        width: getHeight(context, 24),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.read<ThemeBloc>().state.dockColor,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: context.read<ThemeBloc>().state.dockBorderColor,
                              width: 1.5,
                            ),
                          ),
                          child: isPickedSecond
                              ? SvgPicture.asset('assets/svg/check.svg')
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getWidth(context, 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: SizedBox(
                        width: getWidth(context, 307),
                        child: Text(
                          "Открытку или пожелание в чат написать",
                          textAlign: TextAlign.justify,
                          style: TextLocalStyles.roboto400.copyWith(
                            color: textColorSecond,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(context, 7),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        isPickedThird = !isPickedThird;
                        if (isPickedThird) {
                          textColorThird = const Color.fromRGBO(98, 198, 170, 1);
                        } else {
                          textColorThird = const Color.fromRGBO(188, 192, 200, 1);
                        }
                        setState(() {});
                      },
                      child: SizedBox(
                        height: getHeight(context, 24),
                        width: getHeight(context, 24),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.read<ThemeBloc>().state.dockColor,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: context.read<ThemeBloc>().state.dockBorderColor,
                              width: 1.5,
                            ),
                          ),
                          child: isPickedThird
                              ? SvgPicture.asset('assets/svg/check.svg')
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getWidth(context, 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: SizedBox(
                        width: getWidth(context, 307),
                        child: Text(
                          "Напоминать мне об on-line мерориятии",
                          textAlign: TextAlign.justify,
                          style: TextLocalStyles.roboto400.copyWith(
                            color: textColorThird,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),



                // Text(
                //   "Дата и время вручения подарка",
                //   style: TextLocalStyles.roboto400.copyWith(
                //     color: const Color.fromRGBO(240, 247, 254, 1),
                //     fontSize: getHeight(context, 16),
                //     height: 16.41 / 14,
                //   ),
                // ),
                // SizedBox(
                //   height: getHeight(context, 4),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     PickContainer(
                //       height: getHeight(context, 48),
                //       width: getWidth(context, 168),
                //       label: context.read<DateTimeBloc>().date.isNotEmpty
                //           ? dateToString(context.read<DateTimeBloc>().date)
                //           : context.read<PostcardBloc>().state.currentHolidayType ==
                //                   HolidayType.birthday
                //               ? dateToString(context
                //                   .read<PostcardBloc>()
                //                   .state
                //                   .mapOfEvents['День рождения']![0])
                //               : dateToString(context
                //                   .read<PostcardBloc>()
                //                   .state
                //                   .mapOfEvents['Еженедельный стрим']![0]),
                //     ),
                //     PickContainer(
                //       height: getHeight(context, 48),
                //       width: getWidth(context, 168),
                //       label: context.read<DateTimeBloc>().time.isNotEmpty
                //           ? timeToString(context.read<DateTimeBloc>().time)
                //           : context.read<PostcardBloc>().state.currentHolidayType ==
                //                   HolidayType.birthday
                //               ? timeToString(context
                //                   .read<PostcardBloc>()
                //                   .state
                //                   .mapOfEvents['День рождения']![1])
                //               : timeToString(context
                //                   .read<PostcardBloc>()
                //                   .state
                //                   .mapOfEvents['Еженедельный стрим']![1]),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: getHeight(context, 36),
                // ),
                // Row(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         isPickedFirst = !isPickedFirst;
                //         setState(() {});
                //       },
                //       child: SizedBox(
                //         height: getHeight(context, 24),
                //         width: getHeight(context, 24),
                //         child: DecoratedBox(
                //           decoration: BoxDecoration(
                //             color: const Color.fromRGBO(52, 54, 62, 1),
                //             borderRadius: BorderRadius.circular(2),
                //             border: Border.all(
                //               color: const Color.fromRGBO(66, 68, 77, 1),
                //               width: 1.5,
                //             ),
                //           ),
                //           child: isPickedFirst ? SvgPicture.asset('assets/svg/check.svg') : null,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: getWidth(context, 10),
                //     ),
                //     Text(
                //       'Деньги на подарок внесены ',
                //       style: TextLocalStyles.roboto500.copyWith(
                //         color: AppTheme.mainGreenColor,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: getHeight(context, 20),
                // ),
                // Row(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         isPickedSecond = !isPickedSecond;
                //         setState(() {});
                //       },
                //       child: SizedBox(
                //         height: getHeight(context, 24),
                //         width: getHeight(context, 24),
                //         child: DecoratedBox(
                //           decoration: BoxDecoration(
                //             color: const Color.fromRGBO(52, 54, 62, 1),
                //             borderRadius: BorderRadius.circular(2),
                //             border: Border.all(
                //               color: const Color.fromRGBO(66, 68, 77, 1),
                //               width: 1.5,
                //             ),
                //           ),
                //           child: isPickedSecond ? SvgPicture.asset('assets/svg/check.svg') : null,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: getWidth(context, 10),
                //     ),
                //     Text(
                //       'Открытку или пожелания в чат написать ',
                //       style: TextLocalStyles.roboto500.copyWith(
                //         color: AppTheme.mainGreenColor,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: getHeight(context, 20),
                // ),
                // Row(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         isPickedThird = !isPickedThird;
                //         setState(() {});
                //       },
                //       child: SizedBox(
                //         height: getHeight(context, 24),
                //         width: getHeight(context, 24),
                //         child: DecoratedBox(
                //           decoration: BoxDecoration(
                //             color: const Color.fromRGBO(52, 54, 62, 1),
                //             borderRadius: BorderRadius.circular(2),
                //             border: Border.all(
                //               color: const Color.fromRGBO(66, 68, 77, 1),
                //               width: 1.5,
                //             ),
                //           ),
                //           child: isPickedThird ? SvgPicture.asset('assets/svg/check.svg') : null,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: getWidth(context, 10),
                //     ),
                //     Text(
                //       'Напоминать мне об on-line мероприятии ',
                //       style: TextLocalStyles.roboto500.copyWith(
                //         color: AppTheme.mainGreenColor,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: getHeight(context, 20),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MvpGradientButton(
                      label: 'На стартовую\nстраницу ',
                      gradient: AppTheme.mainPurpleGradient,
                      width: getWidth(context, 109),
                    ),
                    MvpGradientButton(
                      label: 'На витрину\nподарков',
                      gradient: AppTheme.mainGreenGradient,
                      width: getWidth(context, 109),
                    ),
                    MvpGradientButton(
                      label: 'В календарь\nпраздников ',
                      gradient: AppTheme.mainGreenGradient,
                      width: getWidth(context, 109),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
