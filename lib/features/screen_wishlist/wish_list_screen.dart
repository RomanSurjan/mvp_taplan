import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_bloc.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_event.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_event.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_state.dart';
import 'package:mvp_taplan/features/screen_214/screen_214.dart';
import 'package:mvp_taplan/features/screen_215/screen_215.dart';

import 'package:mvp_taplan/features/screen_34/present_screen.dart';
import 'package:mvp_taplan/features/screen_35/screen_35.dart';
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
  final String firstScreenName = "Мой список\nжеланных подарков";

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: firstScreenName,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 24)),
        child: BlocBuilder<WishListBloc, WishListState>(
          builder: (context, state) {
            if (state.currentModel == null) return const SizedBox.shrink();

            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                return Column(
                  children: [
                    PresentWidget(
                      callback: () {},
                      isTop: true,
                      height: getHeight(context, 226),
                      width: getWidth(context, 329),
                      currentModel: state.currentModel!,
                    ),
                    SizedBox(height: getHeight(context, 8)),
                    Text(
                      state.currentModel!.label,
                      style: TextLocalStyles.roboto600.copyWith(
                        color: themeState.appBarTextColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: getHeight(context, 8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MvpGradientButton(
                          opacity: context.watch<ThemeBloc>().state.isDark ? 0.25 : 0.15,
                          onTap: () {
                            if (state.currentModel!.id == 4) {
                              context.read<PostcardBloc>().add(
                                  ChangeHolidayTypeEvent(currentHolidayType: HolidayType.birthday));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const PresentScreen(buyingOption: BuyingOption.buyTogether),
                                ),
                              );
                            } else {
                              context.read<PostcardBloc>().add(
                                  ChangeHolidayTypeEvent(currentHolidayType: HolidayType.just));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Screen215(
                                    currentModel: state.currentModel!,
                                  ),
                                ),
                              );
                            }
                          },
                          label: "Купить в\nскладчину",
                          gradient: AppTheme.purpleButtonGradientColor,
                          width: getWidth(context, 105),
                        ),
                        MvpGradientButton(
                          opacity: context.watch<ThemeBloc>().state.isDark ? 0.35 : 0.25,
                          onTap: () {
                            if (state.currentModel!.id == 4) {
                              context.read<PostcardBloc>().add(
                                  ChangeHolidayTypeEvent(currentHolidayType: HolidayType.birthday));
                            } else {
                              context.read<PostcardBloc>().add(
                                  ChangeHolidayTypeEvent(currentHolidayType: HolidayType.just));
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Screen214(
                                  currentModel: state.currentModel!,
                                ),
                              ),
                            );
                          },
                          label: "Выкупить\nи подарить ",
                          gradient: AppTheme.greenButtonGradientColor,
                          width: getWidth(context, 105),
                        ),
                        MvpGradientButton(
                          opacity: context.watch<ThemeBloc>().state.isDark ? 0.25 : 0.15,
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) => const Screen35()));
                          },
                          label: "Выбрать свой\nподарок",
                          gradient: AppTheme.greenButtonGradientColor,
                          width: getWidth(context, 105),
                        ),
                      ],
                    ),
                    SizedBox(height: getHeight(context, 18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PresentWidget(
                          callback: () {
                            context.read<WishListBloc>().add(SwapModelsEvent(index: 1));
                          },
                          isTop: false,
                          height: getHeight(context, 160),
                          width: getWidth(context, 160),
                          currentModel: state.wishList[1],
                        ),
                        PresentWidget(
                          callback: () {
                            context.read<WishListBloc>().add(SwapModelsEvent(index: 2));
                          },
                          isTop: false,
                          height: getHeight(context, 160),
                          width: getWidth(context, 160),
                          currentModel: state.wishList[2],
                        ),
                      ],
                    ),
                    SizedBox(height: getHeight(context, 8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PresentWidget(
                          callback: () {
                            context.read<WishListBloc>().add(SwapModelsEvent(index: 3));
                          },
                          isTop: false,
                          height: getHeight(context, 160),
                          width: getWidth(context, 160),
                          currentModel: state.wishList[3],
                        ),
                        PresentWidget(
                          callback: () {
                            context.read<WishListBloc>().add(SwapModelsEvent(index: 4));
                          },
                          isTop: false,
                          height: getHeight(context, 160),
                          width: getWidth(context, 160),
                          currentModel: state.wishList[4],
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
