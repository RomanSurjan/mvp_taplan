import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_event.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen211 extends StatefulWidget {
  const Screen211({super.key});

  @override
  State<Screen211> createState() => _Screen211State();
}

class _Screen211State extends State<Screen211> {
  var nowTime = DateTime.now();
  late Timer? timer;

  String pickedTime = '';

  @override
  void initState() {
    super.initState();
    pickedTime = '${nowTime.hour} : ${nowTime.minute < 10 ? '0${nowTime.minute}' :'${nowTime.minute}'}';
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        var now = DateTime.now();
        if (now.minute != nowTime.minute) {
          nowTime = now;
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Выбор времени',
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 98),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getWidth(context, 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MSK - ${nowTime.hour} : ${nowTime.minute < 10 ? '0${nowTime.minute}' :'${nowTime.minute}' }',
                  style: TextLocalStyles.roboto500.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                Text(
                  '02 июля 2023',
                  style: TextLocalStyles.roboto500.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 24),
            ),
          ),
          SizedBox(
            height: getHeight(context, 232),
            width: getWidth(context, 375),
            child: ColoredBox(
              color: const Color.fromRGBO(52, 54, 62, 1),
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(color: Colors.white),
                  ),
                ),
                child: CupertinoDatePicker(
                  onDateTimeChanged: (DateTime value) {
                    pickedTime = '${value.hour} : ${value.minute < 10 ? '0${value.minute}' : '${value.minute}'}';
                    setState(() {});
                  },
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 24),
            ),
          ),
          SizedBox(
            height: getHeight(context, 44),
            width: getWidth(context, 343),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromRGBO(66, 68, 77, 1),
                  width: 1.2,
                ),
                color: const Color.fromRGBO(52, 54, 62, 1),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '(UTC+03:00) Волгоград, Москва, Санкт-Петербург',
                      style: TextLocalStyles.roboto400.copyWith(
                        color: const Color.fromRGBO(244, 199, 217, 1),
                        fontSize: 12,
                      ),
                    ),
                    // SizedBox(
                    //   height: getHeight(context, 20),
                    //   width: getWidth(context, 20),
                    //   child: DecoratedBox(
                    //     decoration: const BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: Color.fromRGBO(69, 78, 84, 1),
                    //     ),
                    //     child: Center(
                    //       child: SvgPicture.asset(
                    //         'assets/svg/arrow_down.svg',
                    //         height: getHeight(context, 16),
                    //         width: getWidth(context, 16),
                    //         colorFilter: const ColorFilter.mode(
                    //           Color.fromRGBO(143, 153, 163, 1),
                    //           BlendMode.srcIn,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 136),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: SizedBox()),
                MvpGradientButton(
                  label: 'Подтвердить время\n$pickedTime',
                  gradient: AppTheme.mainGreenGradient,
                  width: getWidth(context, 164),
                  onTap: (){
                    context.read<DateTimeBloc>().add(ChangeTimeEvent(time: pickedTime));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
