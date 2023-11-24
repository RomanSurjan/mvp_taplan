import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_bloc.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_event.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/models/sum_to_string.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

part 'pickup_price.dart';

class Screen214Clothes extends StatefulWidget {
  final MvpPresentModel currentModel;

  const Screen214Clothes({
    super.key,
    required this.currentModel,
  });

  @override
  State<Screen214Clothes> createState() => _Screen214ClothesState();
}

class _Screen214ClothesState extends State<Screen214Clothes> {

  bool isFirstPicked = false;
  bool isSecondPicked = true;
  bool isThirdPicked = false;

  final String title = "Комплект одежды от Натальи Головановой";

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

  final List<SizeModel> sizeChart = [
    SizeModel(
      firstCaption: 'RUS',
      secondCaption: 'INT',
      thirdCaption: '38',
      fourthCaption: '43,5',
      firstState: SizeState.opaque,
      secondState: SizeState.opaque,
      thirdState: SizeState.transparent
    ),
    SizeModel(
      firstCaption: 'XS',
      secondCaption: '42/44',
      thirdCaption: '39',
      fourthCaption: '44',
      firstState: SizeState.opaque,
      secondState: SizeState.opaque,
      thirdState: SizeState.transparent
    ),
    SizeModel(
      firstCaption: 'S',
      secondCaption: '44/46',
      thirdCaption: '40',
      fourthCaption: '45',
      firstState: SizeState.selected,
      secondState: SizeState.selected,
      thirdState: SizeState.transparent
    ),
    SizeModel(
      firstCaption: 'M',
      secondCaption: '46/48',
      thirdCaption: '40,5',
      fourthCaption: '46',
      firstState: SizeState.opaque,
      secondState: SizeState.opaque,
      thirdState: SizeState.transparent
    ),
    SizeModel(
      firstCaption: 'L',
      secondCaption: '48/50',
      thirdCaption: '41',
      fourthCaption: '46,5',
      firstState: SizeState.opaque,
      secondState: SizeState.opaque,
      thirdState: SizeState.transparent
    ),
    SizeModel(
      firstCaption: 'XL',
      secondCaption: '50/52',
      thirdCaption: '42',
      fourthCaption: '47',
      firstState: SizeState.opaque,
      secondState: SizeState.opaque,
      thirdState: SizeState.transparent
    ),
    SizeModel(
      firstCaption: 'XXL',
      secondCaption: '52/52',
      thirdCaption: '43',
      fourthCaption: '48',
      firstState: SizeState.transparent,
      secondState: SizeState.transparent,
      thirdState: SizeState.transparent
    ),
  ];

  @override
  void initState() {
    super.initState();

    context
        .read<BuyTogetherBloc>()
        .add(SetAdditionalSumEvent(additionalSum: widget.currentModel.gradeValueSecond));
  }

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Покупка для себя,\nпросьба или подарок',
      child: BlocBuilder<DateTimeBloc, DateTimeState>(
        builder: (context, state) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {

              final bool isPortraitOrientation =
              ((MediaQuery.of(context).size.height / MediaQuery.of(context).size.width) >
                  1.856);

              final double columnWidth = (isPortraitOrientation)
                  ? MediaQuery.of(context).size.width
                  : (MediaQuery.of(context).size.height / 1.856);
              // final double investedSumPercentage = (investedSum / totalSum * 100);
              // final double cardWight = (columnWidth - 16) / 3;
              // final double cardHeight = cardWight / 114 * 161;
              final buttonSize = columnWidth / 375 * 62;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    width: columnWidth,
                    child: Column(
                      children: [
                        SizedBox(
                            height: columnWidth - 32,
                            width: columnWidth - 32,
                            child: Image.network(
                              (isFirstPicked
                                  ? widget.currentModel.gradePhotoThird
                                  : isSecondPicked
                                      ? widget.currentModel.gradePhotoSecond
                                      : widget.currentModel.gradePhotoFirst) ??
                                          widget.currentModel.smallImage,
                              fit: BoxFit.cover,
                            ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(themeState.isDark ? 0xFFFFFFFF : 0xFF161A1D),
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizeRow(
                          sizeList: sizeChart,
                          onTap: (){},
                          width: columnWidth,
                          themeState: themeState
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: [
                            PickUpPriceContainer(
                              price: '₽ ${sumToString(widget.currentModel.gradeValueThird)}',
                              label: widget.currentModel.gradeNameThird,
                              onTap: () {
                                isFirstPicked = true;
                                isSecondPicked = false;
                                isThirdPicked = false;
                                context.read<BuyTogetherBloc>().add(SetAdditionalSumEvent(
                                  additionalSum: widget.currentModel.gradeValueThird
                                ));
                                setState(() {});
                              },
                              isPicked: isFirstPicked,
                            ),
                            const SizedBox(height: 2),
                            PickUpPriceContainer(
                              price: '₽ ${sumToString(widget.currentModel.gradeValueSecond)}',
                              label: widget.currentModel.gradeNameSecond,
                              onTap: () {
                                isFirstPicked = false;
                                isSecondPicked = true;
                                isThirdPicked = false;
                                context.read<BuyTogetherBloc>().add(SetAdditionalSumEvent(
                                  additionalSum: widget.currentModel.gradeValueSecond)
                                );
                                setState(() {});
                              },
                              isPicked: isSecondPicked,
                            ),
                            const SizedBox(height: 2),
                            PickUpPriceContainer(
                              price: '₽ ${sumToString(widget.currentModel.gradeValueFirst)}',
                              label: widget.currentModel.gradeNameFirst,
                              onTap: () {
                                isFirstPicked = false;
                                isSecondPicked = false;
                                isThirdPicked = true;
                                context.read<BuyTogetherBloc>().add(SetAdditionalSumEvent(
                                  additionalSum: widget.currentModel.gradeValueFirst)
                                );
                                setState(() {});
                              },
                              isPicked: isThirdPicked,
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
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
                        const SizedBox(height: 15)
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class SizeRow extends StatelessWidget {
  final List<SizeModel> sizeList;
  final VoidCallback? onTap;
  final double width;
  final ThemeState themeState;

  const SizeRow({
    super.key,
    required this.sizeList,
    required this.onTap,
    required this.width,
    required this.themeState
  });

  @override
  Widget build(BuildContext context) {

    final double buttonWidth1 = width / 375 * 43; // 43*44 40*44 40*21 8 2
    final double buttonWidth2 = 280 / sizeList.length;
    final double buttonHeight1 = width / 375 * 44;
    final double buttonHeight2 = width / 375 * 22;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizeRowButton(
              type: SizeButtonType.icon,
              icon: 'assets/images/clothes.png',
              width: buttonWidth1,
              height: buttonHeight1,
              onTap: (){},
              state: SizeState.opaque,
              themeState: themeState
            ),
            for (int i = 0; i < sizeList.length; i++) SizeRowButton(
              type: SizeButtonType.twoLined,
              caption: sizeList[i].firstCaption,
              secondCaption: sizeList[i].secondCaption,
              width: buttonWidth2,
              height: buttonHeight1,
              onTap: (){},
              state: sizeList[i].firstState,
              themeState: themeState
            )
          ]
        ),
        SizedBox(
          height: (width / 375 * 8)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizeRowButton(
              type: SizeButtonType.icon,
              icon: 'assets/images/shoes.png',
              width: buttonWidth1,
              height: buttonHeight1,
              onTap: (){},
              state: SizeState.opaque,
              themeState: themeState
            ),
            for (int i = 0; i < sizeList.length; i++) Column(
              children: [
                SizeRowButton(
                  type: SizeButtonType.oneLined,
                  caption: sizeList[i].thirdCaption,
                  width: buttonWidth2,
                  height: buttonHeight2,
                  onTap: (){},
                  state: sizeList[i].secondState,
                  themeState: themeState
                ),
                SizedBox(height: (width / 375 * 2)),
                SizeRowButton(
                  type: SizeButtonType.oneLined,
                  caption: sizeList[i].fourthCaption,
                  width: buttonWidth2,
                  height: buttonHeight2,
                  onTap: (){},
                  state: sizeList[i].thirdState,
                  themeState: themeState
                )
              ]
            )
          ]
        )
      ]
    );
  }
}

class SizeRowButton extends StatelessWidget {

  final String caption;
  final String secondCaption;
  final String icon;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final SizeState state;
  final SizeButtonType type;
  final ThemeState themeState;

  const SizeRowButton({
    super.key,
    this.caption = "",
    this.secondCaption = "",
    this.icon = "",
    required this.width,
    required this.height,
    required this.onTap,
    required this.state,
    required this.type,
    required this.themeState
  });

  @override
  Widget build(BuildContext context) {
    double transparency = 0;
    Color textColor = Color(themeState.isDark ? 0xFFFFFFFF : 0xFF161A1D);
    switch(state){
      case SizeState.selected:
        transparency = 0.65;
        break;
      case SizeState.opaque:
        transparency = 0.3;
        textColor = Color(themeState.isDark ? 0xFFFFFFFF : 0xFF161A1D).withOpacity(0.75);
        break;
      case SizeState.transparent:
        transparency = 0.1;
        textColor = Color(themeState.isDark ? 0xFFFFFFFF : 0xFF161A1D).withOpacity(0.5);
        break;
    }
    return InkWell(
      onTap: () {onTap?.call();},
      child: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(98, 198, 170, transparency),
                Color.fromRGBO(68, 168, 140, transparency)
              ]
            ),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color.fromRGBO(82, 182, 154, 1),
              width: 1,
            )
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if (type == SizeButtonType.icon) Center(
                child: SizedBox(
                  width: width / 43 * 33,
                  height: height / 44 * 40,
                  child: Image.asset(
                    icon,
                    fit: BoxFit.fitWidth,
                    // allowDrawingOutsideViewBox: true,
                    color: const Color(0xFF000000),
                    //   BlendMode.clear
                    // ),
                  )
                )
              ),
              if (type == SizeButtonType.twoLined) Center(
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    Text(
                      caption,
                      style: TextStyle(
                        fontSize: 15,
                        color: textColor,
                        fontWeight: FontWeight.w300
                      )
                    ),
                    Text(
                      secondCaption,
                      style: TextStyle(
                        fontSize: 13,
                        color: textColor,
                        fontWeight: FontWeight.w300
                      )
                    ),
                    const Expanded(child: SizedBox())
                  ]
                )
              ),
              if (type == SizeButtonType.oneLined) Center(
                child: Text(
                  caption,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w400
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}

class SizeModel{

  final String firstCaption;
  final String secondCaption;
  final String thirdCaption;
  final String fourthCaption;
  final SizeState firstState;
  final SizeState secondState;
  final SizeState thirdState;


  SizeModel({
    required this.firstCaption,
    required this.secondCaption,
    required this.thirdCaption,
    required this.fourthCaption,
    required this.firstState,
    required this.secondState,
    required this.thirdState
  });

}

enum SizeState {selected, opaque, transparent}

enum SizeButtonType {icon, oneLined, twoLined}

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