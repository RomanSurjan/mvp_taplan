import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_bloc.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_state.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_state.dart';
import 'package:mvp_taplan/features/screen_213/screen_213.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/models/sum_to_string.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen228 extends StatefulWidget {
  const Screen228({super.key});

  @override
  State<Screen228> createState() => _Screen228State();
}

class _Screen228State extends State<Screen228> {
  bool isPickedFirst = true;
  bool isPickedSecond = true;
  bool isPickedThird = true;

  late String test;

  void getInfo() async {
    // final response2 = await Dio().post(
    //   'https://qviz.fun/api/v1/get/date/about/order/',
    //   options: Options(
    //     headers: {
    //       'Authorization': 'Token 69f8e37d2d234198b8d45b0d1f7073386c026173',
    //     },
    //   ),
    // );
    // test = response2.data['present_info']['present_name'];
    //
  }

  @override
  void initState() {
    super.initState();

    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Платеж на подарок принят ',
      child: Text(
        Uri.base.toString(),
      ),
      // child: BlocBuilder<WishListBloc, WishListState>(
      //   builder: (context, state) {
      //     return Padding(
      //       padding: EdgeInsets.symmetric(
      //         horizontal: getWidth(context, 16),
      //       ),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           SizedBox(
      //             height: getHeight(context, 12),
      //           ),
      //           SizedBox(
      //             height: getHeight(context, 202),
      //             width: getWidth(context, 343),
      //             child: Image.network(
      //               state.currentModel!.bigImage,
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //           SizedBox(
      //             height: getHeight(context, 5),
      //           ),
      //           Center(
      //             child: Text(
      //               state.currentModel!.label,
      //               style: TextLocalStyles.roboto500.copyWith(
      //                 color: Colors.white,
      //                 fontSize: 16,
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             height: getHeight(context, 8),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 'Cобрано ${sumToString(state.currentModel!.alreadyGet)}',
      //                 style: TextLocalStyles.roboto600.copyWith(
      //                   fontSize: 16,
      //                   color: AppTheme.mainGreenColor,
      //                 ),
      //               ),
      //               Text(
      //                 'Внесено ${sumToString(context.read<BuyTogetherBloc>().state.additionalSum)}',
      //                 style: TextLocalStyles.roboto600.copyWith(
      //                   fontSize: 16,
      //                   color: AppTheme.moneyScaleGreenColor,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: getHeight(context, 5),
      //           ),
      //           Row(
      //             children: [
      //               Expanded(
      //                 flex: state.currentModel!.alreadyGet,
      //                 child: Container(
      //                   height: 38,
      //                   decoration: const BoxDecoration(
      //                     borderRadius: BorderRadius.only(
      //                       topLeft: Radius.circular(1.5),
      //                       bottomLeft: Radius.circular(1.5),
      //                     ),
      //                     gradient: AppTheme.moneyCollectedScaleWidgetGradientColor1,
      //                   ),
      //                 ),
      //               ),
      //               Container(
      //                 width: 1,
      //                 height: 44,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(1.5),
      //                   color: AppTheme.mainGreenColor,
      //                 ),
      //               ),
      //               if (context.read<BuyTogetherBloc>().state.additionalSum > 0) ...[
      //                 Expanded(
      //                   flex: context.read<BuyTogetherBloc>().state.additionalSum,
      //                   child: Container(
      //                     height: 38,
      //                     decoration: const BoxDecoration(
      //                       borderRadius: BorderRadius.only(
      //                         topLeft: Radius.circular(1.5),
      //                         bottomLeft: Radius.circular(1.5),
      //                       ),
      //                       gradient: LinearGradient(
      //                         colors: [
      //                           Color.fromRGBO(127, 164, 234, 1),
      //                           Color.fromRGBO(127, 164, 234, 0.9),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   width: 1,
      //                   height: 44,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(1.5),
      //                     color: AppTheme.mainGreenColor,
      //                   ),
      //                 ),
      //               ],
      //               Expanded(
      //                 flex: state.currentModel!.fullPrice -
      //                     state.currentModel!.alreadyGet -
      //                     context.read<BuyTogetherBloc>().state.additionalSum,
      //                 child: Container(
      //                   height: 38,
      //                   decoration: const BoxDecoration(
      //                       borderRadius: BorderRadius.only(
      //                           topRight: Radius.circular(1.5), bottomRight: Radius.circular(1.5)),
      //                       gradient: AppTheme.moneyCollectedScaleWidgetGradientColor2),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: getHeight(context, 5),
      //           ),
      //           Align(
      //             alignment: Alignment.centerRight,
      //             child: Text(
      //               'Осталось ${sumToString(state.currentModel!.fullPrice - state.currentModel!.alreadyGet)}',
      //               style: TextLocalStyles.roboto600.copyWith(
      //                 fontSize: 16,
      //                 color: AppTheme.mainPinkColor,
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             height: getHeight(context, 21),
      //           ),
      //           Text(
      //             "Дата и время вручения подарка",
      //             style: TextLocalStyles.roboto400.copyWith(
      //               color: const Color.fromRGBO(240, 247, 254, 1),
      //               fontSize: getHeight(context, 16),
      //               height: 16.41 / 14,
      //             ),
      //           ),
      //           SizedBox(
      //             height: getHeight(context, 4),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               PickContainer(
      //                 height: getHeight(context, 48),
      //                 width: getWidth(context, 168),
      //                 label: context.read<DateTimeBloc>().date.isNotEmpty
      //                     ? dateToString(context.read<DateTimeBloc>().date)
      //                     : context.read<PostcardBloc>().state.currentHolidayType ==
      //                             HolidayType.birthday
      //                         ? dateToString(context
      //                             .read<PostcardBloc>()
      //                             .state
      //                             .mapOfEvents['День рождения']![0])
      //                         : dateToString(context
      //                             .read<PostcardBloc>()
      //                             .state
      //                             .mapOfEvents['Еженедельный стрим']![0]),
      //               ),
      //               PickContainer(
      //                 height: getHeight(context, 48),
      //                 width: getWidth(context, 168),
      //                 label: context.read<DateTimeBloc>().time.isNotEmpty
      //                     ? timeToString(context.read<DateTimeBloc>().time)
      //                     : context.read<PostcardBloc>().state.currentHolidayType ==
      //                             HolidayType.birthday
      //                         ? timeToString(context
      //                             .read<PostcardBloc>()
      //                             .state
      //                             .mapOfEvents['День рождения']![1])
      //                         : timeToString(context
      //                             .read<PostcardBloc>()
      //                             .state
      //                             .mapOfEvents['Еженедельный стрим']![1]),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: getHeight(context, 36),
      //           ),
      //           Row(
      //             children: [
      //               InkWell(
      //                 onTap: () {
      //                   isPickedFirst = !isPickedFirst;
      //                   setState(() {});
      //                 },
      //                 child: SizedBox(
      //                   height: getHeight(context, 24),
      //                   width: getHeight(context, 24),
      //                   child: DecoratedBox(
      //                     decoration: BoxDecoration(
      //                       color: const Color.fromRGBO(52, 54, 62, 1),
      //                       borderRadius: BorderRadius.circular(2),
      //                       border: Border.all(
      //                         color: const Color.fromRGBO(66, 68, 77, 1),
      //                         width: 1.5,
      //                       ),
      //                     ),
      //                     child: isPickedFirst ? SvgPicture.asset('assets/svg/check.svg') : null,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: getWidth(context, 10),
      //               ),
      //               Text(
      //                 'Деньги на подарок внесены ',
      //                 style: TextLocalStyles.roboto500.copyWith(
      //                   color: AppTheme.mainGreenColor,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: getHeight(context, 20),
      //           ),
      //           Row(
      //             children: [
      //               InkWell(
      //                 onTap: () {
      //                   isPickedSecond = !isPickedSecond;
      //                   setState(() {});
      //                 },
      //                 child: SizedBox(
      //                   height: getHeight(context, 24),
      //                   width: getHeight(context, 24),
      //                   child: DecoratedBox(
      //                     decoration: BoxDecoration(
      //                       color: const Color.fromRGBO(52, 54, 62, 1),
      //                       borderRadius: BorderRadius.circular(2),
      //                       border: Border.all(
      //                         color: const Color.fromRGBO(66, 68, 77, 1),
      //                         width: 1.5,
      //                       ),
      //                     ),
      //                     child: isPickedSecond ? SvgPicture.asset('assets/svg/check.svg') : null,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: getWidth(context, 10),
      //               ),
      //               Text(
      //                 'Открытку или пожелания в чат написать ',
      //                 style: TextLocalStyles.roboto500.copyWith(
      //                   color: AppTheme.mainGreenColor,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: getHeight(context, 20),
      //           ),
      //           Row(
      //             children: [
      //               InkWell(
      //                 onTap: () {
      //                   isPickedThird = !isPickedThird;
      //                   setState(() {});
      //                 },
      //                 child: SizedBox(
      //                   height: getHeight(context, 24),
      //                   width: getHeight(context, 24),
      //                   child: DecoratedBox(
      //                     decoration: BoxDecoration(
      //                       color: const Color.fromRGBO(52, 54, 62, 1),
      //                       borderRadius: BorderRadius.circular(2),
      //                       border: Border.all(
      //                         color: const Color.fromRGBO(66, 68, 77, 1),
      //                         width: 1.5,
      //                       ),
      //                     ),
      //                     child: isPickedThird ? SvgPicture.asset('assets/svg/check.svg') : null,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: getWidth(context, 10),
      //               ),
      //               Text(
      //                 'Напоминать мне об on-line мероприятии ',
      //                 style: TextLocalStyles.roboto500.copyWith(
      //                   color: AppTheme.mainGreenColor,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: getHeight(context, 20),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               MvpGradientButton(
      //                 label: 'На стартовую\nстраницу ',
      //                 gradient: AppTheme.mainPurpleGradient,
      //                 width: getWidth(context, 109),
      //               ),
      //               MvpGradientButton(
      //                 label: 'На витрину\nподарков',
      //                 gradient: AppTheme.mainGreenGradient,
      //                 width: getWidth(context, 109),
      //               ),
      //               MvpGradientButton(
      //                 label: 'В календарь\nпраздников ',
      //                 gradient: AppTheme.mainGreenGradient,
      //                 width: getWidth(context, 109),
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
