import 'package:flutter/material.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

import 'money_collected_scale.dart';



class PresentScreen extends StatefulWidget {

  // Данные, которые ожидаю от сервера.
  final String presentName = "Подарок мечты";
  final String pathToImage = 'images/present_1.png';
  final int collected = 22000;
  final int total = 42000; // ToDo нужно проверять, что total больше collected.
  final int weeks = 08;
  final int days = 01;
  final int hours = 08;
  final int minutes = 13;
  final int seconds = 30; // ToDo часы, минуты и секунды наверное пирдётся рассчитывать таймером.

  const PresentScreen({Key? key}) : super(key: key);

  @override
  PresentScreenState createState() => PresentScreenState();
}

class PresentScreenState extends State<PresentScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        name: widget.presentName
      ),
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(width: 1)
          ),
          Image.asset(
            widget.pathToImage,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(width: 1)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MoneyCollectedScaleWidget(
              collected: widget.collected,
              total: widget.total,
            )
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(width: 1)
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "До мероприятия осталось:",
                      style: presentScreenTextStyle,
                    )
                  ]
                ),
              ],
            )
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(width: 1)
          )
        ],
      ),
    );
  }
}

/// Сегмент счётчика.

class CounterSegmentWidget extends StatelessWidget {

  final int count;
  final String name;

  const CounterSegmentWidget(this.count, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: presentScreenCounterUpTextStyle,
        ),
        Text(
          name,
          style: presentScreenCounterBottomTextStyle,
        )
      ]
    );
  }
}