import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_bloc.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_state.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_39/screen_39.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen115 extends StatefulWidget {
  final MvpPresentModel currentModel;

  const Screen115({
    super.key,
    required this.currentModel,
  });

  @override
  State<Screen115> createState() => _Screen115State();
}

class _Screen115State extends State<Screen115> {

  static const List<String> iconsForButtons = [
    'assets/svg/gallery_inspiration.svg',
    'assets/svg/gallery_give.svg',
    'assets/svg/gallery_buy.svg',
    'assets/svg/gallery_hint.svg',
    'assets/svg/gallery_subscribe.svg',
  ];

  static const List<String> namesOfButtons = [
    "В избранное",
    "Подарить",
    "Купить",
    "Намекнуть",
    "Подписаться",
  ];

  static const List<bool> buttonsActives = [false, true, true, true, false];

  final String title = "Загловок";
  final String description1 = "Описание 1";
  final String description2 = "Описание 2";
  final String description3 = "Описание 3";
  final String artistName = "Имя художника";
  final String artistLocation = "Город художника";

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: "Галерея художника",
      child: BlocBuilder<BuyTogetherBloc, BuyTogetherState>(
        builder: (context, state) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {

              final bool isPortraitOrientation =
                  ((MediaQuery.of(context).size.width / MediaQuery.of(context).size.height) < 0.6);

              final double columnWidth = (isPortraitOrientation)
                  ? MediaQuery.of(context).size.width
                  : (MediaQuery.of(context).size.height * 0.6);
              final buttonSize = columnWidth / 375 * 62;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: columnWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 0; i < iconsForButtons.length; i++)
                              SquareGradientButton(
                                icon: iconsForButtons[i],
                                text: namesOfButtons[i],
                                size: buttonSize,
                                isActive: buttonsActives[i],
                                onTap: () {},
                              )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Stack(
                          children: [
                          SizedBox(
                            height: getHeight(context, 343),
                            width: getWidth(context, 343),
                            child: Image.network(
                            // (isPickedMoney[0]
                            //         ? widget.currentModel.gradePhotoThird
                            //         : isPickedMoney[1]
                            //             ? widget.currentModel.gradePhotoSecond
                            //             : widget.currentModel.gradePhotoFirst) ??
                                widget.currentModel.smallImage,
                            fit: BoxFit.fill,
                          ),
                        ),
                        if (widget.currentModel.videoId != null)
                          Positioned.fill(
                            top: getHeight(context, 17),
                            right: getWidth(context, 14),
                            bottom: getHeight(context, 17),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      final contentList =
                                          context.read<JournalBloc>().state.contentList;
                                      int currentVideoIndex = -1;
                                      for (var el in contentList) {
                                        if (el.videos.contains(widget.currentModel.videoId)) {
                                          currentVideoIndex = contentList.indexOf(el);
                                        }
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => Screen39(
                                            initialIndex: currentVideoIndex,
                                            fromShowcase: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/video_button.png',
                                    ),
                                  ),
                                  buildControlButton(
                                    context,
                                    'assets/svg/share-alt.svg',
                                  ),
                                  const Expanded(child: SizedBox()),
                                  buildControlButton(
                                    context,
                                    'assets/svg/heart.svg',
                                  ),
                                  buildControlButton(
                                    context,
                                    'assets/svg/comment.svg',
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                        const SizedBox(height: 15),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(themeState.isDark ? 0xFFF0F7FE : 0xFF161A1D),
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          description1,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(themeState.isDark ? 0xFFF0F7FE : 0xFF414E58),
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text(
                          description2,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(themeState.isDark ? 0xFFF0F7FE : 0xFF414E58),
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text(
                          description3,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(themeState.isDark ? 0xFFF0F7FE : 0xFF414E58),
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  artistName,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(themeState.isDark ? 0xFFF0F7FE : 0xFF414E58),
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/location.svg',
                                      colorFilter: const ColorFilter.mode(
                                        Color(0xFF9DA7B0),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    Text(
                                      artistLocation,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(themeState.isDark ? 0xFFF0F7FE : 0xFF627684),
                                          fontWeight: FontWeight.w400
                                      )
                                    ),
                                  ]
                                )
                              ]
                            ),
                            const Expanded(child: SizedBox()),
                            MvpGradientButton(
                              opacity: 0.1,
                              label: 'Презентация',
                              gradient: AppTheme.mainGreenGradient,
                              width: 123,
                              onTap: () {},
                              height: 46,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15)
                      ]
                    )
                  )
                ]
              );
            },
          );
        },
      ),
    );
  }

  Widget buildControlButton(BuildContext context, String svgImage) {
    return Column(
      children: [
        SvgPicture.asset(
          svgImage,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
        Text(
          '8',
          style: TextLocalStyles.roboto600.copyWith(
            color: Colors.white,
            fontSize: getHeight(context, 14),
            height: 16.41 / 14,
          ),
        ),
      ],
    );
  }
}

class SquareGradientButton extends StatelessWidget {
  final String icon;
  final double size;
  final VoidCallback? onTap;
  final bool isActive;
  final String text;

  const SquareGradientButton({
    super.key,
    required this.icon,
    required this.size,
    required this.onTap,
    required this.isActive,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Timer(
          const Duration(milliseconds: 500),
          () {onTap?.call();},
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: size,
            width: size,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(98, 198, 170, isActive? 0.3 : 0.1),
                    Color.fromRGBO(68, 168, 140, isActive? 0.3 : 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromRGBO(82, 182, 154, 1),
                  width: 1,
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: size / 31 * 20,
                  height: size / 31 * 20,
                  child: SvgPicture.asset(
                    icon,
                    colorFilter: ColorFilter.mode(
                      Color.fromRGBO(82, 182, 154, isActive? 1 : 0.5),
                      BlendMode.srcIn,
                    ),
                  ),
                )
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            text,
            style: TextLocalStyles.roboto400.copyWith(
              color: context.read<ThemeBloc>().state.appBarTextColor,
              fontSize: 10,
              height: 11.02 / 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      )
    );
  }
}