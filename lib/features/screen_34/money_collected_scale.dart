part of 'present_screen.dart';

/// Виджет шкалы собранных средств для Экрана "Подарок".

class MoneyCollectedScaleWidget extends StatelessWidget {
  final int collected;
  final int total;
  final int additionalSum;

  MoneyCollectedScaleWidget({
    required this.collected,
    required this.total,
    super.key,
    this.additionalSum = 0,
  });

  late final int leftToCollect = total - collected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Text(
            "Собрано $collected ₽",
            style: TextLocalStyles.roboto600.copyWith(
              fontSize: 16,
            ),
          ),
          const Expanded(flex: 1, child: SizedBox(height: 1)),
          Text(
            "Осталось $leftToCollect ₽",
            style: TextLocalStyles.roboto600.copyWith(
              fontSize: 16,
              color: AppTheme.mainPinkColor,
            ),
          )
        ]),
        Row(
          children: [
            Expanded(
              flex: collected,
              child: Container(
                height: 38,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(1.5), bottomLeft: Radius.circular(1.5)),
                    gradient: AppTheme.moneyCollectedScaleWidgetGradientColor1),
              ),
            ),
            Container(
              width: 1,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.5),
                color: AppTheme.mainGreenColor,
              ),
            ),
            if (additionalSum > 0) ...[
              Expanded(
                flex: additionalSum,
                child: Container(
                  height: 38,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(1.5),
                      bottomLeft: Radius.circular(1.5),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(127, 164, 234, 1),
                        Color.fromRGBO(127, 164, 234, 0.9),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.5),
                  color: AppTheme.mainGreenColor,
                ),
              ),
            ],
            Expanded(
              flex: leftToCollect - additionalSum,
              child: Container(
                height: 38,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(1.5), bottomRight: Radius.circular(1.5)),
                    gradient: AppTheme.moneyCollectedScaleWidgetGradientColor2),
              ),
            ),
          ],
        )
      ],
    );
  }
}
