import 'package:flutter/material.dart';
import 'package:mvp_taplan/features/screen_214/screen_214.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

part 'money_scale.dart';

part 'pick_your_money.dart';

part 'pick_your_money_container.dart';

class Screen215 extends StatefulWidget {
  const Screen215({Key? key}) : super(key: key);

  @override
  State<Screen215> createState() => _Screen215State();
}

class _Screen215State extends State<Screen215> {
  final double totalPrice = 12600;

  List<String> prices = ['₽ 9 900', '₽ 7 500', '₽ 7 500', ''];
  List<String> labels = ['до Делюкс', 'до Премиума', 'до Стандарта', ''];
  List<bool> isPickedMoney = [
    false,
    true,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Скинуться\nна подарок',
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth(context, 16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 12),
              ),
            ),
            SizedBox(
              height: getHeight(context, 343),
              width: getWidth(context, 343),
              child: Image.asset(
                'assets/images/image_116.png',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 10),
              ),
            ),
            Text(
              'Собрано ₽ $totalPrice',
              style:
                  TextLocalStyles.roboto600.copyWith(fontSize: 16, color: AppTheme.mainGreenColor),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 4),
              ),
            ),
            MoneyScale(
              firstGrade: 15000,
              secondGrade: 25500,
              thirdGrade: 100000,
              totalMoney: totalPrice,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 20),
              ),
            ),
            SizedBox(
              height: getHeight(context, 166),
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      Padding(padding: EdgeInsets.only(top: getHeight(context, 2))),
                  itemCount: isPickedMoney.length,
                  itemBuilder: (context, index) {
                    return PickUpPriceContainer(
                      price: prices[index],
                      label: labels[index],
                      isPicked: isPickedMoney[index],
                      child: isPickedMoney.length - 1 == index ? const PickYourMoney() : null,
                      onTap: () {
                        for (int i = 0; i < isPickedMoney.length; i++) {
                          if (i == index) {
                            isPickedMoney[i] = true;
                          } else {
                            isPickedMoney[i] = false;
                          }
                        }
                        setState(() {});
                      },
                    );
                  }),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: EdgeInsets.only(
                bottom: getHeight(context, 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MvpGradientButton(
                    label: 'Выбрать\nоткрытку',
                    gradient: AppTheme.mainPurpleGradient,
                    width: getWidth(context, 109),
                  ),
                  MvpGradientButton(
                    label: 'Внести\nденьги',
                    gradient: AppTheme.mainGreenGradient,
                    width: getWidth(context, 109),
                  ),
                  MvpGradientButton(
                    label: 'Купить\nсовместно',
                    gradient: AppTheme.mainGreenGradient,
                    width: getWidth(context, 109),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
