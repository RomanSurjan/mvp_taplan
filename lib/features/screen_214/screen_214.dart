import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_state.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_event.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_state.dart';
import 'package:mvp_taplan/features/screen_15/screen_15.dart';
import 'package:mvp_taplan/features/screen_211/screen_211.dart';
import 'package:mvp_taplan/features/screen_213/screen_213.dart';
import 'package:mvp_taplan/features/screen_215/screen_215.dart';
import 'package:mvp_taplan/features/screen_28/screen_28.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

part 'pickup_date.dart';

part 'pickup_price.dart';

class Screen214 extends StatefulWidget {
  final MvpPresentModel? currentModel;

  const Screen214({
    super.key,
    this.currentModel,
  });

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
      appBarLabel: 'Покупка подарка\nсамостоятельно',
      child: BlocBuilder<DateTimeBloc, DateTimeState>(
        builder: (context, state) {
          return BlocBuilder<WishListBloc, WishListState>(
            builder: (context, wishListState) {
              if (wishListState.wishList.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(context, 20),
                    vertical: getHeight(context, 150),
                  ),
                  child: const CircularProgressIndicator(
                    color: AppTheme.mainGreenColor,
                  ),
                );
              }

              final flowerModel =
                  wishListState.wishList.where((element) => element.id == 6).toList()[0];

              final currentModel = widget.currentModel ?? flowerModel;

              final postcardBloc = context.read<PostcardBloc>();

              context.read<WishListBloc>().add(
                    GetDataOfCurrentModel(
                      currentModel: currentModel,
                    ),
                  );

              if (wishListState.currentInfo == null) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(context, 20),
                    vertical: getHeight(context, 150),
                  ),
                  child: const CircularProgressIndicator(
                    color: AppTheme.mainGreenColor,
                  ),
                );
              }

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
                                  ? wishListState.currentInfo!.firstPhoto
                                  : isSecondPicked
                                      ? wishListState.currentInfo!.secondPhoto
                                      : wishListState.currentInfo!.thirdPhoto) ??
                              wishListState.currentModel!.smallImage,
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
                        color: const Color.fromRGBO(240, 247, 254, 1),
                        fontSize: getHeight(context, 16),
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
                          label: currentModel.id == 4
                              ? postcardBloc.state.mapOfEvents['День рождения']![0]
                              : state.date.isEmpty
                                  ? 'Дата вручения'
                                  : state.date,
                          dateIsPicked: state.date.isEmpty,
                          onTap: () {
                            if (currentModel.id != 4) {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (_) => const Screen28()));
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getWidth(context, 7),
                          ),
                        ),
                        PickUpDate(
                          label: currentModel.id == 4
                              ? postcardBloc.state.mapOfEvents['День рождения']![1]
                              : state.time.isEmpty
                                  ? 'Время вручения'
                                  : state.time,
                          dateIsPicked: state.time.isEmpty,
                          onTap: () {
                            if (currentModel.id != 4) {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (_) => const Screen211()));
                            }
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
                          price: '₽ ${wishListState.currentInfo!.thirdValue}',
                          label: wishListState.currentInfo!.thirdGrade,
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
                          price: '₽ ${wishListState.currentInfo!.secondValue}',
                          label: wishListState.currentInfo!.secondGrade,
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
                          price: '₽ ${wishListState.currentInfo!.firstValue}',
                          label: wishListState.currentInfo!.firstGrade,
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
                    SizedBox(height: getHeight(context, 48)),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: getHeight(context, 16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MvpGradientButton(
                            label: 'Написать\nпожелание',
                            gradient: AppTheme.mainPurpleGradient,
                            width: getWidth(context, 109),
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (_) => const Screen213()));
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
                            label: 'Купить подарок\nсовместно',
                            gradient: AppTheme.mainGreenGradient,
                            width: getWidth(context, 109),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Screen215(
                                    currentModel: widget.currentModel ?? flowerModel,
                                    currentInfo: wishListState.currentInfo!,
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
}
