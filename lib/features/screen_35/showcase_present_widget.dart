import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvp_taplan/models/sum_to_string.dart';

import 'package:mvp_taplan/theme/colors.dart';

class ShowcasePresentWidget extends StatelessWidget {
  final VoidCallback? callback;
  final String id;
  final String photo;
  final int video;
  final int invested;
  final int total;
  final bool boughtEarly;
  final bool groupPurchase;
  final bool deliver;
  final int likes;
  final bool liked;
  final int comments;
  final double height;
  final double width;

  const ShowcasePresentWidget({
    super.key,
    required this.callback,
    required this.id,
    required this.photo,
    required this.video,
    required this.invested,
    required this.total,
    required this.boughtEarly,
    required this.groupPurchase,
    required this.deliver,
    required this.likes,
    required this.liked,
    required this.comments,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    const double iconPadding = 5;
    final double investedPercentage = (invested / total * 100);
    final double tensilePart = height - 4 * (32 + iconPadding) - 2;
    return InkWell(
      onDoubleTap: () {
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
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 1, bottom: 2),
                          child: Container(
                            height: 9,
                            width: 33,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(1.0),
                            ),
                            child: Text(
                              " ${investedPercentage.toStringAsFixed(1)}%  ",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 9,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400
                                // height: 0.9,
                              ),
                              // strutStyle: const StrutStyle(
                              //   fontFamily: 'Roboto',
                              //   fontSize: 9,
                              //   height: 0.5,
                              // leading: 1.0,
                              // ),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox(height: 1)),
                        Container(
                          margin: const EdgeInsets.only(right: 3, bottom: 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: iconPadding),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: Image.asset(
                                      'assets/images/video.png',
                                      fit:BoxFit.scaleDown,
                                    )
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    '0',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 9,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]
                              ),
                              const SizedBox(height: iconPadding),
                              const SocialIcon(
                                icon: 'assets/svg/share-alt.svg',
                                color: Color(0xFFFFFFFF),
                                count: 0,
                              ),
                              SizedBox(height: tensilePart),
                              SocialIcon(
                                icon: 'assets/svg/comment.svg',
                                color: const Color(0xFFFFFFFF),
                                count: comments,
                              ),
                              const SizedBox(height: iconPadding),
                              SocialIcon(
                                icon: 'assets/svg/heart.svg',
                                color: liked
                                    ? const Color(0xFFFF0000)
                                    : const Color(0xFFFFFFFF),
                                count: likes,
                              ),
                              const SizedBox(height: iconPadding)
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width,
                      height: 11,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: invested,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 11,
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
                                      height: 11,
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
                            ]
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " ${sumToString(invested)}",
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 9,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                                strutStyle: const StrutStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 9,
                                  height: 0.9,
                                  leading: 0.5,
                                )
                              ),
                              Text(
                                "${sumToString(total)} ",
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 9,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                                  strutStyle: const StrutStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 9,
                                    height: 0.9,
                                    leading: 0.5,
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
            ],
          ),
          const SizedBox(height: 1)
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
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 18,
          width: 18,
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            fit: BoxFit.fitHeight,
          ),
        ),
        Text(
          "$count",
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 9,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
