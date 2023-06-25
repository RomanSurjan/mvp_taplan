import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/models/size_model.dart';
import 'package:mvp_taplan/theme/colors.dart';

part 'pickup_date.dart';

part 'pickup_price.dart';

class Screen214 extends StatefulWidget {
  const Screen214({Key? key}) : super(key: key);

  @override
  State<Screen214> createState() => _Screen214State();
}

class _Screen214State extends State<Screen214> {
  bool isFirstPicked = false;
  bool isSecondPicked = true;
  bool isThirdPicked = false;

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Покупка подарка\nтолько от себя',
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
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 16),
              ),
            ),
            const Text(
              "Дата и время вручения подарка",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 4),
              ),
            ),
            Row(
              children: [
                const PickUpDate(
                  label: 'Дата вручения',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getWidth(context, 7),
                  ),
                ),
                const PickUpDate(
                  label: 'Время вручения',
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 24),
              ),
            ),
            Column(
              children: [
                PickUpPriceContainer(
                  price: '₽ 9 900',
                  label: 'Делюкс',
                  onTap: () {
                    isFirstPicked = true;
                    isSecondPicked = false;
                    isThirdPicked = false;
                    setState(() {});
                  },
                  isPicked: isFirstPicked,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 2),
                  ),
                ),
                PickUpPriceContainer(
                  price: '₽ 7 500',
                  label: 'Премиум',
                  onTap: () {
                    isFirstPicked = false;
                    isSecondPicked = true;
                    isThirdPicked = false;
                    setState(() {});
                  },
                  isPicked: isSecondPicked,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 2),
                  ),
                ),
                PickUpPriceContainer(
                  price: '₽ 7 500',
                  label: 'Премиум',
                  onTap: () {
                    isFirstPicked = false;
                    isSecondPicked = false;
                    isThirdPicked = true;
                    setState(() {});
                  },
                  isPicked: isThirdPicked,
                ),
              ],
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
