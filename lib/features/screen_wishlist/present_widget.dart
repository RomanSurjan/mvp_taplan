import 'package:flutter/material.dart';
import 'package:mvp_taplan/models/models.dart';

import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

/// Виджет подарков для экрана "Мой список желанных подарков".

class PresentWidget extends StatelessWidget {
  final String pathToImage;
  final VoidCallback? callback;
  final int collected;
  final int total;
  final bool isTop;
  final double height;
  final double width;

  PresentWidget({
    super.key,
    required this.pathToImage,
    required this.callback,
    required this.collected,
    required this.total,
    required this.isTop,
    required this.height,
    required this.width,
  });

  late final int leftToCollect = total - collected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback?.call();
      },
      child: Column(
        children: [
          Image.network(
            pathToImage,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
          SizedBox(
            width: width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: collected,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: getHeight(context, 24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppTheme.wishListScaleLeftColor,
                              AppTheme.wishListScaleLeftColor.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: leftToCollect,
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: getHeight(context, 24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppTheme.wishListScaleRightColor,
                              AppTheme.wishListScaleRightColor.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isTop ? "  Собрано ${sumToString(collected)} ₽" : "  ${sumToString(collected)} ₽",
                      style: TextLocalStyles.roboto600.copyWith(
                        color: Colors.white,
                        fontSize: getHeight(context, 14),
                      ),
                    ),
                    Text(
                      isTop ? "Осталось  ${sumToString(leftToCollect)} ₽  " : "${sumToString(leftToCollect)} ₽  ",
                      style: TextLocalStyles.roboto600.copyWith(
                        color: Colors.white,
                        fontSize: getHeight(context, 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String sumToString(int value){
    String stringValue = value.toString();
    if(value ~/ 1000 != 0){
      stringValue = '${stringValue.substring(0,stringValue.length-3)} ${stringValue.substring(stringValue.length-3)}';
    }
    if(value ~/ 1000000 != 0){
      stringValue = '${stringValue.substring(0,stringValue.length-7)} ${stringValue.substring(stringValue.length-7)}';

    }
    return stringValue;
  }
}
