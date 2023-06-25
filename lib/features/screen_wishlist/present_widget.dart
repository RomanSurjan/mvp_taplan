import 'package:flutter/material.dart';

import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

/// Виджет подарков для экрана "Мой список желанных подарков".

class PresentWidget extends StatelessWidget {

  final String pathToImage;
  final Function callback;
  final int collected;
  final int total;
  final bool isTop;
  late final int leftToCollect;

  PresentWidget({
    required this.pathToImage,
    required this.callback,
    required this.collected,
    required this.total,
    required this.isTop,
    Key? key
  }) : super(key: key) {
    leftToCollect = total - collected;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback(),
      child:Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          // Фото подарка.
          Image.asset(
            pathToImage,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
          // Шкала собраных средств.
          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              // Сама шкала.
              Row(
                children: <Widget>[
                  // Левая часть шкалы.
                  Expanded(
                    flex: collected,
                    child: Container(
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppTheme.wishListScaleLeftColor,
                            AppTheme.wishListScaleLeftColor.withOpacity(0.6)
                          ]
                        )
                      )
                    )
                  ),
                  // Правая часть шкалы.
                  Expanded(
                    flex: leftToCollect,
                    child: Container(
                      height: 24,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppTheme.wishListScaleRightColor,
                            AppTheme.wishListScaleRightColor.withOpacity(0.6)
                          ]
                        )
                      ),
                    )
                  )
                ],
              ),
              // Подписи.
              Row(
                children: <Widget>[
                  Text(
                    isTop? "  Собрано $collected ₽": "  $collected ₽",
                    style:  wishListScaleTextStyle,
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(height: 1)
                  ),
                  Text(
                    isTop? "Осталось $leftToCollect ₽  ": "$leftToCollect ₽  ",
                    style:  wishListScaleTextStyle,
                  )
                ]
              )
            ],
          )
        ]
      )
    );
  }
}