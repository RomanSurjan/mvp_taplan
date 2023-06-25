import 'package:flutter/material.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';



part 'money_collected_scale.dart';


class PresentScreen extends StatefulWidget {

  // ToDo Данные, которые ожидаю от сервера.
  final String presentName = "Подарок мечты";
  final String pathToImage = 'images/present_1.png';
  final int collectedAmount = 22000;
  final int totalAmount = 42000; // ToDo нужно проверять, что total больше collected.
  final int weeks = 08;
  final int days = 01;
  final int hours = 08;
  final int minutes = 13;
  final int seconds = 30; // ToDo часы, минуты и секунды наверное пирдётся рассчитывать таймером.
  final int firstAmount = 500;
  final int secondAmount = 1000;
  final int thirdAmount = 5000;

  // Данные, которые надо передавать в конструктор.
  final BuyingOption buyingOption;

  const PresentScreen({
    required this.buyingOption,
    Key? key
  }) : super(key: key);

  @override
  _PresentScreenState createState() => _PresentScreenState();
}

class _PresentScreenState extends State<PresentScreen> {

  late BuyingOption buyingOption;
  int amountIndex = 1;

  _PresentScreenState();

  @override
  void initState() {
    buyingOption = widget.buyingOption;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: CustomAppBar(
            callBack: (){},
            name: widget.presentName
        ),
        body: Column(
            children: <Widget>[
              // Отступ для поддержки разных соотношений сторон экрана.
              const Expanded(
                  flex: 1,
                  child: SizedBox(width: 1)
              ),
              // Изображение подарка.
              Image.asset(
                widget.pathToImage,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
              ),
              // Отступ для поддержки разных соотношений сторон экрана.
              const Expanded(
                  flex: 1,
                  child: SizedBox(width: 1)
              ),
              // Шкала собранных средств.
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MoneyCollectedScaleWidget(
                    collected: widget.collectedAmount,
                    total: widget.totalAmount,
                  )
              ),
              // Отступ для поддержки разных соотношений сторон экрана.
              const Expanded(
                  flex: 1,
                  child: SizedBox(width: 1)
              ),
              // Таймер обратного отсчёта.
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      Row(
                          children: const <Widget>[
                            Text(
                              "До мероприятия осталось:",
                              style: presentScreenTextStyle,
                            )
                          ]
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppTheme.presentScreenCounterColor
                        ),
                        child: Row(
                            children: <Widget>[
                              const Expanded(
                                  flex: 1,
                                  child: SizedBox(height: 1)
                              ),
                              CounterSegmentWidget(widget.weeks, "недель"),
                              const Expanded(
                                  flex: 3,
                                  child: SizedBox(height: 1)
                              ),
                              CounterSegmentWidget(widget.days, "дней"),
                              const Expanded(
                                  flex: 3,
                                  child: SizedBox(height: 1)
                              ),
                              CounterSegmentWidget(widget.hours, "часов"),
                              const Expanded(
                                  flex: 3,
                                  child: SizedBox(height: 1)
                              ),
                              CounterSegmentWidget(widget.minutes, "минут"),
                              const Expanded(
                                  flex: 3,
                                  child: SizedBox(height: 1)
                              ),
                              CounterSegmentWidget(widget.seconds, "секунд"),
                              const Expanded(
                                  flex: 1,
                                  child: SizedBox(height: 1)
                              ),
                            ]
                        ),
                      )
                    ],
                  )
              ),
              // Отступ для поддержки разных соотношений сторон экрана.
              const Expanded(
                  flex: 1,
                  child: SizedBox(width: 1)
              ),
              // Поле "Внести сумму".
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppTheme.mainGreenColor,
                          width: 1,
                        )
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                              padding: EdgeInsets.only(top: 16, left: 16),
                              child: Text(
                                "Внести сумму:",
                                style: presentScreenTextStyle,
                              )
                          ),
                          ListTile(
                              horizontalTitleGap: 0,
                              leading: CustomRadio<BuyingOption>(
                                  value: BuyingOption.buyTogether,
                                  groupValue: buyingOption,
                                  onChanged: (value) {
                                    setState(() {
                                      buyingOption = value!;
                                    });
                                  }
                              ),
                              title: Row(
                                  children: <Widget>[
                                    CustomRadioButton(
                                      caption: "${widget.firstAmount} ₽",
                                      index: 1,
                                      groupIndex: amountIndex,
                                      isActive: (buyingOption == BuyingOption.buyTogether),
                                      onChanged: (index) {
                                        setState(() {
                                          amountIndex = index;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    CustomRadioButton(
                                      caption: "${widget.secondAmount} ₽",
                                      index: 2,
                                      groupIndex: amountIndex,
                                      isActive: (buyingOption == BuyingOption.buyTogether),
                                      onChanged: (index) {
                                        setState(() {
                                          amountIndex = index;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    CustomRadioButton(
                                      caption: "${widget.thirdAmount} ₽",
                                      index: 3,
                                      groupIndex: amountIndex,
                                      isActive: (buyingOption == BuyingOption.buyTogether),
                                      onChanged: (index) {
                                        setState(() {
                                          amountIndex = index;
                                        });
                                      },
                                    )
                                  ]
                              )
                          ),
                          ListTile(
                              horizontalTitleGap: 0,
                              leading: CustomRadio<BuyingOption>(
                                  value: BuyingOption.buyAlone,
                                  groupValue: buyingOption,
                                  onChanged: (value) {
                                    setState(() {
                                      buyingOption = value!;
                                    });
                                  }
                              ),
                              title: Row(
                                  children: <Widget>[
                                    CustomRadioButton(
                                      caption: "${
                                          widget.totalAmount - widget.collectedAmount
                                      } ₽",
                                      index: 1,
                                      groupIndex: 1,
                                      isActive: (buyingOption == BuyingOption.buyAlone),
                                      onChanged: (index) {
                                        setState(() {
                                          amountIndex = index;
                                        });
                                      },
                                    ),
                                  ]
                              )
                          ),
                          const SizedBox(
                            height: 8,
                          )
                        ]
                    ),
                  )
              ),
              // Отступ для поддержки разных соотношений сторон экрана.
              const Expanded(
                  flex: 1,
                  child: SizedBox(width: 1)
              ),
              // Кнопки.
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: CustomGradientButton(
                              onTap: (){},
                              caption: "Написать пожелания",
                              secondCaption: "для Telegram-чата",
                              leftColor: AppTheme.purpleButtonLeftColor,
                              rightColor: AppTheme.purpleButtonRightColor,
                            )
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                            flex: 1,
                            child: CustomGradientButton(
                              onTap: (){},
                              caption: "Внести деньги",
                              leftColor: AppTheme.greenButtonLeftColor,
                              rightColor: AppTheme.greenButtonRightColor,
                            )
                        )
                      ]
                  )
              ),
              // Отступ для поддержки разных соотношений сторон экрана.
              const Expanded(
                  flex: 1,
                  child: SizedBox(width: 1)
              )
            ]
        )
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
    return Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 20),
              child: Text(
                count.toString().padLeft(2, '0'),
                style: presentScreenCounterUpTextStyle,
              )
          ),
          Padding(
              padding: const EdgeInsets.only(top: 43, bottom: 10),
              child: Text(
                name,
                style: presentScreenCounterBottomTextStyle,
              )
          )
        ]
    );
  }
}

enum BuyingOption{buyTogether, buyAlone}