import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

part 'action_button.dart';

part 'postcard_view.dart';

part 'pick_container.dart';

class Screen213 extends StatefulWidget {
  const Screen213({super.key});

  @override
  State<Screen213> createState() => _Screen213State();
}

class _Screen213State extends State<Screen213> {
  static const postcards = [
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
  ];

  List<String> holidays = [
    'Еженедельный стрим',
    'День рождения',
  ];
  String? currentHoliday;
  int i = 6;

  Map<String, List<String>> holidaysDateAndTime ={
    'Еженедельный стрим': [
      '28.07',
      '21.00',
    ],
    'День рождения': [
      '17.05.2024',
      '19.00',
    ],
  };

  @override
  void initState() {
    super.initState();

    currentHoliday = holidays[0];
  }

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Подписать открытку\nили сообщение для чата',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 20),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionButton(
                    label: 'Чат-телеграмм\nличный',
                  ),
                  ActionButton(
                    label: 'Чат-телеграмм\nгрупповой',
                  ),
                  ActionButton(
                    label: 'Приложить\nк подарку ',
                    hasStar: true,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 16),
                ),
              ),
              PostCardViewWidget(
                postcards: postcards,
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
                  fontSize: getHeight(context, 12),
                  height: 16.41 / 14,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 16),
                ),
              ),
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
                        focusColor: Colors.transparent,
                        dropdownColor: const Color.fromRGBO(52, 54, 62, 1),
                        items: holidays.map(
                          (value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextLocalStyles.roboto400.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PickContainer(
                    height: getHeight(context, 34),
                    width: getWidth(context, 169),
                    label: holidaysDateAndTime[currentHoliday!]![0],
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => const Screen28()));
                    },
                  ),
                  PickContainer(
                    height: getHeight(context, 34),
                    width: getWidth(context, 169),
                    label: holidaysDateAndTime[currentHoliday!]![1],
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => const Screen211()));
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 14),
                ),
              ),
              CustomTextField(
                height: getHeight(context, 120),
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
                onTap: (){
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
        ),
      ),
    );
  }
}
