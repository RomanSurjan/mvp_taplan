import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_bloc.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_event.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_state.dart';
import 'package:mvp_taplan/features/screen_15/screen_15.dart';
import 'package:mvp_taplan/features/screen_213/screen_213.dart';
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
  final double totalPrice = 6750;


  List<String> prices = ['₽ 9 900', '₽ 7 500', '₽ 5 000', ''];
  List<double> intPrices = [
    9900,
    7500,
    5000,
    100000000,
  ];
  List<String> labels = ['до Делюкс', 'до Премиума', 'до Стандарта', ''];
  List<bool> isPickedMoney = [
    false,
    true,
    false,
    false,
  ];

  void setAdditionalSum(){
    for(int i = 0; i < isPickedMoney.length; i++){
      if(isPickedMoney[i]){
        context.read<BuyTogetherBloc>().add(SetAdditionalSumEvent(additionalSum: intPrices[i] - totalPrice));
      }
    }
  }

  @override
  void initState() {
    super.initState();

    setAdditionalSum();
  }

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Внести часть денег\nна поддарок вскладчину ',
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
            Expanded(
              child: SizedBox(
                height: getHeight(context, 343),
                width: getWidth(context, 343),
                child: Image.asset(
                  'assets/images/image_116.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 10),
              ),
            ),
            Text(
              'Собрано ₽ $totalPrice',
              style: TextLocalStyles.roboto600.copyWith(
                fontSize: 18,
                color: AppTheme.mainGreenColor,
                height: 18.75 / 16,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 4),
              ),
            ),
            MoneyScale(
              firstGrade: intPrices[2],
              secondGrade: intPrices[1],
              thirdGrade: intPrices[0],
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
                      child: isPickedMoney.length - 1 == index
                          ? PickYourMoney(
                              isPicked: isPickedMoney[index],
                            )
                          : null,
                      onTap: () {
                        if (totalPrice < intPrices[index]) {
                          for (int i = 0; i < isPickedMoney.length; i++) {
                            if (i == index) {
                              isPickedMoney[i] = true;
                            } else {
                              isPickedMoney[i] = false;
                            }
                          }
                          if(index + 1 == isPickedMoney.length){
                            context.read<BuyTogetherBloc>().add(SetAdditionalSumEvent(additionalSum: 500));
                          }else{
                            context.read<BuyTogetherBloc>().add(SetAdditionalSumEvent(additionalSum: intPrices[index] - totalPrice));
                          }

                          setState(() {});
                        }
                      },
                    );
                  }),
            ),
            SizedBox(height: getHeight(context, 20)),
            Padding(
              padding: EdgeInsets.only(
                bottom: getHeight(context, 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MvpGradientButton(
                    label: 'Написать\nсообщение',
                    gradient: AppTheme.mainPurpleGradient,
                    width: getWidth(context, 109),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Screen213()));
                    },
                  ),
                  MvpGradientButton(
                    label: 'Внести деньги\nна подарок',
                    gradient: AppTheme.mainGreenGradient,
                    width: getWidth(context, 109),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Screen15()));
                    },
                  ),
                  MvpGradientButton(
                    label: 'Купить подарок\nсамостоятельно',
                    gradient: AppTheme.mainGreenGradient,
                    width: getWidth(context, 109),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Screen214()));
                    },
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
