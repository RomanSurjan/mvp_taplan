import 'package:flutter/material.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/models/sum_to_string.dart';

import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

/// Виджет подарков для экрана "Мой список желанных подарков".

class PresentWidget extends StatelessWidget {

  final VoidCallback? callback;
  final bool isTop;
  final double height;
  final double width;
  final MvpPresentModel currentModel;

  const PresentWidget({
    super.key,
    required this.callback,
    required this.isTop,
    required this.height,
    required this.width,
    required this.currentModel,
  });



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback?.call();
      },
      child: Column(
        children: [
          Image.network(
            isTop ? currentModel.bigImage : currentModel.smallImage,
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
                      flex: currentModel.alreadyGet,
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
                      flex: currentModel.fullPrice - currentModel.alreadyGet,
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
                Positioned(
                  left: currentModel.gradeValueFirst / currentModel.fullPrice * width,
                  child: SizedBox(
                    height: getHeight(context, 24),
                    width: getWidth(context, 1.5),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(75, 175, 147, 0.5),
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: currentModel.gradeValueSecond / currentModel.fullPrice * width,
                  child: SizedBox(
                    height: getHeight(context, 24),
                    width: getWidth(context, 1.5),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(75, 175, 147, 0.5),
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isTop
                          ? "  Собрано ${sumToString(currentModel.alreadyGet)} ₽"
                          : "  ${sumToString(currentModel.alreadyGet)} ₽",
                      style: TextLocalStyles.roboto600.copyWith(
                        color: Colors.white,
                        fontSize: getHeight(context, 14),
                      ),
                    ),
                    Text(
                      isTop
                          ? "Осталось  ${sumToString(currentModel.gradeValueFirst - currentModel.alreadyGet)} ₽  "
                          : "${sumToString(currentModel.gradeValueFirst - currentModel.alreadyGet)} ₽  ",
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
}
