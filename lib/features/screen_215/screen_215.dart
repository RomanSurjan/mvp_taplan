import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_bloc.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_event.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_state.dart';
import 'package:mvp_taplan/features/screen_15/screen_15.dart';
import 'package:mvp_taplan/features/screen_213/screen_213.dart';
import 'package:mvp_taplan/features/screen_214/mvp_present_data_model.dart';
import 'package:mvp_taplan/features/screen_214/screen_214.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/models/sum_to_string.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

part 'money_scale.dart';

part 'pick_your_money.dart';

part 'pick_your_money_container.dart';

class Screen215 extends StatefulWidget {
  final MvpPresentModel currentModel;
  final MvpPresentDataModel currentInfo;

  const Screen215({
    super.key,
    required this.currentModel,
    required this.currentInfo,
  });

  @override
  State<Screen215> createState() => _Screen215State();
}

class _Screen215State extends State<Screen215> {
  List<int>? prices;

  List<bool> isPickedRow = [
    false,
    false,
    true,
    false,
  ];

  List<int> intPricesRow = [
    100,
    250,
    500,
    1000,
  ];

  List<String>? labels;
  List<bool> isPickedMoney = [
    false,
    false,
    false,
    true,
  ];

  void setLabelsAndPrices() {
    labels = [
      'до ${widget.currentInfo.thirdGrade}',
      'до ${widget.currentInfo.secondGrade}',
      'до ${widget.currentInfo.firstGrade}',
      ''
    ];
    prices = [
      widget.currentInfo.thirdValue,
      widget.currentInfo.secondValue,
      widget.currentInfo.firstValue,
      -100,
    ];

    context.read<BuyTogetherBloc>().add(SetAdditionalSumEvent(additionalSum: 500));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    setLabelsAndPrices();
  }

  @override
  Widget build(BuildContext context) {
    if (labels == null || prices == null) return const SizedBox.shrink();
    return MvpScaffoldModel(
      appBarLabel: 'Внести часть денег\nна подарок вскладчину ',
      child: BlocBuilder<BuyTogetherBloc, BuyTogetherState>(
        builder: (context, state) {
          return Padding(
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
                    child: Image.network(
                      widget.currentModel.smallImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 10),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Собрано ₽ ${sumToString(widget.currentModel.alreadyGet)}',
                      style: TextLocalStyles.roboto600.copyWith(
                        fontSize: 18,
                        color: AppTheme.mainGreenColor,
                        height: 18.75 / 16,
                      ),
                    ),
                    Text(
                      'Внести ₽ ${sumToString(state.additionalSum)}',
                      style: TextLocalStyles.roboto600.copyWith(
                        fontSize: 18,
                        color: const Color.fromRGBO(127, 164, 234, 0.81),
                        height: 18.75 / 16,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 4),
                  ),
                ),
                MoneyScale(
                  firstGrade: widget.currentInfo.firstValue,
                  secondGrade: widget.currentInfo.secondValue,
                  thirdGrade: widget.currentInfo.thirdValue,
                  totalMoney: widget.currentModel.alreadyGet,
                  additionalMoney: state.additionalSum,
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
                        price: '₽ ${sumToString(prices![index])}',
                        label: labels![index],
                        isPicked: isPickedMoney[index],
                        child: isPickedMoney.length - 1 == index
                            ? PickYourMoney(
                                isPicked: isPickedRow,
                                isPickedWidget: isPickedMoney[index],
                                intPrices: intPricesRow,
                              )
                            : null,
                        onTap: () {
                          if (widget.currentModel.alreadyGet < prices![index] ||
                              prices![index] < 0) {
                            for (int i = 0; i < isPickedMoney.length; i++) {
                              if (i == index) {
                                isPickedMoney[i] = true;
                                context.read<BuyTogetherBloc>().add(
                                      SetAdditionalSumEvent(
                                        additionalSum:
                                            prices![index] - widget.currentModel.alreadyGet,
                                      ),
                                    );
                              } else {
                                isPickedMoney[i] = false;
                              }
                            }

                            setState(() {});
                          }
                          if (index + 1 == isPickedMoney.length) {
                            for (int i = 0; i < isPickedRow.length; i++) {
                              if (isPickedRow[i]) {
                                context
                                    .read<BuyTogetherBloc>()
                                    .add(SetAdditionalSumEvent(additionalSum: intPricesRow[i]));
                              }
                            }
                          }
                        },
                      );
                    },
                  ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Screen213(
                                        additionalSum:
                                            context.read<BuyTogetherBloc>().state.additionalSum,
                                      )));
                        },
                      ),
                      MvpGradientButton(
                        label: 'Внести деньги\nна подарок',
                        gradient: AppTheme.mainGreenGradient,
                        width: getWidth(context, 109),
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => const Screen15()));
                        },
                      ),
                      MvpGradientButton(
                        label: 'Купить подарок\nсамостоятельно',
                        gradient: AppTheme.mainGreenGradient,
                        width: getWidth(context, 109),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Screen214(
                                        currentInfo: widget.currentInfo,
                                        currentModel: widget.currentModel,
                                      )));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
