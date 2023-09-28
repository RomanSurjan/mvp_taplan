import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/models/sum_to_string.dart';

import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class ShowcasePresentWidget extends StatelessWidget {
  final VoidCallback? callback;
  final String id;
  final String photo;
  final int invested;
  final int total;
  final bool boughtEarly;
  final bool groupPurchase;
  final bool deliver;
  final double height;
  final double width;

  const ShowcasePresentWidget({
    super.key,
    required this.callback,
    required this.id,
    required this.photo,
    required this.invested,
    required this.total,
    required this.boughtEarly,
    required this.groupPurchase,
    required this.deliver,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    double investedPercentage = (invested / total * 100);
    return InkWell(
      onTap: () {
        callback?.call();
      },
      child: Column(
        children: [
          Stack(
          alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                photo,
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
              SizedBox(
                width: width,
                height: height,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 2, bottom: 2),
                        child: Container(
                          // width: getWidth(context, 100),
                            height: 11,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            //color: theme.celebrateTextBackgroundColor.withOpacity(0.5),
                            child: Text(
                                " ${investedPercentage.toStringAsFixed(1)}%  ",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 9,
                                    fontFamily: 'Roboto',
                                    height: 0.9
                                ),
                                strutStyle: const StrutStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 9,
                                  height: 0.7,
                                  leading: 1.0,)
                            )
                        ),
                      ),
                      const Expanded(child: SizedBox(height: 1)),
                      Container(
                        margin: const EdgeInsets.only(right: 2, bottom: 0),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                            children: [
                              SocialIcon(
                                icon: 'assets/svg/share-alt.svg',
                                color: Color(0xFFFFFFFF),
                                count: 0
                              ),
                              SocialIcon(
                                icon: 'assets/svg/comment.svg',
                                color: Color(0xFFFFFFFF),
                                count: 0
                              ),
                              SocialIcon(
                                icon: 'assets/svg/heart.svg',
                                color: Color(0xFFFF0000),
                                count: 0
                              )
                            ],
                        )
                      )
                    ]
                ),
              )
            ]
          ),
          const SizedBox(height: 1),
          SizedBox(
            width: width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: invested,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: getHeight(context, 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppTheme.wishListScaleLeftColor.withOpacity(0.3),
                              AppTheme.wishListScaleLeftColor.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: total - invested,
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: getHeight(context, 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppTheme.wishListScaleRightColor.withOpacity(0.3),
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
                      " ${sumToString(invested)}",
                      style: TextLocalStyles.roboto600.copyWith(
                        color: Colors.white,
                        fontSize: getHeight(context, 12),
                      ),
                    ),
                    Text(
                      "${sumToString(total)} ",
                      style: TextLocalStyles.roboto600.copyWith(
                        color: Colors.white,
                        fontSize: getHeight(context, 12),
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

class SocialIcon extends StatelessWidget {

  final String icon;
  final Color color;
  final int count;

  const SocialIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.count
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 14,
            width: 14,
            child: SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  color,
                  BlendMode.srcIn
                ),
                fit: BoxFit.fitHeight
            )
        ),
        Text(
          "$count",
          style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 10,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500
              // height: 0.9
          ),
        )
      ],
    );
  }
}