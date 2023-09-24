import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_bloc.dart';
import 'package:mvp_taplan/blocs/additional_sum_bloc/buy_together_event.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_15/screen_15.dart';
import 'package:mvp_taplan/features/screen_211/screen_211.dart';
import 'package:mvp_taplan/features/screen_213/screen_213.dart';
import 'package:mvp_taplan/features/screen_215/screen_215.dart';
import 'package:mvp_taplan/features/screen_28/screen_28.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/models/sum_to_string.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

part 'pickup_date.dart';

part 'pickup_price.dart';

class Screen214 extends StatefulWidget {
  final MvpPresentModel currentModel;

  const Screen214({
    super.key,
    required this.currentModel,
  });

  @override
  State<Screen214> createState() => _Screen214State();
}

class _Screen214State extends State<Screen214> {
  bool isFirstPicked = false;
  bool isSecondPicked = true;
  bool isThirdPicked = false;

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
      appBarLabel: 'Покупка подарка\nсамостоятельно',
      child: BlocBuilder<DateTimeBloc, DateTimeState>(
        builder: (context, state) {

          return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
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
                        (isFirstPicked
                                ? widget.currentModel.gradePhotoThird
                                : isSecondPicked
                                    ? widget.currentModel.gradePhotoSecond
                                    : widget.currentModel.gradePhotoFirst) ??
                            widget.currentModel.smallImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: getHeight(context, 16),
                    ),
                  ),
                  Text(
                    "Дата и время вручения подарка",
                    style: TextLocalStyles.roboto400.copyWith(
                      color: themeState.soloBuyTextColor,
                      fontSize: getHeight(context, 18),
                      height: 16.41 / 14,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: getHeight(context, 4),
                    ),
                  ),
                  Row(
                    children: [
                      PickUpDate(
                        label: state.date.isEmpty ? 'Дата вручения' : state.date,
                        dateIsPicked: state.date.isEmpty,
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => const Screen28()));
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getWidth(context, 7),
                        ),
                      ),
                      PickUpDate(
                        label: state.time.isEmpty ? 'Время вручения' : state.time,
                        dateIsPicked: state.time.isEmpty,
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => const Screen211()));
                        },
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
                        price: '₽ ${sumToString(widget.currentModel.gradeValueThird)}',
                        label: widget.currentModel.gradeNameThird,
                        onTap: () {
                          isFirstPicked = true;
                          isSecondPicked = false;
                          isThirdPicked = false;
                          context.read<BuyTogetherBloc>().add(SetAdditionalSumEvent(
                              additionalSum: widget.currentModel.gradeValueThird));
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
                        price: '₽ ${sumToString(widget.currentModel.gradeValueSecond)}',
                        label: widget.currentModel.gradeNameSecond,
                        onTap: () {
                          isFirstPicked = false;
                          isSecondPicked = true;
                          isThirdPicked = false;
                          context.read<BuyTogetherBloc>().add(SetAdditionalSumEvent(
                              additionalSum: widget.currentModel.gradeValueSecond));
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
                        price: '₽ ${sumToString(widget.currentModel.gradeValueFirst)}',
                        label: widget.currentModel.gradeNameFirst,
                        onTap: () {
                          isFirstPicked = false;
                          isSecondPicked = false;
                          isThirdPicked = true;
                          context.read<BuyTogetherBloc>().add(SetAdditionalSumEvent(
                              additionalSum: widget.currentModel.gradeValueFirst));
                          setState(() {});
                        },
                        isPicked: isThirdPicked,
                      ),
                    ],
                  ),
                  SizedBox(height: getHeight(context, 48)),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: getHeight(context, 16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MvpGradientButton(
                          label: 'Подписать\nпожелание',
                          gradient: AppTheme.mainPurpleGradient,
                          width: getWidth(context, 109),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Screen213(
                                  additionalSum: isFirstPicked
                                      ? widget.currentModel.gradeValueFirst
                                      : isSecondPicked
                                          ? widget.currentModel.gradeValueSecond
                                          : widget.currentModel.gradeValueThird,
                                ),
                              ),
                            );
                          },
                        ),
                        MvpGradientButton(
                          opacity: 0.35,
                          label: 'Внести деньги\nна подарок',
                          gradient: AppTheme.mainGreenGradient,
                          width: getWidth(context, 109),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Screen15(
                                          currentModel: widget.currentModel,
                                        )));
                          },
                        ),
                        MvpGradientButton(
                          label: 'Купить подарок\nза компанию',
                          gradient: AppTheme.mainGreenGradient,
                          width: getWidth(context, 109),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Screen215(
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
          });
        },
      ),
    );
  }
}
