import 'dart:async';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    currentMonth = dateTime.month;
    listOfDates = buildListOfDates(currentMonth);
    currentTime = calculateCurrentTime();
    currentDate = calculateCurrentDate();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        currentTime = calculateCurrentTime();
        setState(() {});
      },
    );
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
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      currentDate,
                      style: TextLocalStyles.roboto500.copyWith(
                        color: Colors.white,
                        fontSize: 17,
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
                  '${switchMonthToString(currentMonth, isNative: true)} ${dateTime.year}',
                  style: TextLocalStyles.roboto500.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                const Expanded(child: SizedBox()),
                GradientAnimatedIconButton(
                  icon: 'assets/svg/arrow_up.svg',
                  onPressed: () {
                    currentMonth--;
                    listOfDates = buildListOfDates(currentMonth);
                    setState(() {});
                  },
                ),
                SizedBox(
                  width: getWidth(context, 24),
                ),
                GradientAnimatedIconButton(
                  icon: 'assets/svg/arrow_down_big.svg',
                  onPressed: () {
                    currentMonth++;
                    listOfDates = buildListOfDates(currentMonth);
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
                        Padding(padding: EdgeInsets.only(top: getHeight(context, 14))),
                        SizedBox(
                          height: getHeight(context, 39),
                          width: getWidth(context, 39),
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(70, 72, 81, 1),
                                  Color.fromRGBO(40, 43, 51, 1),
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
              label: 'ОК',
              gradient: AppTheme.mainGreenGradient,
              width: getWidth(context, 164),
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

  List<int> buildListOfDates(int currentMonth) {
    final List<int> listOfDates = [];

    DateTime nowDateTime = DateTime.now();

    var firstDateOfMonth = DateTime(nowDateTime.year, currentMonth, 1);

    var previousMonthInDays = switchMonthInDays(currentMonth - 1);
    var currentMonthInDays = switchMonthInDays(currentMonth);

    for (int i = firstDateOfMonth.weekday - 1; i > 0; i--) {
      listOfDates.add(previousMonthInDays - i + 1);
    }

    for (int i = 0; i < currentMonthInDays; i++) {
      listOfDates.add(i + 1);
    }
    int lenOfList = listOfDates.length;
    for (int i = 0; i < 42 - lenOfList; i++) {
      listOfDates.add(i + 1);
    }
    setState(() {});
    return listOfDates;
  }
}
