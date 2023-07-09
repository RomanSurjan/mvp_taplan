import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

part 'action_button.dart';

part 'postcard_view.dart';

part 'pick_container.dart';

class Screen213 extends StatefulWidget {
  const Screen213({super.key});

  @override
  State<Screen213> createState() => _Screen213State();
}

class _Screen213State extends State<Screen213> {
  static const postcards = [
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
    "assets/images/postcard.png",
  ];

  int i = 6;

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Подписать открытку',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 16)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 20),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  label: 'Чат-телеграмм\nличный',
                ),
                ActionButton(
                  label: 'Чат-телеграмм\nгрупповой',
                ),
                ActionButton(
                  label: 'Приложить\nк подарку ',
                  hasStar: true,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 16),
              ),
            ),
            PostCardViewWidget(
              postcards: postcards,
              currentIndex: i,
              onPageChanged: (index) {
                i = index;
                setState(() {});
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 16),
              ),
            ),
            Text(
              '* Бесплатная открытка при подарке от ₽1000',
              style: TextLocalStyles.roboto500
                  .copyWith(color: AppTheme.mainGreenColor, fontSize: 14, height: 0),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 16),
              ),
            ),
            PickContainer(
              height: getHeight(context, 34),
              width: getWidth(context, 343),
              label: 'Еженедельный стрим / День рождения',
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 11),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PickContainer(
                  height: getHeight(context, 34),
                  width: getWidth(context, 169),
                  label: '07.07.2023',
                ),
                PickContainer(
                  height: getHeight(context, 34),
                  width: getWidth(context, 169),
                  label: '21:30',
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 14),
              ),
            ),
            CustomTextField(
              height: getHeight(context, 120),
              width: getWidth(context, 343),
              hintText: 'Текст открытки',
              maxLines: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 16),
              ),
            ),
            MvpGradientButton(
              label: 'Сохранить',
              gradient: AppTheme.mainGreenGradient,
              width: getWidth(context, 345),
              height: getHeight(context, 46),
              style: TextLocalStyles.roboto500.copyWith(
                color: Colors.white,
                fontSize: 14,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
