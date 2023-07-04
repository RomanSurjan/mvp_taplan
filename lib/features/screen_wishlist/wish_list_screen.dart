import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mvp_taplan/features/screen_34/present_screen.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_widget.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class WishListScreen extends StatefulWidget {

  final String firstScreenName = "Мой список желанных";
  final String secondScreenName = "подарков";

  // ToDo Данные, которые ожидаю от сервера.
  // ToDo Потом надо будет вынести в отдельный класс.
  // Подарок 1
  final String pathToImage1 = 'images/present_1.png';
  final int collectedAmount1 = 22000;
  final int totalAmount1 = 42000; // ToDo нужно проверять, что total больше collected.
  final String presentName = "Новая розовая Audi A5";

  // Подарок 2
  final String pathToImage2 = 'images/present_2.png';
  final int collectedAmount2 = 1920;
  final int totalAmount2 = 3920; // ToDo нужно проверять, что total больше collected.

  // Подарок 3
  final String pathToImage3 = 'images/present_3.png';
  final int collectedAmount3 = 50200;
  final int totalAmount3 = 82200; // ToDo нужно проверять, что total больше collected.

  // Подарок 4
  final String pathToImage4 = 'images/present_2.png';
  final int collectedAmount4 = 1920;
  final int totalAmount4 = 3920; // ToDo нужно проверять, что total больше collected.

  // Подарок 5
  final String pathToImage5 = 'images/present_3.png';
  final int collectedAmount5 = 50200;
  final int totalAmount5 = 82200; // ToDo нужно проверять, что total больше collected.

  const WishListScreen({Key? key}) : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  /// Переход на [PresentScreen].
  void goToPresentScreen(BuyingOption buyingOption) {
    setState(() {
      Navigator.push(
        context, MaterialPageRoute(
          builder: (context) {
            return PresentScreen(buyingOption: buyingOption);
          }
        )
      );
    });
  }

  _WishListScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        callBack: (){},
        name: widget.firstScreenName,
        secondName: widget.secondScreenName
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            // Отступ для поддержки разных соотношений сторон экрана.
            const Expanded(
              flex: 1,
              child: SizedBox(width: 1)
            ),
            PresentWidget(
              pathToImage: widget.pathToImage1,
              callback: (){},
              collected: widget.collectedAmount1,
              total: widget.totalAmount1,
              isTop: true,
            ),
            // Название подарка.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.presentName,
                  style: wishListScreenTextStyle,
                )
              )
            ),
            // Кнопки под подарком.
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: CustomGradientButton(
                    onTap: (){goToPresentScreen(BuyingOption.buyTogether);},
                    caption: "Купить в складчину",
                    gradient: AppTheme.purpleButtonGradientColor,
                  )
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: CustomGradientButton(
                    onTap: (){goToPresentScreen(BuyingOption.buyAlone);},
                    caption: "Выкупить",
                    secondCaption: "и подарить",
                    gradient: AppTheme.greenButtonGradientColor,
                  )
                )
              ]
            ),
            // Отступ для поддержки разных соотношений сторон экрана.
            const Expanded(
              flex: 1,
              child: SizedBox(width: 1)
            ),
            // Первая строка сетки из четырёх подарков.
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: PresentWidget(
                    pathToImage: widget.pathToImage2,
                    callback: (){},
                    collected: widget.collectedAmount2,
                    total: widget.totalAmount2,
                    isTop: false,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: PresentWidget(
                    pathToImage: widget.pathToImage3,
                    callback: (){},
                    collected: widget.collectedAmount3,
                    total: widget.totalAmount3,
                    isTop: false,
                  ),
                ),
              ]
            ),
            // Отступ для поддержки разных соотношений сторон экрана.
            const Expanded(
              flex: 1,
              child: SizedBox(width: 1)
            ),
            // Вторая строка сетки из четырёх подарков.
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: PresentWidget(
                    pathToImage: widget.pathToImage4,
                    callback: (){},
                    collected: widget.collectedAmount4,
                    total: widget.totalAmount4,
                    isTop: false,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: PresentWidget(
                    pathToImage: widget.pathToImage5,
                    callback: (){},
                    collected: widget.collectedAmount5,
                    total: widget.totalAmount5,
                    isTop: false,
                  ),
                ),
              ]
            ),
            // Отступ для поддержки разных соотношений сторон экрана.
            const Expanded(
              flex: 1,
              child: SizedBox(width: 1)
            ),
          ]
        )
      )
    );
  }
}