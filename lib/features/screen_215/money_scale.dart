part of 'screen_215.dart';

class MoneyScale extends StatelessWidget {
  final int firstGrade;
  final int secondGrade;
  final int thirdGrade;
  final int totalMoney;
  final int additionalMoney;

  const MoneyScale({
    super.key,
    required this.firstGrade,
    required this.secondGrade,
    required this.thirdGrade,
    required this.totalMoney,
    required this.additionalMoney,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: getHeight(context, 48),
          width: getWidth(context, 114),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3),
                bottomLeft: Radius.circular(3),
              )
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                if (totalMoney == 0) ...[
                  if (additionalMoney == 0) ...[
                    SizedBox(
                      height: getHeight(context, 41),
                      width: getWidth(context, 114),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: AppTheme.mainPinkGradient,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3),
                              bottomLeft: Radius.circular(3),
                            )
                        ),
                      ),
                    ),
                  ] else ...[
                    if (additionalMoney > firstGrade) ...[
                      SizedBox(
                        height: getHeight(context, 41),
                        width: getWidth(context, 114),
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            //gradient: AppTheme.mainGreenGradient,
                            color: AppTheme.moneyScaleGreenColor,

                          ),
                        ),
                      ),
                    ] else ...[
                      Row(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              SizedBox(
                                height: getHeight(context, 41),
                                width: getWidth(
                                    context, additionalMoney / firstGrade * 114),
                                child: const ColoredBox(
                                  color: AppTheme.moneyScaleGreenColor,
                                ),
                              ),
                              Container(
                                height: getHeight(context, 46),
                                width: getWidth(context, 2),
                                decoration: BoxDecoration(
                                  gradient: AppTheme.moneyScaleStickColor,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),

                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: getHeight(context, 41),
                              child: const ColoredBox(
                                color: AppTheme.mainPinkColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ]
                ] else if (totalMoney > firstGrade) ...[
                  SizedBox(
                    height: getHeight(context, 41),
                    width: getWidth(context, 114),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppTheme.mainGreenGradient,
                      ),
                    ),
                  ),
                ] else ...[
                  if ((totalMoney + additionalMoney) < firstGrade) ...[
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [

                            SizedBox(
                              height: getHeight(context, 41),
                              width: getWidth(
                                  context, totalMoney / firstGrade * 114),
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppTheme.mainGreenColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    bottomLeft: Radius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: getHeight(context, 46),
                              width: getWidth(context, 2),
                              decoration: BoxDecoration(
                                gradient: AppTheme.moneyScaleStickColor,
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ],
                        ),
                        additionalMoney != 0
                            ? Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [

                            SizedBox(
                              height: getHeight(context, 41),
                              width: getWidth(context,
                                  additionalMoney / firstGrade * 114),
                              child: const ColoredBox(
                                color: AppTheme.moneyScaleGreenColor,
                              ),
                            ),

                            Container(
                              height: getHeight(context, 46),
                              width: getWidth(context, 2),
                              decoration: BoxDecoration(
                                gradient: AppTheme.moneyScaleStickColor,
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ],
                        )
                            : const SizedBox.shrink(),
                        Expanded(
                          child: SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                (1 -
                                    (totalMoney + additionalMoney) /
                                        firstGrade) *
                                    114),
                            child: const ColoredBox(
                              color: AppTheme.mainPinkColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] else if ((totalMoney + additionalMoney) == firstGrade) ...[
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [

                            SizedBox(
                              height: getHeight(context, 41),
                              width: getWidth(
                                  context, totalMoney / firstGrade * 114),
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppTheme.mainGreenColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    bottomLeft: Radius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: getHeight(context, 46),
                              width: getWidth(context, 2),
                              decoration: BoxDecoration(
                                gradient: AppTheme.moneyScaleStickColor,
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [

                            SizedBox(
                              height: getHeight(context, 41),
                              width: getWidth(
                                  context, (1 - totalMoney / firstGrade) * 114),
                              child: const ColoredBox(
                                color: AppTheme.moneyScaleGreenColor,
                              ),
                            ),
                            Container(
                              height: getHeight(context, 46),
                              width: getWidth(context, 2),
                              decoration: BoxDecoration(
                                gradient: AppTheme.moneyScaleStickColor,
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ],
                        ),)

                      ],
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [

                            SizedBox(
                              height: getHeight(context, 41),
                              width: getWidth(
                                  context, totalMoney / firstGrade * 114),
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppTheme.mainGreenColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    bottomLeft: Radius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: getHeight(context, 46),
                              width: getWidth(context, 2),
                              decoration: BoxDecoration(
                                gradient: AppTheme.moneyScaleStickColor,
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context, (1 - totalMoney / firstGrade) * 114),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
                Padding(
                  padding: EdgeInsets.only(right: getWidth(context, 5)),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '₽ ${sumToString(firstGrade)}',
                          style: TextLocalStyles.roboto400.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                            height: 16.41 / 14,
                            fontWeight: FontWeight.w100
                          ),
                        ),
                        Text(
                          'Стандарт',
                          style: TextLocalStyles.roboto600.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                            height: 16.41 / 14,
                            fontWeight: FontWeight.w700
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getHeight(context, 48),
          width: getWidth(context, 114),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if ((totalMoney + additionalMoney) <= firstGrade) ...[
                SizedBox(
                  height: getHeight(context, 41),
                  width: getWidth(context, 114),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppTheme.mainPinkGradient,
                    ),
                  ),
                )
              ] else if ((totalMoney + additionalMoney) <= secondGrade) ...[
                if (totalMoney > firstGrade) ...[
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [

                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                (totalMoney - firstGrade) /
                                    (secondGrade - firstGrade) *
                                    114),
                            child: const ColoredBox(
                              color: AppTheme.mainGreenColor,
                            ),
                          ),
                          Container(
                            height: getHeight(context, 46),
                            width: getWidth(context, 2),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                        ],
                      ),
                      additionalMoney != 0
                          ? Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [

                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                additionalMoney /
                                    (secondGrade - firstGrade) *
                                    114),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),

                          Container(
                            height: getHeight(context, 46),
                            width: getWidth(context, 2),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                        ],
                      )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: SizedBox(
                          height: getHeight(context, 41),
                          width: getWidth(
                              context,
                              (1 -
                                  (totalMoney -
                                      firstGrade +
                                      additionalMoney) /
                                      (secondGrade - firstGrade)) *
                                  114),
                          child: const ColoredBox(
                            color: AppTheme.mainPinkColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ] else ...[
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [

                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                (totalMoney + additionalMoney - firstGrade) /
                                    (secondGrade - firstGrade) *
                                    114),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),
                          Container(
                            height: getHeight(context, 46),
                            width: getWidth(context, 2),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          height: getHeight(context, 41),
                          width: getWidth(
                              context,
                              ((1 -
                                  ((totalMoney +
                                      additionalMoney -
                                      firstGrade) /
                                      (secondGrade - firstGrade))) *
                                  114)),
                          child: const ColoredBox(
                            color: AppTheme.mainPinkColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ]
              ] else ...[
                if (totalMoney > firstGrade) ...[
                  if (totalMoney > secondGrade) ...[
                    SizedBox(
                      height: getHeight(context, 41),
                      width: getWidth(context, 114),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: AppTheme.mainGreenGradient,
                        ),
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [

                            SizedBox(
                              height: getHeight(context, 41),
                              width: getWidth(
                                  context,
                                  (totalMoney - firstGrade) /
                                      (secondGrade - firstGrade) *
                                      114),
                              child: const ColoredBox(
                                color: AppTheme.mainGreenColor,
                              ),
                            ),
                            Container(
                              height: getHeight(context, 46),
                              width: getWidth(context, 2),
                              decoration: BoxDecoration(
                                gradient: AppTheme.moneyScaleStickColor,
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(context, 41),
                          width: getWidth(
                              context,
                              (1 -
                                  (totalMoney - firstGrade) /
                                      (secondGrade - firstGrade)) *
                                  114),
                          child: const ColoredBox(
                            color: AppTheme.moneyScaleGreenColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ] else ...[
                  SizedBox(
                    height: getHeight(context, 41),
                    width: getWidth(context, 114),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppTheme.moneyScaleGreenColor,
                      ),
                    ),
                  ),
                ],
              ],
              Padding(
                padding: EdgeInsets.only(right: getWidth(context, 5)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₽ ${sumToString(secondGrade)}',
                        style: TextLocalStyles.roboto400.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                          height: 16.41 / 14,
                        ),

                      ),
                      Text(
                        'Премиум',
                        style: TextLocalStyles.roboto600.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                          height: 16.41 / 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getHeight(context, 48),
          width: getWidth(context, 114),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if ((totalMoney + additionalMoney) <= secondGrade) ...[
                SizedBox(
                  height: getHeight(context, 41),
                  width: getWidth(context, 114),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppTheme.mainPinkGradient,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                    ),
                  ),
                )
              ] else if ((totalMoney + additionalMoney) <= thirdGrade) ...[
                if (totalMoney > secondGrade) ...[
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [

                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                (totalMoney - secondGrade) /
                                    (thirdGrade - secondGrade) *
                                    114),
                            child: const ColoredBox(
                              color: AppTheme.mainGreenColor,
                            ),
                          ),

                          Container(
                            height: getHeight(context, 46),
                            width: getWidth(context, 2),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                        ],
                      ),
                      additionalMoney != 0
                          ? Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [

                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                additionalMoney /
                                    (thirdGrade - secondGrade) *
                                    114),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),
                          Container(
                            height: getHeight(context, 46),
                            width: getWidth(context, 2),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                        ],
                      )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: SizedBox(
                          height: getHeight(context, 41),
                          width: getWidth(
                              context,
                              (1 -
                                  (totalMoney -
                                      secondGrade +
                                      additionalMoney) /
                                      (thirdGrade - secondGrade)) *
                                  114),
                          child: const ColoredBox(
                            color: AppTheme.mainPinkColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ] else ...[
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [

                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                (totalMoney + additionalMoney - secondGrade) /
                                    (thirdGrade - secondGrade) *
                                    114),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),

                          Container(
                            height: getHeight(context, 46),
                            width: getWidth(context, 2),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          height: getHeight(context, 41),
                          width: getWidth(
                              context,
                              ((1 -
                                  ((totalMoney +
                                      additionalMoney -
                                      secondGrade) /
                                      (thirdGrade - secondGrade))) *
                                  114)),
                          child: const ColoredBox(
                            color: AppTheme.mainPinkColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ]
              ] else ...[
                if (totalMoney >= thirdGrade) ...[
                  Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [

                      SizedBox(
                        height: getHeight(context, 41),
                        width: getWidth(context, 114),
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: AppTheme.mainGreenGradient,
                          ),
                        ),
                      ),

                      Container(
                        height: getHeight(context, 46),
                        width: getWidth(context, 2),
                        decoration: BoxDecoration(
                          gradient: AppTheme.moneyScaleStickColor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [

                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context, totalMoney / thirdGrade * 114),
                            child: const ColoredBox(
                              color: AppTheme.mainGreenColor,
                            ),
                          ),

                          Container(
                            height: getHeight(context, 46),
                            width: getWidth(context, 2),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [

                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context, (1 - totalMoney / thirdGrade) * 114),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),
                          Container(
                            height: getHeight(context, 46),
                            width: getWidth(context, 2),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ],
              Padding(
                padding: EdgeInsets.only(right: getWidth(context, 5)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₽ ${sumToString(thirdGrade)}',
                        style: TextLocalStyles.roboto400.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                          height: 16.41 / 14,
                        ),
                      ),
                      Text(
                        'Делюкс',
                        style: TextLocalStyles.roboto600.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                          height: 16.41 / 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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
