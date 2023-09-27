import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/journal/features/screen_38/screen_38.dart';
import 'package:mvp_taplan/models/models.dart';

class CustomNavigationBar extends StatelessWidget {
  static const svgForBar = [
    'assets/svg_journal/home.svg',
    'assets/svg_journal/book_heart.svg',
    'assets/svg_journal/telegram.svg',
    'assets/svg_journal/share.svg',
    'assets/svg_journal/stars.svg',
  ];

  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getWidth(context, 18),
        right: getWidth(context, 18),
        bottom: getHeight(context, 8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < svgForBar.length; i++)
            if (i != 2)
              InkWell(
                onTap: (){
                  if(i == 4){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Screen38()));
                  }
                },
                child: rectangleMainBarItem(
                  context,
                  svg: svgForBar[i],
                ),
              )
            else
              circleMainBarItem(context, svg: svgForBar[i])
        ],
      ),
    );
  }
}

Widget rectangleMainBarItem(BuildContext context, {required String svg}) {
  return SizedBox(
    height: getHeight(context, 56),
    width: getHeight(context, 56),
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 1),
            Color.fromRGBO(224, 236, 250, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromRGBO(209, 224, 239, 1),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          svg,
        ),
      ),
    ),
  );
}

Widget circleMainBarItem(BuildContext context, {required String svg}) {
  return SizedBox(
    height: getHeight(context, 69),
    width: getHeight(context, 69),
    child: DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(105, 205, 177, 1),
          width: getWidth(context, 2),
        ),
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 1),
            Color.fromRGBO(224, 236, 250, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: Color.fromRGBO(144, 170, 201, 1),
            inset: true,
          ),
          BoxShadow(
            offset: Offset(-4, -4),
            blurRadius: 10,
            color: Color.fromRGBO(255, 255, 255, 0.5),
            inset: true,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          svg,
        ),
      ),
    ),
  );
}
