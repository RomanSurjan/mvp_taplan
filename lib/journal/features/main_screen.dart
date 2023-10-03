import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvp_taplan/journal/models_journal/navigation_bar.dart';

import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  var flagForTip = false;
  DateTime dateOfBorn = DateTime(2024, 5, 17, 0);

  var isFirst = false;
  bool isTaped = false;
  bool isTapedHome = false;
  late Timer update;
  DateTime range = DateTime(2023);

  @override
  void initState() {
    super.initState();

    update = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        DateTime nowDate = DateTime.now();
        range = DateTime(
          dateOfBorn.year - nowDate.year,
          dateOfBorn.month - nowDate.month,
          dateOfBorn.day - nowDate.day,
          dateOfBorn.hour - nowDate.hour,
          dateOfBorn.minute - nowDate.minute,
          dateOfBorn.second - nowDate.second,
        );

        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    update.cancel();

    super.dispose();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bgImage.png'),
              fit: BoxFit.cover,
              alignment: Alignment(0.5, -0.66),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: getWidth(context, 375),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: getHeight(context, 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/images/sk_logo_main.png',
                  ),
                ),
              ),
              Positioned(
                top: getHeight(context, 154),
                right: getWidth(context, 7),
                child: myWishes(
                  context,
                  rangeToBirthday: range,
                  rangeToStream: range,
                ),
              ),
              Positioned(
                top: getHeight(context, 138),
                left: getWidth(context, 5),
                child: wishList(context),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: CustomNavigationBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bouquetOfTheWeek(BuildContext context, DateTime range) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        'Букет\nнедели',
        style: TextLocalStyles.mono400.copyWith(
          fontSize: getHeight(context, 24),
          height: 20.93 / 24,
        ),
        textAlign: TextAlign.right,
      ),
      const SizedBox(height: 1),
      Text(
        'Групповой\nподарок к',
        style: TextLocalStyles.mono400.copyWith(
          fontSize: 14,
          height: 12.21 / 14,
        ),
        textAlign: TextAlign.right,
      ),
      Text(
        'Еженедельному\nстриму ',
        style: TextLocalStyles.mono400.copyWith(
          fontSize: 16,
          height: 13.95 / 16,
        ),
        textAlign: TextAlign.right,
      ),
      const SizedBox(height: 3),
      Row(
        children: [
          containerTimer(context, range.day, 'дни'),
          Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
          containerTimer(context, range.hour, 'час'),
          Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
          containerTimer(context, range.minute, 'мин'),
          Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
          containerTimer(context, range.second, 'сек'),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: getHeight(context, 4)),
      ),
      RotatedBox(
        quarterTurns: 2,
        child: InkWell(
          onTap: () {},
          child: backSpaceButton(context, false),
        ),
      ),
    ],
  );
}

Widget myDream(BuildContext context, DateTime range) {
  return Align(
    alignment: Alignment.topRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Моя мечта',
          style: TextLocalStyles.mono400.copyWith(
            fontSize: getHeight(context, 24),
            height: 20.93 / 24,
          ),
          textAlign: TextAlign.right,
        ),
        Text(
          'Подарок ко \n Дню рождения?',
          style: TextLocalStyles.mono400.copyWith(
            fontSize: getHeight(context, 16),
            height: 13.95 / 14,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            containerTimer(context, range.month, 'мес'),
            Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
            containerTimer(context, range.day ~/ 7, 'нед'),
            Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
            containerTimer(context, range.day % 7, 'дни'),
            Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
            containerTimer(context, range.hour, 'час'),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 0.0049 * MediaQuery.of(context).size.height)),
        RotatedBox(
          quarterTurns: 2,
          child: InkWell(
            onTap: () {},
            child: backSpaceButton(context, false),
          ),
        )
      ],
    ),
  );
}

Widget containerTimer(BuildContext context, int date, String label) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(114, 114, 117, 1),
          Color.fromRGBO(157, 167, 176, 0.6),
        ],
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(context, 6),
        vertical: getHeight(context, 3),
      ),
      child: Column(
        children: [
          Text(
            date < 10 ? '0$date' : '$date',
            style: TextLocalStyles.roboto500.copyWith(
              fontSize: 18,
              color: Colors.white,
              height: 15.7 / 18,
            ),
          ),
          Text(
            label,
            style: TextLocalStyles.roboto400.copyWith(
              color: Colors.white,
              fontSize: 10,
              height: 8.72 / 10,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget backSpaceButton(BuildContext context, bool isLeft) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: getWidth(context, 10)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2),
      gradient: AppTheme.mainGreenGradient,
      //color: Colors.transparent,
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(39, 54, 68, 0.35),
          blurRadius: 6,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Image.asset('assets/images/image 231.png'),
  );
}

Widget wishList(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RotatedBox(
        quarterTurns: 3,
        child: Text(
          'Список моих  желанных\nподарков  (wishlist)',
          style: TextLocalStyles.mono400.copyWith(
            height: 20 / 20,
            fontSize: 20,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: getHeight(context, 4),
        ),
      ),
      InkWell(
        onTap: () {},
        child: backSpaceButton(context, true),
      ),
    ],
  );
}

Widget myWishes(
  BuildContext context, {
  required DateTime rangeToStream,
  required DateTime rangeToBirthday,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Align(
        alignment: Alignment.topRight,
        child: Text(
          'Узнай\nбольше\nо моих\nжеланиях',
          style: TextLocalStyles.mono400
              .copyWith(fontSize: getHeight(context, 31), height: 1, fontWeight: FontWeight.w200),
          textAlign: TextAlign.right,
        ),
      ),
      SizedBox(height: getHeight(context, 64)),
      Padding(
        padding: EdgeInsets.only(
          top: getHeight(context, 16),
        ),
      ),
      myDream(
        context,
        rangeToBirthday,
      ),
      Padding(padding: EdgeInsets.only(top: getHeight(context, 26))),
      bouquetOfTheWeek(context, rangeToStream)
    ],
  );
}