import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_state.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_bloc.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_state.dart';
import 'package:mvp_taplan/features/screen_211/screen_211.dart';
import 'package:mvp_taplan/features/screen_213/action_button.dart';
import 'package:mvp_taplan/features/screen_28/screen_28.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

part 'postcard_view.dart';

part 'pick_container.dart';

class Screen213 extends StatefulWidget {
  final int additionalSum;
  final List? additionalHoliday;

  const Screen213({
    super.key,
    required this.additionalSum,
    this.additionalHoliday,
  });

  @override
  State<Screen213> createState() => _Screen213State();
}

class _Screen213State extends State<Screen213> {
  List<String> holidays = [
    'Еженедельный стрим',
    'День рождения',
  ];
  String? currentHoliday;
  int i = 4;
  bool isChecked = false;

  bool isPressedFirst = false;
  bool isPressedSecond = true;
  bool isPressedThird = false;

  @override
  void initState() {
    super.initState();

    currentHoliday = context.read<PostcardBloc>().state.mapOfEvents.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Подписать открытку\nили сообщение для чата',
      child: BlocBuilder<PostcardBloc, PostcardState>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PostcardButton(
                        text: 'Чат-телеграмм\nличный',
                        isPressed: isPressedFirst,
                        onTap: () {
                          isPressedFirst = !isPressedFirst;
                          setState(() {});
                        },
                      ),
                      PostcardButton(
                        isPressed: isPressedSecond,
                        text: 'Чат-телеграмм\nгрупповой',
                        onTap: () {
                          isPressedSecond = !isPressedSecond;
                          setState(() {});
                        },
                      ),
                      PostcardButton(
                        text: 'Приложить\nк подарку',
                        hasStar: true,
                        isPressed: isPressedThird,
                        onTap: () {
                          if (widget.additionalSum >= 1000) {
                            isPressedThird = !isPressedThird;
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 16),
                  ),
                ),
                PostCardViewWidget(
                  currentIndex: i,
                  onPageChanged: (index) {
                    i = index;
                    setState(() {});
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 16),
                  ),
                ),
                Text(
                  '* Бесплатная печатная открытка при подарке от ₽1000',
                  style: TextLocalStyles.roboto500.copyWith(
                    color: AppTheme.mainGreenColor,
                    fontSize: getHeight(context, 16),
                    height: 16.41 / 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 16),
                  ),
                ),
                currentHolidayType(state.currentHolidayType),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 14),
                  ),
                ),
                CustomTextField(
                  height: getHeight(context, 180),
                  width: getWidth(context, 343),
                  hintText: 'Текст открытки',
                  maxLines: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 16),
                  ),
                ),
                MvpGradientButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  label: 'Опубликовать в назначенное время и/или\nприложить открытку к подарку',
                  gradient: AppTheme.mainGreenGradient,
                  width: getWidth(context, 345),
                  height: getHeight(context, 46),
                  style: TextLocalStyles.roboto500.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget currentHolidayType(HolidayType currentHolidayType) {
    return BlocBuilder<PostcardBloc, PostcardState>(
      builder: (context, state) {
        return BlocBuilder<DateTimeBloc, DateTimeState>(
          builder: (context, dateTimeState) {
            final currentDate = state.mapOfEvents[currentHoliday]![0].isEmpty
                ? dateTimeState.date.isEmpty
                    ? "Выберите дату"
                    : dateTimeState.date
                : dateToString(state.mapOfEvents[currentHoliday]![0]);

            final currentTime = state.mapOfEvents[currentHoliday]![1].isEmpty
                ? dateTimeState.time.isEmpty
                    ? "Выберите время"
                    : dateTimeState.time
                : timeToString(state.mapOfEvents[currentHoliday]![1]);
            return switch (currentHolidayType) {
              (HolidayType.just) => Column(
                  children: [
                    SizedBox(
                      height: getHeight(context, 34),
                      width: getWidth(context, 343),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(52, 54, 62, 1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1.2,
                            color: const Color.fromRGBO(66, 68, 77, 1),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: getWidth(context, 10)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: currentHoliday,
                              icon: const MoreButton(),
                              isDense: true,
                              isExpanded: true,
                              dropdownColor: const Color.fromRGBO(52, 54, 62, 1),
                              items: state.mapOfEvents.keys.map(
                                (value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextLocalStyles.roboto400.copyWith(
                                        color: value == currentHoliday
                                            ? Colors.white
                                            : AppTheme.moneyScaleGreenColor,
                                        fontSize: 12,
                                        decoration: value == currentHoliday
                                            ? TextDecoration.none
                                            : TextDecoration.underline,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                currentHoliday = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getHeight(context, 11),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PickContainer(
                            height: getHeight(context, 34),
                            width: getWidth(context, 169),
                            label: currentDate,
                            onTap: () {
                              if (currentHoliday == 'Просто так') {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (_) => const Screen28()));
                              }
                            },
                          ),
                          PickContainer(
                            height: getHeight(context, 34),
                            width: getWidth(context, 169),
                            label: currentTime,
                            onTap: () {
                              if (currentHoliday == 'Просто так') {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (_) => const Screen211()));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              (HolidayType.birthday) => Column(
                  children: [
                    PickContainer(
                      height: getHeight(context, 34),
                      width: getWidth(context, 343),
                      label: 'День рождения',
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getHeight(context, 11),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PickContainer(
                            height: getHeight(context, 34),
                            width: getWidth(context, 169),
                            label: dateToString(state.mapOfEvents['День рождения']![0]),
                            onTap: () {},
                          ),
                          PickContainer(
                            height: getHeight(context, 34),
                            width: getWidth(context, 169),
                            label: timeToString(state.mapOfEvents['День рождения']![1]),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              (HolidayType.stream) => Column(
                  children: [
                    PickContainer(
                      height: getHeight(context, 34),
                      width: getWidth(context, 343),
                      label: 'Еженедельный стрим',
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getHeight(context, 11),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PickContainer(
                            height: getHeight(context, 34),
                            width: getWidth(context, 169),
                            label: dateToString(state.mapOfEvents['Еженедельный стрим']![0]),
                            onTap: () {},
                          ),
                          PickContainer(
                            height: getHeight(context, 34),
                            width: getWidth(context, 169),
                            label: timeToString(state.mapOfEvents['Еженедельный стрим']![1]),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            };
          },
        );
      },
    );
  }
}
