import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvp_taplan/features/screen_15/screen_15.dart';
import 'package:mvp_taplan/features/screen_213/screen_213.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

part 'money_collected_scale.dart';

enum BuyingOption { buyTogether, buyAlone }

class PresentScreen extends StatefulWidget {
  final int collectedAmount = 22000;
  final int totalAmount = 42000;
  final int firstAmount = 100;
  final int secondAmount = 250;
  final int thirdAmount = 500;
  final int fourthAmount = 1000;

  final BuyingOption buyingOption;
  final String? imagePath;

  const PresentScreen({
    required this.buyingOption,
    super.key, this.imagePath,
  });

  @override
  PresentScreenState createState() => PresentScreenState();
}

class PresentScreenState extends State<PresentScreen> {
  DateTime dateOfBorn = DateTime(2024, 5, 17, 0);
  late BuyingOption buyingOption = widget.buyingOption;
  late Timer update;
  DateTime range = DateTime(2023);

  int additionalSum = 0;

  int amountIndex = 3;

  @override
  void initState() {
    super.initState();
    additionalSum = widget.thirdAmount;
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

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: "Покупка подарка",
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                widget.imagePath ?? 'assets/images/car.png',
                fit: BoxFit.cover,
                width: getWidth(context, 343),
                height: getHeight(context, 226),
                alignment: Alignment.topCenter,
                //width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 22),
                ),
              ),
              MoneyCollectedScaleWidget(
                collected: widget.collectedAmount,
                total: widget.totalAmount,
                additionalSum: additionalSum,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 5),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppTheme.mainGreenColor,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: getHeight(context, 16),
                        ),
                        child: Text(
                          "Внести сумму:",
                          style: TextLocalStyles.roboto600.copyWith(
                            color: const Color.fromRGBO(200, 210, 219, 1),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: getHeight(context, 16)),
                      Row(
                        children: [
                          CustomRadio<BuyingOption>(
                            value: BuyingOption.buyAlone,
                            groupValue: buyingOption,
                            onChanged: (value) {
                              buyingOption = value!;
                              additionalSum = 0;
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 24,
                              child: TextField(
                                textAlign: TextAlign.center,
                                enabled: buyingOption == BuyingOption.buyAlone,
                                textAlignVertical: TextAlignVertical.bottom,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14,
                                ),
                                onChanged: (value) {
                                  additionalSum = int.tryParse(value) ?? 0;
                                  setState(() {});
                                },
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color.fromRGBO(52, 54, 62, 1),
                                  focusColor: const Color.fromRGBO(52, 54, 62, 1),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(66, 68, 77, 1), width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(66, 68, 77, 1), width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(66, 68, 77, 1), width: 1.5),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(66, 68, 77, 1), width: 1.5),
                                  ),
                                  hintText: 'Внесите сумму вручную (₽)',
                                  hintStyle: const TextStyle(
                                    color: Color.fromRGBO(105, 113, 119, 1),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getHeight(context, 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomRadio<BuyingOption>(
                            value: BuyingOption.buyTogether,
                            groupValue: buyingOption,
                            onChanged: (value) {
                              buyingOption = value!;
                              setState(() {});
                            },
                          ),
                          CustomRadioButton(
                            caption: "${widget.firstAmount} ₽",
                            index: 1,
                            groupIndex: amountIndex,
                            isActive: buyingOption == BuyingOption.buyTogether,
                            onChanged: (index) {
                              setState(() {
                                amountIndex = index;
                                additionalSum = widget.firstAmount;
                              });
                            },
                          ),
                          CustomRadioButton(
                            caption: "${widget.secondAmount} ₽",
                            index: 2,
                            groupIndex: amountIndex,
                            isActive: buyingOption == BuyingOption.buyTogether,
                            onChanged: (index) {
                              setState(
                                    () {
                                  amountIndex = index;
                                  additionalSum = widget.secondAmount;
                                },
                              );
                            },
                          ),
                          CustomRadioButton(
                            caption: "${widget.thirdAmount} ₽",
                            index: 3,
                            groupIndex: amountIndex,
                            isActive: buyingOption == BuyingOption.buyTogether,
                            onChanged: (index) {
                              setState(() {
                                amountIndex = index;
                                additionalSum = widget.thirdAmount;
                              });
                            },
                          ),
                          CustomRadioButton(
                            caption: "${widget.fourthAmount} ₽",
                            index: 4,
                            groupIndex: amountIndex,
                            isActive: buyingOption == BuyingOption.buyTogether,
                            onChanged: (index) {
                              setState(() {
                                amountIndex = index;
                                additionalSum = widget.fourthAmount;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: getHeight(context, 20)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 46),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "До мероприятия осталось:",
                    style: TextLocalStyles.roboto600.copyWith(
                      fontSize: 16,
                      color: const Color.fromRGBO(200, 210, 219, 1),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 8),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppTheme.presentScreenCounterColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context, 7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CounterSegmentWidget(range.day ~/ 7, "недель"),
                          CounterSegmentWidget(range.day % 7, "дней"),
                          CounterSegmentWidget(range.hour, "часов"),
                          CounterSegmentWidget(range.minute, "минут"),
                          CounterSegmentWidget(range.second, "секунд"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 27),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MvpGradientButton(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => const Screen213()));
                    },
                    label: "Написать\nпожелания",
                    gradient: AppTheme.purpleButtonGradientColor,
                    width: getWidth(context, 160),
                  ),
                  MvpGradientButton(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> const Screen15()));
                    },
                    label: "Внести деньги\nна подарок",
                    gradient: AppTheme.greenButtonGradientColor,
                    width: getWidth(context, 160),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Сегмент счётчика.

class CounterSegmentWidget extends StatelessWidget {
  final int count;
  final String name;

  const CounterSegmentWidget(
    this.count,
    this.name, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: getHeight(context, 8)),
      child: Column(
        children: <Widget>[
          Text(
            count.toString().padLeft(2, '0'),
            style: TextLocalStyles.gputeks500.copyWith(
              fontSize: getHeight(context, 35),
              color: const Color.fromRGBO(193, 184, 237, 1),
              // height: 49.6 / 30,
            ),
          ),
          Text(
            name,
            style: TextLocalStyles.roboto400.copyWith(
              fontSize: getHeight(context, 14),
              color: const Color.fromRGBO(157, 167, 176, 1),
              height: 16.41 / 14,
            ),
          ),
        ],
      ),
    );
  }
}
