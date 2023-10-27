import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_event.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_addContact/screen_addContact.dart';
import 'package:mvp_taplan/features/screen_sendWishlist/screen_sendWishlist.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

import '../../models/buttons.dart';

class Screen26 extends StatefulWidget {
  const Screen26({super.key});

  @override
  State<Screen26> createState() => Screen26State();
}

class Screen26State extends State<Screen26> {
  Map userData = {};

  void getUserData() async {
    String url = 'https://qviz.fun/api/v1/get/user/data/';
    final dio = Dio();
    final response = await dio.post(
      url,
      options: Options(
        headers: {
          'Authorization':
              "Token ${context.read<AuthorizationBloc>().state.authToken}",
        },
      ),
    );
    userData = response.data;
  }
  int group = 0;
  Map contacts = {};
  List<int> count = [0, 0, 0, 0, 0];

  void updateContacts() {
    buffContacts.clear();
    visibleContacts.clear();
    count = [0, 0, 0, 0, 0];
    for (int i = 0; i < 5; i++) {
      for (int k = 0;
      k < int.parse(contacts['people'].length.toString());
      k++) {
        if (contacts['people'][k]['cat'] == (i + 1)) {
          count[i]++;
        }
      }
    }

    for (int k = 0; k < int.parse(contacts['people'].length.toString()); k++) {
      if (buttonGroupIsPressed[group] == true) {
        if (contacts['people'][k]['cat'] == (group+1)) {
          buffContacts[contacts['people'][k]['id']] = contacts['people'][k];
        }
      } else {
        if (buffContacts.containsKey(contacts['people'][k]['id']) &&
            contacts['people'][k]['cat'] == (group+1)) {
          buffContacts.remove(contacts['people'][k]['id']);
        }
      }
    }

    visibleContacts.clear();

    // visibleContacts[0] = userData;

    int length = 0;
    buffContacts.forEach((key, value) {
      visibleContacts[length] = buffContacts[key];
      visibleContacts[length]['add'] = true;
      length++;
    });
    log(visibleContacts.length.toString());
    setState(() {});
  }

  void getContacts() async {
    String url = 'https://qviz.fun/api/v1/peoplelist/';
    final dio = Dio();
    final response = await dio.post(url,
        options: Options(headers: {
          'Authorization':
              "Token ${context.read<AuthorizationBloc>().state.authToken}",
        }));
    log(response.data.toString());
    setState(() {
      contacts = response.data;
    });
    updateContacts();
  }

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

  String data = "?";

  Map buffContacts = {};
  Map visibleContacts = {};

  int countContacts = 0;

  bool isOk = false;
  List<String> strGroup = ['С', 'Д', 'Б', 'К', 'П'];
  List<bool> buttonNavIsPressed = [false, false, false, false, false];
  List<bool> buttonGroupIsPressed = [true, false, false, false, false];
  List<bool> buttonCelebrateIsPressed = [false, false];

  @override
  void initState() {
    super.initState();

    getContacts();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: state.isDark
              ? AppTheme.backgroundColor
              : const Color.fromRGBO(240, 247, 254, 1),
          appBar: CustomAppBarRegistration(
            name: 'Мой список контактов',
            onTheme: () {
              context
                  .read<ThemeBloc>()
                  .add(SwitchThemeEvent(isDark: !state.isDark));
              setState(() {});
            },
          ),
          body: SafeArea(
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
                    top: getHeight(context, 9),
                  ),
                ),
                groupButtons(context),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 24),
                  ),
                ),
                listOfChannels(context),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 18),
                  ),
                ),
                addContact(context),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 18),
                  ),
                ),
                bottomNavBar(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget createEvent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(context, 16),
      ),
      child: Row(
        children: [
          SizedBox(
              height: getHeight(context, 54),
              width: getWidth(context, 54),
              child: CircleAvatar(
                backgroundImage:
                    const AssetImage('assets/images/upload_image.png'),
                backgroundColor: context.read<ThemeBloc>().state.isDark
                    ? AppTheme.backgroundColor
                    : const Color.fromRGBO(240, 247, 254, 1),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData['username'] ?? '',
                  style: TextLocalStyles.roboto500.copyWith(
                    color: context.read<ThemeBloc>().state.isDark
                        ? Colors.white
                        : const Color.fromRGBO(22, 26, 29, 1),
                    fontSize: 16,
                    height: 0,
                  ),
                ),
                Text(
                  userData['region'] ?? '',
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
        ],
      ),
    );
  }

  Widget birthDay(BuildContext context) {
    return SizedBox(
      child: ColoredBox(
        color: context.read<ThemeBloc>().state.isDark
            ? const Color.fromRGBO(0, 0, 0, 0.5)
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
                      SvgPicture.asset('assets/svg/birthday.svg'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: getWidth(context, 6),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'День рождения дочери и её мамы',
                    style: TextLocalStyles.roboto600.copyWith(
                      color: context.read<ThemeBloc>().state.isDark
                          ? Colors.white
                          : const Color.fromRGBO(65, 78, 88, 1),
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
                            color: context.read<ThemeBloc>().state.isDark
                                ? const Color.fromRGBO(250, 255, 255, 1)
                                : const Color.fromRGBO(52, 54, 62, 1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: context.read<ThemeBloc>().state.isDark
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
                                Text(
                                  data,
                                  style: TextLocalStyles.roboto400.copyWith(
                                    color: context
                                            .read<ThemeBloc>()
                                            .state
                                            .isDark
                                        ? const Color.fromRGBO(157, 167, 176, 1)
                                        : const Color.fromRGBO(
                                            244, 199, 217, 1),
                                    fontSize: 14,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getWidth(context, 5),
                                  ),
                                ),
                                SizedBox(
                                  height: getHeight(context, 20),
                                  width: getHeight(context, 20),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          context.read<ThemeBloc>().state.isDark
                                              ? const Color.fromRGBO(
                                                  237, 244, 251, 1)
                                              : const Color.fromRGBO(
                                                  87, 99, 107, 1),
                                    ),
                                    child: const InkWell(
                                      child: Icon(
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
                            color: context.read<ThemeBloc>().state.isDark
                                ? const Color.fromRGBO(237, 244, 251, 1)
                                : const Color.fromRGBO(87, 99, 107, 1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: context.read<ThemeBloc>().state.isDark
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
                                  child: groupCelebration(context),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getWidth(context, 5),
                                  ),
                                ),
                                SizedBox(
                                  height: getHeight(context, 20),
                                  width: getHeight(context, 20),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          context.read<ThemeBloc>().state.isDark
                                              ? const Color.fromRGBO(
                                                  237, 244, 251, 1)
                                              : const Color.fromRGBO(
                                                  87, 99, 107, 1),
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
                      Padding(
                        padding: EdgeInsets.only(
                          left: getWidth(context, 4),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 34),
                        width: getHeight(context, 34),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.read<ThemeBloc>().state.isDark
                                ? const Color.fromRGBO(221, 232, 245, 1)
                                : const Color.fromRGBO(87, 99, 107, 1),
                          ),
                          child: Icon(
                            isOk
                                ? Icons.check_rounded
                                : Icons.question_mark_rounded,
                            color: const Color.fromRGBO(157, 167, 176, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
                  count: count[i],
                  colorMain: const Color.fromRGBO(110, 210, 182, 1),
                  picture: buttonGroupPicture[i],
                  colorCount: const Color.fromRGBO(198, 237, 226, 1),
                  text: buttonGroupText[i],
                  isPressed: buttonGroupIsPressed[i],
                  onTap: () {
                    group = i;
                    for (int j = 0; j < 5; j++) {
                      buttonGroupIsPressed[j] = false;
                    }
                    buttonGroupIsPressed[i] = true;
                    updateContacts();
                    setState(() {});
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  bool dataIsOk() {
    return data != "?" &&
        ((buttonGroupIsPressed[0] != false ||
                buttonGroupIsPressed[1] != false ||
                buttonGroupIsPressed[2] != false ||
                buttonGroupIsPressed[3] != false ||
                buttonGroupIsPressed[4] != false) ||
            (buttonCelebrateIsPressed[0] != false ||
                buttonCelebrateIsPressed[1] != false));
  }

  Widget listOfChannels(BuildContext context) {
    return Expanded(
      child: RawScrollbar(
        thumbVisibility: true,
        radius: Radius.circular(getWidth(context, 8)),
        thickness: getWidth(context, 8),
        trackVisibility: true,
        trackColor: Colors.transparent,
        thumbColor: const Color.fromRGBO(137, 137, 139, 1),
        trackRadius: Radius.circular(getWidth(context, 2)),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ColoredBox(
              color: context.read<ThemeBloc>().state.isDark
                  ? (index % 2 == 0)
                      ? const Color.fromRGBO(0, 0, 0, 1)
                      : const Color.fromRGBO(57, 59, 66, 1)
                  : (index % 2 == 0)
                      ? const Color.fromRGBO(250, 255, 255, 1)
                      : const Color.fromRGBO(100, 188, 238, 0.2),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context, 16),
                ),
                child: channel(context, index),
              ),
            );
          },
          itemCount: visibleContacts.length,
        ),
      ),
    );
  }

  Widget channel(BuildContext context, int index) {
    //bool isContact = (visibleContacts[index]['phoneNumber'] == context.read<AuthorizationBloc>().state.phone);
    return Column(
      children: [
        SizedBox(
          height: getHeight(context, 66),
          child: Row(
            children: [
              SizedBox(
                height: getHeight(context, 54),
                width: getHeight(context, 54),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://qviz.fun/${visibleContacts[index]['person_photo']}'),
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
                  SizedBox(
                    height: getHeight(context, 4),
                  ),
                  Text(
                    visibleContacts[index]['name'],
                    style: TextLocalStyles.roboto500.copyWith(
                      color: context.read<ThemeBloc>().state.isDark
                          ? Colors.white
                          : const Color.fromRGBO(65, 78, 88, 1),
                      fontSize: 16,
                      height: 0,
                    ),
                  ),
                  Text(
                    visibleContacts[index]['region'],
                    style: TextLocalStyles.roboto400.copyWith(
                      color: context.read<ThemeBloc>().state.isDark
                          ? const Color.fromRGBO(188, 192, 200, 1)
                          : const Color.fromRGBO(98, 118, 132, 1),
                      fontSize: 14,
                      height: 0,
                    ),
                  ),
                  Text(
                    visibleContacts[index]['birthday'].substring(
                          8,
                        ) +
                        '.' +
                        visibleContacts[index]['birthday'].substring(5, 7) +
                        '.' +
                        visibleContacts[index]['birthday'].substring(0, 4),
                    style: TextLocalStyles.roboto400.copyWith(
                      color: const Color.fromRGBO(127, 164, 234, 1),
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              buttonContact(context, index),
            ],
          ),
        ),
      ],
    );
  }

  Widget addContact(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: () {
          int groupId = 0;
          for (int i = 0; i < 5; i++) {
            if (buttonGroupIsPressed[i] == true) {
              groupId = i;
              break;
            }
          }
          Future.delayed(const Duration(milliseconds: 400), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ScreenAddContact(
                  groupId: groupId,
                  contacts: contacts,
                ),
              ),
            ).then(
              (_) => {getContacts()},
            );
          });
        },
        child: Stack(
          children: [
            SizedBox(
              height: getHeight(context, 50),
              width: getWidth(context, 348),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(98, 198, 170, 0.25),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: getHeight(context, 36),
                      width: getHeight(context, 36),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: const Color.fromRGBO(98, 198, 170, 1)),
                          shape: BoxShape.circle,
                        ),
                        child: Align(
                          child: SvgPicture.asset(
                            'assets/svg/miniplus.svg',
                            colorFilter: const ColorFilter.mode(
                                Color.fromRGBO(82, 182, 154, 1),
                                BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Добавить контакт',
                      style: TextLocalStyles.roboto400.copyWith(
                        color: const Color.fromRGBO(82, 182, 154, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context, 50),
              width: getWidth(context, 348),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(13),
                color: const Color.fromRGBO(98, 198, 170, 1),
                dashPattern: const [13, 13],
                //padding: EdgeInsets.all(6),
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonContact(BuildContext context, int index) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        height: getHeight(context, 36),
        width: getWidth(context, 36),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(98, 198, 170, 0.25),
            border: Border.all(
              color: const Color.fromRGBO(98, 198, 170, 1),
              width: 1,
            ),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            'assets/svg/arrow_right_mini.svg',
            width: getWidth(context, 24),
            height: getHeight(context, 24),
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return SizedBox(
      height: getHeight(context, 83),
      width: getWidth(context, 375),
      child: ColoredBox(
        color: context.read<ThemeBloc>().state.isDark
            ? const Color.fromRGBO(0, 0, 0, 0.25)
            : const Color.fromRGBO(235, 242, 249, 1),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth(context, 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNavButton(
                picture: 'assets/svg/home.svg',
                isPressed: buttonNavIsPressed[0],
                onTap: () {
                  buttonNavIsPressed[0] = !buttonNavIsPressed[0];
                  setState(() {});
                },
              ),
              BottomNavButton(
                picture: 'assets/svg/book_heart.svg',
                isPressed: buttonNavIsPressed[1],
                onTap: () {
                  buttonNavIsPressed[1] = !buttonNavIsPressed[1];
                  setState(() {});
                },
              ),
              BottomNavCenterButton(
                  isPressed: buttonNavIsPressed[2],
                  onTap: () {
                    buttonNavIsPressed[2] = !buttonNavIsPressed[2];
                    setState(() {});
                  }),
              BottomNavButton(
                picture: 'assets/svg/sharenav.svg',
                isPressed: buttonNavIsPressed[3],
                onTap: () {
                  buttonNavIsPressed[3] = !buttonNavIsPressed[3];
                  if(buttonNavIsPressed[3]){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ScreenSendWishlist(
                        ),
                      ),
                    );
                  }
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
    );
  }

  Widget groupCelebration(BuildContext context) {
    return (buttonCelebrateIsPressed[0] == false &&
            buttonCelebrateIsPressed[1] == false)
        ? SizedBox(
            child: Row(
              children: [
                for (int i = 0; i < 5; i++)
                  buttonGroupIsPressed[i]
                      ? Stack(
                          children: [
                            Container(
                              width: 15,
                              height: 18,
                              decoration: BoxDecoration(
                                color: groupColor[i],
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 2),
                              ),
                              child: Text(
                                strGroup[i],
                                style: TextLocalStyles.roboto400.copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
              ],
            ),
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
                  style: TextLocalStyles.roboto400.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
  }
}
