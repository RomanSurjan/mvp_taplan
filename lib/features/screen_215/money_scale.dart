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
          height: getHeight(context, 45),
          width: getWidth(context, 113),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if (totalMoney == 0) ...[
                if (additionalMoney == 0) ...[
                  SizedBox(
                    height: getHeight(context, 41),
                    width: getWidth(context, 113),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppTheme.mainPinkGradient,
                      ),
                    ),
                  ),
                ] else ...[
                  if (additionalMoney > firstGrade) ...[
                    SizedBox(
                      height: getHeight(context, 41),
                      width: getWidth(context, 113),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          //gradient: AppTheme.mainGreenGradient,
                          color: Color.fromRGBO(119, 187, 102, 0.81),
                        ),
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                            Container(
                              height: getHeight(context, 45),
                              width: getWidth(context, 3),
                              decoration: BoxDecoration(
                                gradient: AppTheme.moneyScaleStickColor,
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(context, 41),
                              width: getWidth(
                                  context, additionalMoney / firstGrade * 113),
                              child: const ColoredBox(
                                color: Color.fromRGBO(119, 187, 102, 0.81),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(context, 41),
                          width: getWidth(context,
                              (1 - additionalMoney / firstGrade) * 113),
                          child: const ColoredBox(
                            color: AppTheme.mainPinkColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ]
              ] else if (totalMoney > firstGrade) ...[
                SizedBox(
                  height: getHeight(context, 41),
                  width: getWidth(context, 113),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppTheme.mainGreenGradient,
                    ),
                  ),
                ),
              ] else ...[
                if ((totalMoney + additionalMoney) <= firstGrade) ...[
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context, totalMoney / firstGrade * 113),
                            child: const ColoredBox(
                              color: AppTheme.mainGreenColor,
                            ),
                          ),
                        ],
                      ),
                      additionalMoney != 0
                          ? Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(context,
                                additionalMoney / firstGrade * 113),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),
                        ],
                      )
                          : const SizedBox.shrink(),
                      SizedBox(
                        height: getHeight(context, 41),
                        width: getWidth(
                            context,
                            (1 - (totalMoney + additionalMoney) / firstGrade) *
                                113),
                        child: const ColoredBox(
                          color: AppTheme.mainPinkColor,
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
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context, totalMoney / firstGrade * 113),
                            child: const ColoredBox(
                              color: AppTheme.mainGreenColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(context, 41),
                        width: getWidth(
                            context, (1 - totalMoney / firstGrade) * 113),
                        child: const ColoredBox(
                          color: AppTheme.moneyScaleGreenColor,
                        ),
                      ),
                    ],
                  ),
                ]
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
                      height: 16.41 / 14,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getHeight(context, 45),
          width: getWidth(context, 113),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if ((totalMoney + additionalMoney) <= firstGrade) ...[
                SizedBox(
                  height: getHeight(context, 41),
                  width: getWidth(context, 113),
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
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                (totalMoney - firstGrade) /
                                    (secondGrade - firstGrade) *
                                    113),
                            child: const ColoredBox(
                              color: AppTheme.mainGreenColor,
                            ),
                          ),
                        ],
                      ),
                      additionalMoney != 0
                          ? Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                additionalMoney /
                                    (secondGrade - firstGrade) *
                                    113),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),
                        ],
                      )
                          : const SizedBox.shrink(),
                      SizedBox(
                        height: getHeight(context, 41),
                        width: getWidth(
                            context,
                            (1 -
                                (totalMoney -
                                    firstGrade +
                                    additionalMoney) /
                                    (secondGrade - firstGrade)) *
                                113),
                        child: const ColoredBox(
                          color: AppTheme.mainPinkColor,
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
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                (totalMoney + additionalMoney - firstGrade) /
                                    (secondGrade - firstGrade) *
                                    113),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(context, 41),
                        width: getWidth(
                            context,
                            ((1 -
                                ((totalMoney +
                                    additionalMoney -
                                    firstGrade) /
                                    (secondGrade - firstGrade))) *
                                113)),
                        child: const ColoredBox(
                          color: AppTheme.mainPinkColor,
                        ),
                      ),
                    ],
                  )
                ]
              ] else ...[
                if (totalMoney > secondGrade) ...[
                  SizedBox(
                    height: getHeight(context, 41),
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
                      Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                (totalMoney - firstGrade) /
                                    (secondGrade - firstGrade) *
                                    113),
                            child: const ColoredBox(
                              color: AppTheme.mainGreenColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(context, 41),
                        width: getWidth(
                            context,
                            (1- (totalMoney - firstGrade) /
                                (secondGrade - firstGrade)) *
                                113),
                        child: const ColoredBox(
                          color: AppTheme.moneyScaleGreenColor,
                        ),
                      ),
                    ],
                  )
                ]
              ],
              Padding(
                padding: EdgeInsets.only(right: getWidth(context, 3)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$secondGrade ₽\nПремиум',
                    style: TextLocalStyles.roboto600.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      height: 16.41 / 14,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: getHeight(context, 45),
          width: getWidth(context, 113),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if ((totalMoney + additionalMoney) <= secondGrade) ...[
                SizedBox(
                  height: getHeight(context, 41),
                  width: getWidth(context, 113),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppTheme.mainPinkGradient,
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
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                (totalMoney - secondGrade) /
                                    (thirdGrade - secondGrade) *
                                    113),
                            child: const ColoredBox(
                              color: AppTheme.mainGreenColor,
                            ),
                          ),
                        ],
                      ),
                      additionalMoney != 0
                          ? Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                additionalMoney /
                                    (thirdGrade - secondGrade) *
                                    113),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),
                        ],
                      )
                          : const SizedBox.shrink(),
                      SizedBox(
                        height: getHeight(context, 41),
                        width: getWidth(
                            context,
                            (1 -
                                (totalMoney -
                                    secondGrade +
                                    additionalMoney) /
                                    (thirdGrade - secondGrade)) *
                                113),
                        child: const ColoredBox(
                          color: AppTheme.mainPinkColor,
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
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context,
                                (totalMoney + additionalMoney - secondGrade) /
                                    (thirdGrade - secondGrade) *
                                    113),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(context, 41),
                        width: getWidth(
                            context,
                            ((1 -
                                ((totalMoney +
                                    additionalMoney -
                                    secondGrade) /
                                    (thirdGrade - secondGrade))) *
                                113)),
                        child: const ColoredBox(
                          color: AppTheme.mainPinkColor,
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
                      Container(
                        height: getHeight(context, 45),
                        width: getWidth(context, 3),
                        decoration: BoxDecoration(
                          gradient: AppTheme.moneyScaleStickColor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 41),
                        width: getWidth(context, 113),
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: AppTheme.mainGreenGradient,
                          ),
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
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context, totalMoney / thirdGrade * 113),
                            child: const ColoredBox(
                              color: AppTheme.mainGreenColor,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Container(
                            height: getHeight(context, 45),
                            width: getWidth(context, 3),
                            decoration: BoxDecoration(
                              gradient: AppTheme.moneyScaleStickColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 41),
                            width: getWidth(
                                context, (1 - totalMoney / thirdGrade) * 113),
                            child: const ColoredBox(
                              color: AppTheme.moneyScaleGreenColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ]
              ],
              Padding(
                padding: EdgeInsets.only(right: getWidth(context, 3)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$thirdGrade ₽\nДелюкс',
                    style: TextLocalStyles.roboto600.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      height: 16.41 / 14,
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
