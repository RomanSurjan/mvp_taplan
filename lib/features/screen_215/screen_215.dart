import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_bloc.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_event.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_state.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_15/screen_15.dart';
import 'package:mvp_taplan/features/screen_213/screen_213.dart';
import 'package:mvp_taplan/features/screen_214/screen_214.dart';
import 'package:mvp_taplan/features/screen_39/screen_39.dart';
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

  const Screen215({
    super.key,
    required this.currentModel,
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
      'до ${widget.currentModel.gradeNameThird}',
      'до ${widget.currentModel.gradeNameSecond}',
      'до ${widget.currentModel.gradeNameFirst}',
      ''
    ];
    prices = [
      widget.currentModel.gradeValueThird,
      widget.currentModel.gradeValueSecond,
      widget.currentModel.gradeValueFirst,
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
      appBarLabel: 'Внести часть средств\nна подарок за компанию',
      child: BlocBuilder<BuyTogetherBloc, BuyTogetherState>(
        builder: (context, state) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
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
                    Stack(
                      children: [
                        SizedBox(
                          height: getHeight(context, 343),
                          width: getWidth(context, 343),
                          child: Image.network(
                            (isPickedMoney[0]
                                    ? widget.currentModel.gradePhotoThird
                                    : isPickedMoney[1]
                                        ? widget.currentModel.gradePhotoSecond
                                        : widget.currentModel.gradePhotoFirst) ??
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
                      firstGrade: widget.currentModel.gradeValueFirst,
                      secondGrade: widget.currentModel.gradeValueSecond,
                      thirdGrade: widget.currentModel.gradeValueThird,
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
                            opacity: themeState.isDark ? 0.25 : 0.15,
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
                                  ),
                                ),
                              );
                            },
                          ),
                          MvpGradientButton(
                            opacity: themeState.isDark ? 0.35 : 0.25,
                            label: 'Внести деньги\nна подарок',
                            gradient: AppTheme.mainGreenGradient,
                            width: getWidth(context, 109),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Screen15(
                                    currentModel: widget.currentModel,
                                  ),
                                ),
                              );
                            },
                          ),
                          MvpGradientButton(
                            opacity: themeState.isDark ? 0.25 : 0.15,
                            label: 'Купить подарок\nсамостоятельно',
                            gradient: AppTheme.mainGreenGradient,
                            width: getWidth(context, 109),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Screen214(
                                    currentModel: widget.currentModel,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
