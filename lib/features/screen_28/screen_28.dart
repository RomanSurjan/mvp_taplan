import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_event.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen28 extends StatefulWidget {
  const Screen28({super.key});

  @override
  State<Screen28> createState() => _Screen28State();
}

class _Screen28State extends State<Screen28> {
  static const daysOfWeek = [
    'П',
    'В',
    'C',
    'Ч',
    'П',
    'С',
    'В',
  ];

  DateTime dateTime = DateTime.now();
  late String currentTime;
  late String currentDate;
  late Timer timer;
  List<int> listOfDates = [];
  int currentMonth = 0;
  int currentYear = 0;
  int currentDay = 0;
  int currentDayIndex = 0;

  String buttonLabel = '';

  int pickedDate = -1;

  @override
  void initState() {
    super.initState();

    currentMonth = dateTime.month;
    currentYear = dateTime.year;
    currentDay = dateTime.day;

    listOfDates = buildListOfDates(currentMonth, currentYear, currentDay);
    currentTime = calculateCurrentTime();
    currentDate = calculateCurrentDate();

    buttonLabel =
        '${listOfDates[currentDayIndex]}.${currentMonth < 10 ? '0$currentMonth' : '$currentMonth'}.$currentYear';

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        currentTime = calculateCurrentTime();
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Календарь',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: getWidth(context, 375),
            height: getHeight(context, 60),
            child: ColoredBox(
              color: const Color.fromRGBO(66, 157, 132, 1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentTime,
                      style: TextLocalStyles.roboto400.copyWith(
                        color: Colors.white70,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      currentDate,
                      style: TextLocalStyles.roboto500.copyWith(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: getHeight(context, 30))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
            child: Row(
              children: [
                Text(
                  '${switchMonthToString(currentMonth, isNative: true)} $currentYear',
                  style: TextLocalStyles.roboto500.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                const Expanded(child: SizedBox()),
                GradientAnimatedIconButton(
                  icon: 'assets/svg/arrow_up.svg',
                  onPressed: () {
                    if (currentMonth - 1 > 1) {
                      currentMonth--;
                      listOfDates = currentMonth == dateTime.month
                          ? buildListOfDates(currentMonth, currentYear, currentDay)
                          : buildListOfDates(currentMonth, currentYear, -1);
                      pickedDate = -1;
                      setState(() {});
                    }
                  },
                ),
                SizedBox(
                  width: getWidth(context, 24),
                ),
                GradientAnimatedIconButton(
                  icon: 'assets/svg/arrow_down_big.svg',
                  onPressed: () {
                    if (currentMonth + 1 < 12) {
                      currentMonth++;
                      listOfDates = currentMonth == dateTime.month
                          ? buildListOfDates(currentMonth, currentYear, currentDay)
                          : buildListOfDates(currentMonth, currentYear, -1);
                    } else {
                      currentMonth = 1;
                      currentYear++;
                      listOfDates = currentMonth == dateTime.month
                          ? buildListOfDates(currentMonth, currentYear, currentDay)
                          : buildListOfDates(currentMonth, currentYear, -1);
                    }
                    pickedDate = -1;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: getHeight(context, 24))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 18)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < daysOfWeek.length; i++)
                  Column(
                    children: [
                      Text(
                        daysOfWeek[i],
                        style: TextLocalStyles.roboto600.copyWith(
                          color: i + 1 == daysOfWeek.length || i + 2 == daysOfWeek.length
                              ? const Color.fromRGBO(218, 80, 80, 1)
                              : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: getHeight(context, 6))),
                      for (int j = 0; j < daysOfWeek.length - 1; j++) ...[
                        Padding(padding: EdgeInsets.only(top: getHeight(context, 20))),
                        InkWell(
                          onTap: () {
                            pickedDate = i + j * daysOfWeek.length;
                            buttonLabel =
                                '${listOfDates[pickedDate]}.${currentMonth < 10 ? '0$currentMonth' : '$currentMonth'}.$currentYear';

                            setState(() {});
                          },
                          child: SizedBox(
                            height: getHeight(context, 39),
                            width: getWidth(context, 39),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: i + j * daysOfWeek.length == currentDayIndex && currentMonth == dateTime.month
                                      ? [
                                          const Color.fromRGBO(211, 102, 137, 1),
                                          const Color.fromRGBO(241, 171, 193, 1),
                                        ]
                                      : i + j * daysOfWeek.length == pickedDate
                                          ? [
                                              const Color(0xFF62C6AA),
                                              const Color(0xFF44A88C),
                                            ]
                                          : [
                                              const Color.fromRGBO(70, 72, 81, 1),
                                              const Color.fromRGBO(40, 43, 51, 1),
                                            ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  listOfDates[i + j * daysOfWeek.length].toString(),
                                  style: TextLocalStyles.roboto400.copyWith(
                                    color: (i + j * daysOfWeek.length) < listOfDates.indexOf(1)
                                        ? const Color.fromRGBO(143, 153, 163, 1)
                                        : (i + j * daysOfWeek.length) >
                                                (switchMonthInDays(currentMonth) +
                                                    listOfDates.indexOf(1) -
                                                    1)
                                            ? AppTheme.mainGreenColor
                                            : Colors.white,
                                    fontSize: 16,
                                    decoration: (i + j * daysOfWeek.length) >
                                            (switchMonthInDays(currentMonth) +
                                                listOfDates.indexOf(1) -
                                                1)
                                        ? TextDecoration.underline
                                        : null,
                                    decorationColor: AppTheme.mainGreenColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 24),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: getWidth(context, 16),
            ),
            child: MvpGradientButton(
              label: 'Подтвердить дату\n$buttonLabel',
              gradient: AppTheme.mainGreenGradient,
              width: getWidth(context, 164),
              onTap: () {
                context.read<DateTimeBloc>().add(ChangeDateEvent(date: buttonLabel));
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  String calculateCurrentTime() {
    DateTime nowDateTime = DateTime.now();

    String hour = nowDateTime.hour < 10 ? '0${nowDateTime.hour}' : '${nowDateTime.hour}';
    String minute = nowDateTime.minute < 10 ? '0${nowDateTime.minute}' : '${nowDateTime.minute}';
    String seconds = nowDateTime.second < 10 ? '0${nowDateTime.second}' : '${nowDateTime.second}';

    return '$hour : $minute : $seconds';
  }

  String calculateCurrentDate() {
    DateTime nowDateTime = DateTime.now();

    String day = nowDateTime.day < 10 ? '0${nowDateTime.day}' : '${nowDateTime.day}';
    String month = switchMonthToString(nowDateTime.month);
    String year = nowDateTime.year.toString();

    return '$day $month $year';
  }

  String switchMonthToString(int month, {bool isNative = false}) {
    switch (month) {
      case 1:
        return isNative ? 'Январь' : 'Января';
      case 2:
        return isNative ? 'Февраль' : 'Февраля';
      case 3:
        return isNative ? 'Март' : 'Марта';
      case 4:
        return isNative ? 'Апрель' : 'Апреля';
      case 5:
        return isNative ? 'Май' : 'Мая';
      case 6:
        return isNative ? 'Июнь' : 'Июня';
      case 7:
        return isNative ? 'Июль' : 'Июля';
      case 8:
        return isNative ? 'Август' : 'Августа';
      case 9:
        return isNative ? 'Сентябрь' : 'Сентября';
      case 10:
        return isNative ? 'Октябрь' : 'Октября';
      case 11:
        return isNative ? 'Ноябрь' : 'Ноября';
      case 12:
        return isNative ? 'Декабрь' : 'Декабря';
      default:
        return 'Ошибка';
    }
  }

  int switchMonthInDays(int currentMonth) {
    switch (currentMonth) {
      case 1:
        return 31;
      case 2:
        return 28;
      case 3:
        return 31;
      case 4:
        return 30;
      case 5:
        return 31;
      case 6:
        return 30;
      case 7:
        return 31;
      case 8:
        return 31;
      case 9:
        return 30;
      case 10:
        return 31;
      case 11:
        return 30;
      case 12:
        return 31;
      default:
        return 0;
    }
  }

  List<int> buildListOfDates(int currentMonth, int currentYear, int currentDay) {
    final List<int> listOfDates = [];

    var firstDateOfMonth = DateTime(currentYear, currentMonth, 1);

    var previousMonthInDays = switchMonthInDays(currentMonth - 1);
    var currentMonthInDays = switchMonthInDays(currentMonth);

    for (int i = firstDateOfMonth.weekday - 1; i > 0; i--) {
      listOfDates.add(previousMonthInDays - i + 1);
    }

    var lengthList = listOfDates.length;

    for (int i = 0; i < currentMonthInDays; i++) {
      listOfDates.add(i + 1);
      if (i == currentDay) {
        currentDayIndex = i + lengthList - 1;
      }
    }
    int lenOfList = listOfDates.length;
    for (int i = 0; i < 42 - lenOfList; i++) {
      listOfDates.add(i + 1);
    }
    setState(() {});
    return listOfDates;
  }
}
