import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/features/screen_12/screen_12.dart';
import 'package:mvp_taplan/features/screen_26/screen_26.dart';
import 'package:mvp_taplan/features/screen_35/screen_35.dart';
import 'package:mvp_taplan/features/screen_sendWishlist/screen_sendWishlist.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/text_styles.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomNavigationBar extends StatefulWidget {
  static const svgForBar = [
    'assets/svg/home.svg',
    'assets/svg/book_heart.svg',
    'assets/svg/telegram.svg',
    'assets/svg/sharenav.svg',
    'assets/svg/stars.svg',
  ];

  final bool isTelegram;

  final VoidCallback onTapTelegram;

  const CustomNavigationBar({
    super.key,
    required this.onTapTelegram,
    required this.isTelegram,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  String? authToken;

  void getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('auth_token');
  }

  @override
  void initState() {
    super.initState();

    getAuthToken();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getWidth(context, 8),
        right: getWidth(context, 8),
        bottom: getHeight(context, 8),
      ),
      child: Column(
        children: [
          SizedBox(
            width: getWidth(context, 371),
            height: getHeight(context, 40),
            child: widget.isTelegram
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 250, 1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              authToken == null
                                  ? 'Для запроса на подписку на канал\nпредлагаем Вам зарегестироваться'
                                  : 'Запрос отправлен',
                              textAlign: TextAlign.center,
                              style: TextLocalStyles.roboto500.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(57, 57, 57, 1),
                                fontSize: getHeight(context, 14),
                                height: 16.41 / 14,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: getWidth(context, 31),
                              ),
                              child: SvgPicture.asset(
                                'assets/svg/arrow_down_long.svg',
                                colorFilter: const ColorFilter.mode(
                                  Color.fromRGBO(57, 57, 57, 1),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(
            height: getHeight(context, 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                rectangleMainBarItem(
                  context,
                  svg: CustomNavigationBar.svgForBar[0],
                  onTap: authToken == null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Screen12(
                                isPressed: false,
                              ),
                            ),
                          );
                        }
                      : () {},
                  isActive: authToken == null,
                ),
                const SizedBox(
                  width: 9,
                ),
                rectangleMainBarItem(
                  context,
                  svg: CustomNavigationBar.svgForBar[1],
                  onTap: authToken == null
                      ? () {}
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Screen26(),
                            ),
                          );
                        },
                  isActive: authToken != null,
                ),
                const SizedBox(
                  width: 10,
                ),
                circleMainBarItem(context, svg: CustomNavigationBar.svgForBar[2]),
                const SizedBox(
                  width: 10,
                ),
                rectangleMainBarItem(
                  context,
                  svg: CustomNavigationBar.svgForBar[3],
                  onTap: authToken == null
                      ? () {
                          Share.shareUri(Uri.base);
                        }
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ScreenSendWishlist(),
                            ),
                          );
                        },
                  isActive: true,
                ),
                const SizedBox(
                  width: 9,
                ),
                rectangleMainBarItem(
                  context,
                  svg: CustomNavigationBar.svgForBar[4],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Screen35(),
                      ),
                    );
                  },
                  isActive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rectangleMainBarItem(
    BuildContext context, {
    required String svg,
    required VoidCallback onTap,
    required bool isActive,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: getWidth(context, 55),
        width: getWidth(context, 55),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(255, 255, 255, 1),
                Color.fromRGBO(224, 236, 250, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromRGBO(209, 224, 239, 1),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              svg,
              colorFilter: isActive
                  ? null
                  : const ColorFilter.mode(
                      Color.fromRGBO(143, 150, 156, 0.5),
                      BlendMode.srcIn,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget circleMainBarItem(
    BuildContext context, {
    required String svg,
  }) {
    return InkWell(
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onTapTelegram,
      child: SizedBox(
        height: getWidth(context, 65),
        width: getWidth(context, 65),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(105, 205, 177, 1),
              width: getHeight(context, 2),
            ),
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(255, 255, 255, 1),
                Color.fromRGBO(224, 236, 250, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
            boxShadow: !widget.isTelegram
                ? [
                    const BoxShadow(
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                      color: Color.fromRGBO(144, 170, 201, 1),
                      inset: true,
                    ),
                    const BoxShadow(
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      inset: true,
                    ),
                  ]
                : [
                    const BoxShadow(
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      color: Color.fromRGBO(144, 170, 201, 1),
                      inset: true,
                    ),
                    const BoxShadow(
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      inset: true,
                    ),
                  ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              svg,
            ),
          ),
        ),
      ),
    );
  }
}
