import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_state.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_bloc.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
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

  const Screen213({
    super.key,
    required this.additionalSum,
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

  bool isVisible = false;
  bool isMainButtonActive = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    isMainButtonActive = controller.text.isNotEmpty;
    currentHoliday = context.read<PostcardBloc>().state.mapOfEvents.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Подписать открытку\nили сообщение для чата',
      child: Stack(
        children: [
          BlocBuilder<PostcardBloc, PostcardState>(
            builder: (context, state) {
              final mapOfEvents = state.mapOfEvents;

              mapOfEvents.addAll({
                state.nameOfEvents[i]: ['', ''],
              });

              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: getHeight(context, 14),
                        ),
                      ),
                      PostCardViewWidget(
                        currentIndex: i,
                        onPageChanged: (index) {
                          if (index > i) {
                            i = index;
                            currentHoliday = state.nameOfEvents[i];
                            mapOfEvents.remove(state.nameOfEvents[i - 1]);
                            mapOfEvents.addAll({
                              state.nameOfEvents[i]: ['', '']
                            });
                          } else {
                            i = index;
                            currentHoliday = state.nameOfEvents[i];
                            mapOfEvents.remove(state.nameOfEvents[i + 1]);
                            mapOfEvents.addAll({
                              state.nameOfEvents[i]: ['', '']
                            });
                          }

                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getHeight(context, 14),
                        ),
                      ),
                      CustomTextField(
                        height: getHeight(context, 100),
                        width: getWidth(context, 343),
                        hintText: 'Текст открытки',
                        controller: controller,
                        maxLines: 10,
                        onChanged: (value) {
                          isMainButtonActive = controller.text.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getHeight(context, 6),
                        ),
                      ),
                      CustomTextField(
                        height: getHeight(context, 40),
                        width: getWidth(context, 343),
                        hintText: 'Подпись',
                        maxLines: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getHeight(context, 16),
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
                              isActive: widget.additionalSum >= 1000,
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
                          top: getHeight(context, 6),
                        ),
                      ),
                      Text(
                        '* Бесплатная печатная открытка при подарке от ₽1000',
                        style: TextLocalStyles.roboto500.copyWith(
                          color: const Color.fromRGBO(110, 210, 182, 1),
                          fontSize: getHeight(context, 16),
                          height: 16.41 / 14,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getHeight(context, 16),
                        ),
                      ),
                      currentHolidayType(state.currentHolidayType, i, mapOfEvents),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getHeight(context, 16),
                        ),
                      ),
                      PostcardButton(
                        fontSize: 15,
                        fontHeight: 17.58 / 15,
                        isActive: isMainButtonActive,
                        onTap: () {
                          isVisible = true;
                          Future.delayed(const Duration(milliseconds: 900), () {
                            isVisible = false;
                            setState(() {});
                          });
                          setState(() {});
                          if (isMainButtonActive) {
                            Future.delayed(const Duration(milliseconds: 1100), () {
                              Navigator.pop(context);
                            });
                          }
                        },
                        width: getWidth(context, 348),
                        height: getHeight(context, 46),
                        text:
                            'Опубликовать в назначенное время и/или\nприложить открытку к подарку',
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Visibility(
            visible: isVisible,
            child: Positioned(
              top: getHeight(context, 590),
              left: getWidth(context, 114),
              right: getWidth(context, 114),
              child: SizedBox(
                height: getHeight(context, 32),
                width: getWidth(context, 176),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.61),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                    child: Text(
                      controller.text.isEmpty ? 'Сообщение не введено' : 'Сообщение сохранено',
                      style: TextLocalStyles.roboto500.copyWith(
                        fontSize: 14,
                        height: 16.41 / 14,
                        color: const Color.fromRGBO(57, 57, 57, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget currentHolidayType(HolidayType currentHolidayType, int i, Map<String, List> mapOfEvents) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<DateTimeBloc, DateTimeState>(
          builder: (context, dateTimeState) {
            final currentDate = mapOfEvents[currentHoliday]![0].isEmpty
                ? dateTimeState.date.isEmpty
                    ? "Выберите дату"
                    : dateTimeState.date
                : dateToString(mapOfEvents[currentHoliday]![0]);

            final currentTime = mapOfEvents[currentHoliday]![1].isEmpty
                ? dateTimeState.time.isEmpty
                    ? "Выберите время"
                    : dateTimeState.time
                : timeToString(mapOfEvents[currentHoliday]![1]);

            return switch (currentHolidayType) {
              (HolidayType.just) => Column(
                  children: [
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: getHeight(context, 11),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 34),
                      width: getWidth(context, 343),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: themeState.dockColor,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1.2,
                            color: themeState.postcardContainerBorderColor,
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
                              dropdownColor: themeState.dockColor,
                              items: mapOfEvents.keys.map(
                                (value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextLocalStyles.roboto400.copyWith(
                                        color: value == currentHoliday
                                            ? themeState.postcardContainerTextColor
                                            : AppTheme.moneyScaleGreenColor,
                                        fontSize: getHeight(context, 16),
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
                  ],
                ),
              (HolidayType.birthday) => Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PickContainer(
                            height: getHeight(context, 34),
                            width: getWidth(context, 169),
                            label: dateToString(mapOfEvents['День рождения']![0]),
                            onTap: () {},
                          ),
                          PickContainer(
                            height: getHeight(context, 34),
                            width: getWidth(context, 169),
                            label: timeToString(mapOfEvents['День рождения']![1]),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getHeight(context, 11),
                      ),
                    ),
                    PickContainer(
                      height: getHeight(context, 34),
                      width: getWidth(context, 343),
                      label: 'День рождения',
                    ),
                  ],
                ),
              (HolidayType.stream) => Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PickContainer(
                            height: getHeight(context, 34),
                            width: getWidth(context, 169),
                            label: dateToString(mapOfEvents['Еженедельный стрим']![0]),
                            onTap: () {},
                          ),
                          PickContainer(
                            height: getHeight(context, 34),
                            width: getWidth(context, 169),
                            label: timeToString(mapOfEvents['Еженедельный стрим']![1]),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getHeight(context, 11),
                      ),
                    ),
                    PickContainer(
                      height: getHeight(context, 34),
                      width: getWidth(context, 343),
                      label: 'Еженедельный стрим',
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
