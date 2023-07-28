import 'package:flutter/material.dart';

import 'package:mvp_taplan/features/screen_34/present_screen.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_widget.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  WishListScreenState createState() => WishListScreenState();
}

class WishListScreenState extends State<WishListScreen> {
  void goToPresentScreen(BuyingOption buyingOption) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PresentScreen(
            buyingOption: buyingOption,
            imagePath: presentModels[0].bigImage,
          );
        },
      ),
    );
  }

  List<MvpPresentModel> presentModels = [
    MvpPresentModel(
      bigImage: 'assets/images/audi_big.png',
      smallImage: 'assets/images/audi_small.png',
      label: 'Новая розовая Audi A5 Sportback 40 TFSI',
      fullPrice: 7630000,
      alreadyGet: 1936525,
    ),
    MvpPresentModel(
      bigImage: 'assets/images/coffee_big.png',
      smallImage: 'assets/images/coffee_small.png',
      label: 'Coffee-week',
      fullPrice: 3500,
      alreadyGet: 1580,
    ),
    MvpPresentModel(
      bigImage: 'assets/images/bouquete_big.png',
      smallImage: 'assets/images/bouquete_small.png',
      label: 'Авторский букет цветов',
      fullPrice: 12500,
      alreadyGet: 8750,
    ),
    MvpPresentModel(
      bigImage: 'assets/images/dress_big.png',
      smallImage: 'assets/images/dress_small.png',
      label: 'Платье',
      fullPrice: 10000,
      alreadyGet: 6920,
    ),
    MvpPresentModel(
      bigImage: 'assets/images/jewerly_big.png',
      smallImage: 'assets/images/jewerly_small.png',
      label: 'Золотые серьги-гвоздики с бриллиантами',
      fullPrice: 29500,
      alreadyGet: 19365,
    ),
  ];

  final String firstScreenName = "Мой список\nжеланных подарков";

  late MvpPresentModel additionalModel;

  @override
  void initState() {
    super.initState();

    additionalModel = presentModels[0];
  }

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: firstScreenName,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 24)),
        child: Column(
          children: [
            PresentWidget(
              pathToImage: presentModels[0].bigImage,
              callback: () {},
              collected: presentModels[0].alreadyGet,
              total: presentModels[0].fullPrice,
              isTop: true,
              height: getHeight(context, 226),
              width: getWidth(context, 329),
            ),
            SizedBox(height: getHeight(context, 8)),
            Text(
              presentModels[0].label,
              style: TextLocalStyles.roboto600.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: getHeight(context, 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MvpGradientButton(
                  onTap: () {
                    goToPresentScreen(BuyingOption.buyTogether);
                  },
                  label: "Купить подарок\nза компанию",
                  gradient: AppTheme.purpleButtonGradientColor,
                  width: getWidth(context, 160),
                ),
                MvpGradientButton(
                  onTap: () {
                    goToPresentScreen(BuyingOption.buyAlone);
                  },
                  label: "Купить подарок\nсамостоятельно",
                  gradient: AppTheme.greenButtonGradientColor,
                  width: getWidth(context, 160),
                ),
              ],
            ),
            SizedBox(height: getHeight(context, 18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PresentWidget(
                  pathToImage: presentModels[1].smallImage,
                  callback: () {
                    swapModels(1);
                    setState(() {});
                  },
                  collected: presentModels[1].alreadyGet,
                  total: presentModels[1].fullPrice,
                  isTop: false,
                  height: getHeight(context, 160),
                  width: getWidth(context, 160),
                ),
                PresentWidget(
                  pathToImage: presentModels[2].smallImage,
                  callback: () {
                    swapModels(2);
                    setState(() {});
                  },
                  collected: presentModels[2].alreadyGet,
                  total: presentModels[2].fullPrice,
                  isTop: false,
                  height: getHeight(context, 160),
                  width: getWidth(context, 160),
                ),
              ],
            ),
            SizedBox(height: getHeight(context, 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PresentWidget(
                  pathToImage: presentModels[3].smallImage,
                  callback: () {
                    swapModels(3);
                    setState(() {});
                  },
                  collected: presentModels[3].alreadyGet,
                  total: presentModels[3].fullPrice,
                  isTop: false,
                  height: getHeight(context, 160),
                  width: getWidth(context, 160),
                ),
                PresentWidget(
                  pathToImage: presentModels[4].smallImage,
                  callback: () {
                    swapModels(4);
                    setState(() {});
                  },
                  collected: presentModels[4].alreadyGet,
                  total: presentModels[4].fullPrice,
                  isTop: false,
                  height: getHeight(context, 160),
                  width: getWidth(context, 160),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void swapModels(int i){
    additionalModel = presentModels[0];
    presentModels[0] = presentModels[i];
    presentModels[i] = additionalModel;
  }
}
