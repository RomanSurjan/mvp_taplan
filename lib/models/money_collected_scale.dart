import 'package:flutter/material.dart';

import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

/// Виджет шкалы собранных средств для Экрана "Подарок".

class MoneyCollectedScaleWidget extends StatelessWidget {

  final int collected;
  final int total;
  late final int leftToCollect;

  MoneyCollectedScaleWidget({
    required this.collected,
    required this.total,
    Key? key
  }) : super(key: key) {
    leftToCollect = total - collected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Подписи.
        Row(
          children: <Widget>[
            Text(
              "Собрано $collected ₽",
              style:  moneyCollectedScaleWidgetLeftTextStyle,
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(height: 1)
            ),
            Text(
              "Осталось $leftToCollect ₽",
              style:  moneyCollectedScaleWidgetRightTextStyle,
            )
          ]
        ),
        // Шкала.
        Row(
          children: <Widget>[
            // Левая часть шкалы.
            Expanded(
              flex: collected,
              child: Container(
                height: 38,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(1.5),
                    bottomLeft: Radius.circular(1.5)
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppTheme.moneyCollectedScaleWidgetColor1,
                      AppTheme.moneyCollectedScaleWidgetColor2
                    ]
                  )
                )
              )
            ),
            // Разделитель.
            Container(
              width: 3,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.5),
                color: AppTheme.mainGreenColor,
              )
            ),
            // Правая часть шкалы.
            Expanded(
              flex: leftToCollect,
              child: Container(
                height: 38,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(1.5),
                    bottomRight: Radius.circular(1.5)
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppTheme.moneyCollectedScaleWidgetColor3,
                      AppTheme.moneyCollectedScaleWidgetColor4
                    ]
                  )
                ),
              )
            )
          ],
        )
      ],
    );
  }
}