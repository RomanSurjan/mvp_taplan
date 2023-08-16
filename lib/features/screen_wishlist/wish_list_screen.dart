import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_event.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_state.dart';
import 'package:mvp_taplan/features/screen_214/screen_214.dart';
import 'package:mvp_taplan/features/screen_215/screen_215.dart';

import 'package:mvp_taplan/features/screen_34/present_screen.dart';
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

            return Column(
              children: [
                PresentWidget(
                  pathToImage: state.currentModel!.bigImage,
                  callback: () {},
                  collected: state.currentModel!.alreadyGet,
                  total: state.currentModel!.fullPrice,
                  isTop: true,
                  height: getHeight(context, 226),
                  width: getWidth(context, 329),
                ),
                SizedBox(height: getHeight(context, 8)),
                Text(
                  state.currentModel!.label,
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
                        if (state.currentModel!.id == 4) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const PresentScreen(buyingOption: BuyingOption.buyTogether),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Screen215(
                                currentModel: state.currentModel!,
                                currentInfo: state.currentInfo!,
                              ),
                            ),
                          );
                        }
                      },
                      label: "Купить подарок\nза компанию",
                      gradient: AppTheme.purpleButtonGradientColor,
                      width: getWidth(context, 160),
                    ),
                    MvpGradientButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Screen214(
                                      currentModel: state.currentModel!,
                                      currentInfo: state.currentInfo!,
                                    )));
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
                      pathToImage: state.wishList[1].smallImage,
                      callback: () {
                        context.read<WishListBloc>().add(SwapModelsEvent(index: 1));
                      },
                      collected: state.wishList[1].alreadyGet,
                      total: state.wishList[1].fullPrice,
                      isTop: false,
                      height: getHeight(context, 160),
                      width: getWidth(context, 160),
                    ),
                    PresentWidget(
                      pathToImage: state.wishList[2].smallImage,
                      callback: () {
                        context.read<WishListBloc>().add(SwapModelsEvent(index: 2));
                      },
                      collected: state.wishList[2].alreadyGet,
                      total: state.wishList[2].fullPrice,
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
                      pathToImage: state.wishList[3].smallImage,
                      callback: () {
                        context.read<WishListBloc>().add(SwapModelsEvent(index: 3));
                      },
                      collected: state.wishList[3].alreadyGet,
                      total: state.wishList[3].fullPrice,
                      isTop: false,
                      height: getHeight(context, 160),
                      width: getWidth(context, 160),
                    ),
                    PresentWidget(
                      pathToImage: state.wishList[4].smallImage,
                      callback: () {
                        context.read<WishListBloc>().add(SwapModelsEvent(index: 4));
                      },
                      collected: state.wishList[4].alreadyGet,
                      total: state.wishList[4].fullPrice,
                      isTop: false,
                      height: getHeight(context, 160),
                      width: getWidth(context, 160),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
