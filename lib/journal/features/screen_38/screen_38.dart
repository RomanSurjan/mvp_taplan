import 'package:flutter/material.dart';
import 'package:mvp_taplan/journal/models_journal/bended_line.dart';
import 'package:mvp_taplan/models/models.dart';

class Screen38 extends StatefulWidget {
  const Screen38({Key? key}) : super(key: key);

  @override
  State<Screen38> createState() => _Screen38State();
}

class _Screen38State extends State<Screen38> {
  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Содержание номера',
      child: Stack(
        children: [

          Padding(
            padding: EdgeInsets.only(
              top: getHeight(context, 18),
              right: getWidth(context, 16),
              left: getWidth(context, 16),
            ),
            child: Column(
              children: [
                ContentBox(),
              ],
            ),
          ),
          SizedBox(
            height: getHeight(context, 812),
            width: getWidth(context, 375),
            child: CustomPaint(
              painter: BendedLinePainter(
                color: const Color.fromRGBO(98, 198, 170, 1),
                leftPadding: getWidth(context, 75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentBox extends StatelessWidget {
  const ContentBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context, 40),
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: const Color.fromRGBO(58, 60, 69, 1),
        ),
      ),
    );
  }
}

