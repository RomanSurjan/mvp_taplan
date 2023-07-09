import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/features/screen_214/screen_214.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen30 extends StatefulWidget {
  const Screen30({Key? key}) : super(key: key);

  @override
  Screen30State createState() => Screen30State();
}

class Screen30State extends State<Screen30> {
  var flagForTip = false;
  DateTime dateOfBorn = DateTime.utc(2024, 4, 13, 24);

  late Timer timer;
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

  bool timerWork = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgImage.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(child:
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    child: Image.asset('assets/images/logo.png'),
                  ),
                )
            ),
            Positioned(
              top: getHeight(context, 154),
              right: getWidth(context, 7),
              child: myWishes(context, range),
            ),
            Positioned(
              top: getHeight(context, 138),
              left: getWidth(context, 5),
              child: wishList(context),
            ),

          ],
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
          height: 0,
          fontSize: 24,
        ),
        textAlign: TextAlign.right,
      ),
      Text(
        'Групповой\nподарок к\nЕженедельному\n стриму ',
        style: TextLocalStyles.mono400.copyWith(
          fontSize: 14,
          height: 0,
        ),
        textAlign: TextAlign.right,
      ),
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
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => const Screen214()));
        },
        child: RotatedBox(
          quarterTurns: 2,
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
            fontSize: 24,
            height: 0,
          ),
          textAlign: TextAlign.right,
        ),
        Text(
          'Подарок ко \n Дню рождения?',
          style: TextLocalStyles.mono400.copyWith(
            fontSize: 16,
            height: 0,
          ),
          textAlign: TextAlign.right,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            containerTimer(context, range.month, 'мес'),
            Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
            containerTimer(context, range.weekday, 'нед'),
            Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
            containerTimer(context, range.day, 'дни'),
            Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
            containerTimer(context, range.hour, 'час'),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 0.0049 * MediaQuery.of(context).size.height)),
        RotatedBox(
          quarterTurns: 2,
          child: InkWell(
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
          Color.fromRGBO(113, 115, 117, 1),
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
              fontSize: 10,
              color: Colors.white,
              height: 0,
            ),
          ),
          Text(
            label,
            style: TextLocalStyles.roboto400.copyWith(
              color: Colors.white,
              fontSize: 6,
              height: 0,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget backSpaceButton(BuildContext context, bool isLeft) {
  return Container(
    alignment: Alignment.center,
    width: 0.12 * MediaQuery.of(context).size.width,
    height: 0.03 * MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2),
      gradient: AppTheme.mainGreenGradient,
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(39, 54, 68, 0.35),
          blurRadius: 6,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Icon(
      Icons.keyboard_backspace,
      size: 0.032 * MediaQuery.of(context).size.height,
      color: Colors.white,
    ),
  );
}

Widget wishList(BuildContext context) {
  return Column(
    children: [
      RotatedBox(
        quarterTurns: 3,
        child: Text(
          'Список моих  желанных\nподарков  (wishlist)',
          style: TextLocalStyles.mono400.copyWith(height: 0),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: getHeight(context, 4),
        ),
      ),
      backSpaceButton(context, true),
    ],
  );
}

Widget myWishes(BuildContext context, DateTime range) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Align(
        alignment: Alignment.topRight,
        child: Text(
          'Узнай\nбольше\nо моих\nжеланиях',
          style: TextLocalStyles.mono400.copyWith(
            height: 0,
            fontSize: 31,
          ),
          textAlign: TextAlign.right,
        ),
      ),
      SvgPicture.asset('assets/svg/swipe.svg'),
      Padding(
        padding: EdgeInsets.only(
          top: getHeight(context, 16),
        ),
      ),
      myDream(
        context,
        range,
      ),
      Padding(padding: EdgeInsets.only(top: getHeight(context, 26))),
      bouquetOfTheWeek(context, range)
    ],
  );
}
