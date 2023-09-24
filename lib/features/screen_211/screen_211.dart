import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_event.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
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
    pickedTime =
        '${nowTime.hour} : ${nowTime.minute < 10 ? '0${nowTime.minute}' : '${nowTime.minute}'}';
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
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return Column(
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
                    'MSK - ${nowTime.hour} : ${nowTime.minute < 10 ? '0${nowTime.minute}' : '${nowTime.minute}'}',
                    style: TextLocalStyles.roboto500.copyWith(
                      color: state.timeScreenTextColor,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    '${nowTime.day > 10 ? '${nowTime.day}' : '0${nowTime.day}'} ${switchMonthToString(nowTime.month)} ${nowTime.year}',
                    style: TextLocalStyles.roboto500.copyWith(
                      color: state.timeScreenTextColor,
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
                color: state.dockColor,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        color: state.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      DateTime.now().hour,
                      DateTime.now().minute + (5 - DateTime.now().minute % 5),
                    ),
                    minuteInterval: 5,
                    onDateTimeChanged: (DateTime value) {
                      pickedTime =
                          '${value.hour} : ${value.minute < 10 ? '0${value.minute}' : '${value.minute}'}';
                      setState(() {});
                    },
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                    minimumDate:
                        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9),
                    maximumDate:
                        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22),
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
                  color: state.dockColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '(UTC+03:00) Волгоград, Москва, Санкт-Петербург',
                        style: TextLocalStyles.roboto400.copyWith(
                          color: state.timeScreenPickTextColor,
                          fontSize: 12,
                        ),
                      ),
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
                    opacity: 0.3,
                    label: 'Подтвердить\nвремя $pickedTime',
                    gradient: AppTheme.mainGreenGradient,
                    width: getWidth(context, 164),
                    onTap: () {
                      context.read<DateTimeBloc>().add(ChangeTimeEvent(time: pickedTime));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  String switchMonthToString(int month, {bool isNative = false}) {
    switch (month) {
      case 1:
        return isNative ? 'Январь' : 'января';
      case 2:
        return isNative ? 'Февраль' : 'февраля';
      case 3:
        return isNative ? 'Март' : 'марта';
      case 4:
        return isNative ? 'Апрель' : 'апреля';
      case 5:
        return isNative ? 'Май' : 'мая';
      case 6:
        return isNative ? 'Июнь' : 'июня';
      case 7:
        return isNative ? 'Июль' : 'июля';
      case 8:
        return isNative ? 'Август' : 'августа';
      case 9:
        return isNative ? 'Сентябрь' : 'сентября';
      case 10:
        return isNative ? 'Октябрь' : 'октября';
      case 11:
        return isNative ? 'Ноябрь' : 'ноября';
      case 12:
        return isNative ? 'Декабрь' : 'декабря';
      default:
        return 'Ошибка';
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    timer = null;
  }
}
