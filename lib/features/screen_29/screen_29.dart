import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/models/buttons.dart';
import 'package:mvp_taplan/features/screen_28/screen_28.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';

import 'package:flutter/material.dart';

class Screen29 extends StatefulWidget {
  const Screen29({super.key});

  @override
  State<Screen29> createState() => Screen29State();
}

class Screen29State extends State<Screen29> {
  late String token;

  void getToken() async {
    var url = 'https://qviz.fun/auth/token/login/';
    var dio = Dio();
    var response = await dio.post(url, data: {
      'phoneNumber': '+79611485522',
      'password': 'NatalyaPass',
    });
    setState(() {
      token = 'Token ${response.data['auth_token']}';
      log(token);
    });
  }

  Map contacts = {};
  ScrollController scrollController = ScrollController();

  void getContacts() async {
    var url = 'https://qviz.fun/api/v1/peoplelist/';
    var dio = Dio();
    var response = await dio.post(url,
        options:
            Options(headers: {'Authorization': "Token ec0d55b15a9a8cabb7951e88ee5333627043d1d4"}));
    log(response.data.toString());
    setState(() {
      contacts = response.data;
    });
    for (int i = 0; i < 5; i++) {
      for (int k = 0; k < int.parse(contacts['people'].length.toString()); k++) {
        if (contacts['people'][k]['cat'] == (i + 1)) {
          countContacts[i]++;
        }
      }
    }
  }

  static const images = [
    'assets/images/present_1.png',
    'assets/images/present_1.png',
    'assets/images/present_1.png',
    'assets/images/present_1.png',
    'assets/images/present_1.png',
    'assets/images/present_1.png',
  ];
  static const List<Color> buttonGroupColorMain = [
    Color.fromRGBO(83, 170, 190, 1),
    Color.fromRGBO(103, 143, 218, 1),
    Color.fromRGBO(123, 108, 232, 1),
    Color.fromRGBO(182, 104, 236, 1),
    Color.fromRGBO(237, 143, 232, 1),
  ];

  static const List<Color> groupColor = [
    Color.fromRGBO(45, 166, 193, 1),
    Color.fromRGBO(103, 143, 218, 1),
    Color.fromRGBO(123, 108, 232, 1),
    Color.fromRGBO(182, 104, 236, 1),
    Color.fromRGBO(123, 108, 232, 1),
  ];

  static const List<Color> buttonGroupColorCount = [
    Color.fromRGBO(181, 218, 227, 1),
    Color.fromRGBO(194, 210, 240, 1),
    Color.fromRGBO(201, 195, 245, 1),
    Color.fromRGBO(224, 192, 246, 1),
    Color.fromRGBO(248, 208, 246, 1),
  ];
  static const List<String> buttonGroupText = [
    "Семья",
    "Друзья",
    "Близкие",
    "Коллеги",
    "Партнеры",
  ];
  static const List<String> buttonGroupPicture = [
    "assets/svg/family.svg",
    "assets/svg/friends.svg",
    "assets/svg/folks.svg",
    "assets/svg/workmates.svg",
    "assets/svg/partners.svg",
  ];

  List<int> countContacts = [0, 0, 0, 0, 0];

  String data = "ДД.ММ.ГГГГ";

  Map buffContacts = {};
  Map visibleContacts = {};

  List<String> stateContact = ['Участник группового события', 'Виновник торжества', 'On-line участник'];

  bool isOk = false;
  List<String> strGroup = ['С', 'Д', 'Б', 'К', 'П'];
  List<bool> buttonNavIsPressed = [false, false, false, false, false];
  List<bool> buttonGroupIsPressed = [false, false, false, false, false];
  List<bool> buttonCelebrateIsPressed = [false, false];

  @override
  void initState() {
    super.initState();

    getToken();
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Ограничение круга лиц\nдля демонстрации дат',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 18),
            ),
          ),
          createEvent(context),
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 18),
            ),
          ),
          birthDay(context),
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 9),
            ),
          ),
          groupButtons(context),
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 24),
            ),
          ),
          pickCelebrate(context),
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 10),
            ),
          ),
          listOfChannels(context),
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 18),
            ),
          ),
          //bottomNavBar(context),
        ],
      ),
    );
  }

  Widget createEvent(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth(context, 16),
        ),
        child: Row(
          children: [
            SizedBox(
              height: getHeight(context, 54),
              width: getWidth(context, 54),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/present_1.png"),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Коллектив ООО “Таплан”',
                    style: TextLocalStyles.roboto500.copyWith(
                      color: context.read<ThemeBloc>().state.isDark
                          ? Colors.white
                          : const Color.fromRGBO(22, 26, 29, 1),
                      fontSize: 16,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 2),
                  ),
                  Text(
                    'г. Красноярск, Россия',
                    style: TextLocalStyles.roboto400.copyWith(
                      color: context.read<ThemeBloc>().state.isDark
                          ? const Color.fromRGBO(188, 192, 200, 1)
                          : const Color.fromRGBO(98, 118, 132, 1),
                      fontSize: 14,
                      height: 0,
                    ),
                  )
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            InkWell(
              onTap: () {},
              child: SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(98, 198, 170, 0.06),
                        Color.fromRGBO(68, 168, 140, 0.06),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: getHeight(context, 8),
                      horizontal: getWidth(context, 8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Создать\nсобытие',
                          style: TextLocalStyles.roboto400.copyWith(
                            color: const Color.fromRGBO(62, 174, 143, 1),
                            fontSize: 10,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: getHeight(context, 3),
                          ),
                        ),
                        SvgPicture.asset('assets/svg/add_event.svg'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget birthDay(BuildContext context) {
    return SizedBox(
      width: getWidth(context, 375),
      child: ColoredBox(
        color: context.watch<ThemeBloc>().state.isDark
            ? const Color.fromRGBO(0, 0, 0, 0.1)
            : const Color.fromRGBO(255, 255, 255, 0.75),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth(context, 16),
            vertical: getHeight(context, 8),
          ),
          child: Row(
            children: [
              SizedBox(
                height: getHeight(context, 54),
                width: getHeight(context, 54),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: getHeight(context, 54),
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(45, 166, 193, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: getHeight(context, 54),
                              child: const ColoredBox(
                                color: Color.fromRGBO(103, 143, 218, 1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: getHeight(context, 54),
                              child: const ColoredBox(
                                color: Color.fromRGBO(123, 108, 232, 1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: getHeight(context, 54),
                              child: const ColoredBox(
                                color: Color.fromRGBO(182, 104, 236, 1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: getHeight(context, 54),
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(236, 104, 207, 1),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Image.asset('assets/images/Rectangle.png'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: getWidth(context, 6),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'День рождения коллеги',
                      style: TextLocalStyles.roboto600.copyWith(
                        color: !context.read<ThemeBloc>().state.isDark
                            ? const Color.fromRGBO(65, 78, 88, 1)
                            : Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getHeight(context, 4),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: getHeight(context, 34),
                          width: getWidth(context, 121),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: !context.read<ThemeBloc>().state.isDark
                                  ? const Color.fromRGBO(250, 255, 255, 1)
                                  : const Color.fromRGBO(52, 54, 62, 1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: !context.read<ThemeBloc>().state.isDark
                                    ? const Color.fromRGBO(230, 241, 254, 1)
                                    : const Color.fromRGBO(66, 68, 77, 1),
                                width: 1.2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 5.5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: getHeight(context, 3)),
                                    child: Text(
                                      data,
                                      style: TextLocalStyles.roboto400.copyWith(
                                        color: !context.read<ThemeBloc>().state.isDark
                                            ? const Color.fromRGBO(157, 167, 176, 1)
                                            : const Color.fromRGBO(244, 199, 217, 1),
                                        fontSize: getHeight(context, 14),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: getWidth(context, 2),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getHeight(context, 20),
                                    width: getHeight(context, 20),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: !context.read<ThemeBloc>().state.isDark
                                            ? const Color.fromRGBO(237, 244, 251, 1)
                                            : const Color.fromRGBO(87, 99, 107, 1),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const Screen28(),
                                            ),
                                          );
                                          setState(
                                            () {
                                              data =
                                                  BlocProvider.of<DateTimeBloc>(context).state.date;
                                              if (data == '') data = "ДД.ММ.ГГГГ";
                                              if (dataIsOk(context)) {
                                                isOk = true;
                                              } else {
                                                isOk = false;
                                              }
                                            },
                                          );
                                        },
                                        child: const Icon(
                                          Icons.more_vert,
                                          size: 16,
                                          color: Color.fromRGBO(166, 173, 181, 1),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getWidth(context, 4),
                          ),
                        ),
                        SizedBox(
                          height: getHeight(context, 34),
                          width: getWidth(context, 121),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: !context.read<ThemeBloc>().state.isDark
                                  ? const Color.fromRGBO(250, 255, 255, 1)
                                  : const Color.fromRGBO(52, 54, 62, 1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: !context.read<ThemeBloc>().state.isDark
                                    ? const Color.fromRGBO(230, 241, 254, 1)
                                    : const Color.fromRGBO(66, 68, 77, 1),
                                width: 1.2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: SizedBox(
                                        width: getWidth(context, 85),
                                        child: groupCelebration(context)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: getWidth(context, 0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getHeight(context, 20),
                                    width: getHeight(context, 20),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: !context.read<ThemeBloc>().state.isDark
                                            ? const Color.fromRGBO(237, 244, 251, 1)
                                            : const Color.fromRGBO(87, 99, 107, 1),
                                      ),
                                      child: const Icon(
                                        Icons.more_vert,
                                        size: 16,
                                        color: Color.fromRGBO(166, 173, 181, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        SizedBox(
                          height: getHeight(context, 34),
                          width: getHeight(context, 34),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: !context.read<ThemeBloc>().state.isDark
                                  ? const Color.fromRGBO(221, 232, 245, 1)
                                  : const Color.fromRGBO(87, 99, 107, 1),
                            ),
                            child: Icon(
                              isOk ? Icons.check_rounded : Icons.question_mark_rounded,
                              color: const Color.fromRGBO(157, 167, 176, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget groupButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(context, 16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Показывать события в группах контакта',
              style: TextLocalStyles.roboto500.copyWith(
                color: const Color.fromRGBO(98, 198, 170, 1),
                fontSize: 16,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 5; i++)
                ButtonGroup(
                  count: countContacts[i],
                  colorMain: buttonGroupColorMain[i],
                  picture: buttonGroupPicture[i],
                  colorCount: buttonGroupColorCount[i],
                  text: buttonGroupText[i],
                  isPressed: buttonGroupIsPressed[i],
                  onTap: () {
                    if (countContacts[i] != 0) {
                      buttonGroupIsPressed[i] = !buttonGroupIsPressed[i];

                      if (dataIsOk(context)) {
                        isOk = true;
                      } else {
                        isOk = false;
                      }

                      for (int k = 0; k < int.parse(contacts['people'].length.toString()); k++) {


                        if (buttonGroupIsPressed[i] == true) {
                          if (contacts['people'][k]['cat'] == (i + 1)) {
                            buffContacts[contacts['people'][k]['id']] = contacts['people'][k];
                          }
                        } else {
                          if (buffContacts.containsKey(contacts['people'][k]['id']) &&
                              contacts['people'][k]['cat'] == (i + 1)) {
                            buffContacts.remove(contacts['people'][k]['id']);
                          }
                        }
                      }
                      visibleContacts.clear();
                      int j = 0;
                      buffContacts.forEach((key, value) {
                        visibleContacts[j] = value;
                        visibleContacts[j]['add'] = true;
                        visibleContacts[j]['state'] = 'Участник группового события';
                        j++;
                      });

                      setState(() {});
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  bool dataIsOk(BuildContext context) {
    return (data != "ДД.ММ.ГГГГ" &&
        ((buttonGroupIsPressed[0] != false ||
                buttonGroupIsPressed[1] != false ||
                buttonGroupIsPressed[2] != false ||
                buttonGroupIsPressed[3] != false ||
                buttonGroupIsPressed[4] != false) ||
            (buttonCelebrateIsPressed[0] != false || buttonCelebrateIsPressed[1] != false)));
  }

  Widget pickCelebrate(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(context, 16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Показывать праздник выборочно: ',
            style: TextLocalStyles.roboto500.copyWith(
              color: const Color.fromRGBO(98, 198, 170, 1),
              fontSize: 16,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 5),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PickCelebrateButton(
                isPressed: buttonCelebrateIsPressed[0],
                onTap: () {
                  setState(() {});
                  buttonCelebrateIsPressed[0] = !buttonCelebrateIsPressed[0];
                  buttonCelebrateIsPressed[1] = false;
                  if (dataIsOk(context)) {
                    isOk = true;
                  } else {
                    isOk = false;
                  }
                },
                label: 'Праздничное\nторжество',
              ),
              PickCelebrateButton(
                isPressed: buttonCelebrateIsPressed[1],
                onTap: () {
                  setState(() {});
                  buttonCelebrateIsPressed[1] = !buttonCelebrateIsPressed[1];
                  buttonCelebrateIsPressed[0] = false;
                  if (dataIsOk(context)) {
                    isOk = true;
                  } else {
                    isOk = false;
                  }
                },
                label: 'Групповое\nмероприятие',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listOfChannels(BuildContext context) {
    return Expanded(
      child: RawScrollbar(
        controller: scrollController,
        thumbVisibility: true,
        radius: Radius.circular(getWidth(context, 2)),
        thickness: getWidth(context, 4),
        trackVisibility: true,
        trackColor: const Color.fromRGBO(73, 88, 99, 1),
        thumbColor: const Color.fromRGBO(129, 140, 147, 1),
        trackRadius: Radius.circular(getWidth(context, 2)),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return DecoratedBox(
                decoration: BoxDecoration(
                  color:
                      (index % 2 == 0) ? Colors.transparent : context.read<ThemeBloc>().state.isDark ? const Color.fromRGBO(36, 38, 45, 1) : const Color.fromRGBO(100, 188, 238, 0.15),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(context, 16),
                  ),
                  child: channel(context, index: index),
                ));
          },
          itemCount: visibleContacts.length,
        ),
      ),
    );
  }

  Widget channel(
    BuildContext context, {
    required int index,
  }) {
    return Column(
      children: [
        SizedBox(
          height: getHeight(context, 3),
        ),
        Row(
          children: [
            SizedBox(
              height: getHeight(context, 54),
              width: getHeight(context, 54),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://qviz.fun/${visibleContacts[index]['person_photo']}'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getWidth(context, 8),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visibleContacts[index]['name'] + " (${index + 1}/${visibleContacts.length})",
                  style: TextLocalStyles.roboto500.copyWith(
                    color: !context.read<ThemeBloc>().state.isDark
                        ? const Color.fromRGBO(65, 78, 88, 1)
                        : Colors.white,
                    fontSize: 16,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 2),
                ),
                if (visibleContacts[index]['add'] == true) ...[
                  SizedBox(
                    height: 15,
                    width: getWidth(context, 200),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: visibleContacts[index]['state'],
                        icon: null,
                        iconSize: 0,
                        isDense: true,
                        isExpanded: true,
                        dropdownColor: context.read<ThemeBloc>().state.dockColor,
                        items: stateContact.map(
                              (value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextLocalStyles.roboto400.copyWith(
                                  color: AppTheme.moneyScaleGreenColor,
                                  fontSize: 14,
                                  decoration:  TextDecoration.underline,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          visibleContacts[index]['state'] = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ] else ...[
                  Text(
                    '   ',
                    style: TextLocalStyles.roboto500.copyWith(
                      color: const Color.fromRGBO(127, 164, 234, 0.81),
                      fontSize: 14,
                      height: 16.41 / 14,
                    ),
                  ),
                ],
                SizedBox(
                  height: getHeight(context, 2),
                ),
                Text(
                  visibleContacts[index]['region'],
                  style: TextLocalStyles.roboto400.copyWith(
                    color: !context.read<ThemeBloc>().state.isDark
                        ? const Color.fromRGBO(98, 118, 132, 1)
                        : const Color.fromRGBO(188, 192, 200, 1),
                    fontSize: getHeight(context, 14),
                    height: 0,
                  ),
                )
              ],
            ),
            const Expanded(child: SizedBox()),
            if (visibleContacts[index]['add'] == true) ...[
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 12),
                ),
                child: InkWell(
                  onTap: () {
                    visibleContacts[index]['add'] = !visibleContacts[index]['add'];
                    setState(() {});
                  },
                  child: SizedBox(
                    height: getHeight(context, 34),
                    width: getWidth(context, 34),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: !context.read<ThemeBloc>().state.isDark
                              ? const Color.fromRGBO(221, 232, 245, 1)
                              : const Color.fromRGBO(69, 78, 84, 1),
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.close,
                        color: !context.read<ThemeBloc>().state.isDark
                            ? const Color.fromRGBO(166, 173, 181, 1)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(
              width: getWidth(context, 4),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 12),
              ),
              child: buttonCheckContact(context, index: index),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: getHeight(context, 4),
          ),
        ),
      ],
    );
  }

  Widget buttonCheckContact(
    BuildContext context, {
    required int index,
  }) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if (visibleContacts[index]['add'] == false) {
          visibleContacts[index]['add'] = true;
        }
        setState(() {});
      },
      child: SizedBox(
        height: getHeight(context, 34),
        width: getWidth(context, 34),
        child: visibleContacts[index]['add']
            ? DecoratedBox(
                decoration: BoxDecoration(
                    gradient:
                        !context.read<ThemeBloc>().state.isDark ? null : AppTheme.mainGreenGradient,
                    color: !context.read<ThemeBloc>().state.isDark
                        ? const Color.fromRGBO(221, 232, 245, 1)
                        : null,
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.check,
                  color: !context.read<ThemeBloc>().state.isDark
                      ? const Color.fromRGBO(166, 173, 181, 1)
                      : Colors.white,
                ),
              )
            : DecoratedBox(
                decoration: BoxDecoration(
                  color: !context.read<ThemeBloc>().state.isDark
                      ? const Color.fromRGBO(221, 232, 245, 1)
                      : const Color.fromRGBO(69, 78, 84, 1),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    child: SvgPicture.asset(
                      'assets/svg/add_plus.svg',
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: getHeight(context, 64),
          width: getWidth(context, 375),
          child: ColoredBox(
            color: context.read<ThemeBloc>().state.isDark
                ? const Color.fromRGBO(235, 242, 249, 1)
                : const Color.fromRGBO(0, 0, 0, 0.25),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getWidth(context, 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BottomNavButtonNotActive(
                    picture: 'assets/svg/home.svg',
                  ),
                  BottomNavButton(
                    picture: 'assets/svg/book.svg',
                    isPressed: buttonNavIsPressed[1],
                    onTap: () {
                      buttonNavIsPressed[1] = !buttonNavIsPressed[1];
                      setState(() {});
                    },
                  ),
                  // const BottomNavCenterButtonNotActive(),
                  SizedBox(
                    width: getWidth(context, 73),
                  ),
                  BottomNavButton(
                    picture: 'assets/svg/forward.svg',
                    isPressed: buttonNavIsPressed[3],
                    onTap: () {
                      buttonNavIsPressed[3] = !buttonNavIsPressed[3];
                      setState(() {});
                    },
                  ),
                  BottomNavButton(
                    picture: 'assets/svg/stars.svg',
                    isPressed: buttonNavIsPressed[4],
                    onTap: () {
                      buttonNavIsPressed[4] = !buttonNavIsPressed[4];
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const BottomNavCenterButtonNotActive(),
      ],
    );
  }

  Widget groupCelebration(BuildContext context) {
    return (buttonCelebrateIsPressed[0] == false && buttonCelebrateIsPressed[1] == false)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                buttonGroupIsPressed[i]
                    ? Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SizedBox(
                            width: getWidth(context, 17),
                            height: getHeight(context, 17),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: groupColor[i],
                              ),
                            ),
                          ),
                          Text(
                            strGroup[i],
                            //textAlign: TextAlign.center,
                            style: TextLocalStyles.roboto400.copyWith(
                              color: Colors.white,
                              fontSize: getHeight(context, 14),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
            ],
          )
        : SizedBox(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(98, 198, 170, 1),
                    Color.fromRGBO(68, 168, 140, 1),
                  ],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context, 3),
                ),
                child: Text(
                  buttonCelebrateIsPressed[0] ? 'Торжество' : 'Группа',
                  textAlign: TextAlign.center,
                  style: TextLocalStyles.roboto400.copyWith(
                    color: Colors.white,
                    fontSize: getHeight(context, 15),
                  ),
                ),
              ),
            ),
          );
  }
}
