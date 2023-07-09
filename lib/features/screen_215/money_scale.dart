part of 'screen_215.dart';

class MoneyScale extends StatelessWidget {
  final double firstGrade;
  final double secondGrade;
  final double thirdGrade;
  final double totalMoney;

  const MoneyScale({
    super.key,
    required this.firstGrade,
    required this.secondGrade,
    required this.thirdGrade,
    required this.totalMoney,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: getHeight(context, 46),
          width: getWidth(context, 113),
          child: Stack(
            children: [
              if (totalMoney > firstGrade) ...[
                SizedBox(
                  height: getHeight(context, 46),
                  width: getWidth(context, 113),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppTheme.mainGreenGradient,
                    ),
                  ),
                ),
              ] else ...[
                Row(
                  children: [
                    SizedBox(
                      height: getHeight(context, 46),
                      width: getWidth(context, totalMoney / firstGrade * 113),
                      child: const ColoredBox(
                        color: AppTheme.mainGreenColor,
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 46),
                      width: getWidth(context, (1 - totalMoney / firstGrade) * 113),
                      child: const ColoredBox(
                        color: AppTheme.mainPinkColor,
                      ),
                    ),
                  ],
                ),
              ],
              Padding(
                padding: EdgeInsets.only(right: getWidth(context, 3)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$firstGrade ₽\nСтандарт',
                    style: TextLocalStyles.roboto600.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getHeight(context, 46),
          width: getWidth(context, 113),
          child: Stack(
            children: [
              if (totalMoney < firstGrade) ...[
                SizedBox(
                  height: getHeight(context, 46),
                  width: getWidth(context, 113),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppTheme.mainPinkGradient,
                    ),
                  ),
                )
              ] else if (totalMoney < secondGrade)
                ...[
                  Row(
                    children: [
                      SizedBox(
                        height: getHeight(context, 46),
                        width: getWidth(context, totalMoney / secondGrade * 113),
                        child: const ColoredBox(
                          color: AppTheme.mainGreenColor,
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 46),
                        width: getWidth(context, (1 - totalMoney / secondGrade) * 113),
                        child: const ColoredBox(
                          color: AppTheme.mainPinkColor,
                        ),
                      ),
                    ],
                  )
                ] else ...[
                  SizedBox(
                    height: getHeight(context, 46),
                    width: getWidth(context, 113),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppTheme.mainGreenGradient,
                      ),
                    ),
                  ),
                ],
              Padding(
                padding: EdgeInsets.only(right: getWidth(context, 3)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$secondGrade ₽\nМасс-маркет',
                    style: TextLocalStyles.roboto600.copyWith(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getHeight(context, 46),
          width: getWidth(context, 113),
          child: Stack(
            children: [
              if (totalMoney < secondGrade) ...[
                SizedBox(
                  height: getHeight(context, 46),
                  width: getWidth(context, 113),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppTheme.mainPinkGradient,
                    ),
                  ),
                )
              ] else if (totalMoney < thirdGrade)
                ...[
                  Row(
                    children: [
                      SizedBox(
                        height: getHeight(context, 46),
                        width: getWidth(context, totalMoney / thirdGrade * 113),
                        child: const ColoredBox(
                          color: AppTheme.mainGreenColor,
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 46),
                        width: getWidth(context, (1 - totalMoney / thirdGrade) * 113),
                        child: const ColoredBox(
                          color: AppTheme.mainPinkColor,
                        ),
                      ),
                    ],
                  )
                ] else ...[
                  SizedBox(
                    height: getHeight(context, 46),
                    width: getWidth(context, 113),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppTheme.mainGreenGradient,
                      ),
                    ),
                  ),
                ],
              Padding(
                padding: EdgeInsets.only(right: getWidth(context, 3)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$thirdGrade ₽\nПремиум',
                    style: TextLocalStyles.roboto600.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
