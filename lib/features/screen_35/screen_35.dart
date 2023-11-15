import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_bloc.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_event.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_35/buttons_for_categories.dart';
import 'package:mvp_taplan/features/screen_35/showcase_present_widget.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen35 extends StatefulWidget {
  const Screen35({Key? key}) : super(key: key);

  @override
  State<Screen35> createState() => _Screen35State();
}

class _Screen35State extends State<Screen35> {
  static const List<String> iconsForButtons = [
    'assets/images/button_flower.png',
    'assets/images/button_jewelry.png',
    'assets/images/button_fashion.png',
    'assets/images/button_tour.png',
    'assets/images/button_art.png',
  ];

  static const List<String> namesOfButtons = [
    "Авторские\nбукеты",
    'Ювелирные\nукрашение',
    'Картины\nхудожников',
    'Авторские\nфотографии',
    'Скульптура\nи декор',
  ];

  int catNumber = 5;

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Мой список\nжеланных подарков',
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<ShowcaseBloc, ShowcaseState>(
            builder: (context, state) {
              double investedSum = 0;
              double totalSum = 0;
              for (var i in state.userModel.presents) {
                investedSum += i.invested;
                totalSum += i.total;
              }

              final bool isPortraitOrientation =
                  ((MediaQuery.of(context).size.height / MediaQuery.of(context).size.width) >
                      2.056);

              final double columnWidth = (isPortraitOrientation)
                  ? MediaQuery.of(context).size.width
                  : (MediaQuery.of(context).size.height / 2.056);
              final double investedSumPercentage = (investedSum / totalSum * 100);
              final double cardWight = (columnWidth - 16) / 3;
              final double cardHeight = cardWight / 114 * 161;
              final buttonSize = columnWidth / 375 * 62;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: columnWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              height: 62,
                              width: 62,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/avatar.png'),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                              height: 62,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.userModel.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: themeState.presentScreenLabelColor,
                                    fontSize: 13.8,
                                  ),
                                ),
                                Text(
                                  'Ближайший праздник',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: themeState.birthdayLabelShowcase,//Color(0xFF7FA4EA),
                                    fontSize: 13.5,
                                    // decoration: TextDecoration.underline
                                  ),
                                ),
                                Text(
                                  state.userModel.celebrate.name,
                                  style: TextLocalStyles.roboto400.copyWith(
                                    color: themeState.birthdayLabelShowcase,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '${state.userModel.celebrate.day}.'
                                      '${state.userModel.celebrate.month} '
                                      '(дней до события - '
                                      '${state.userModel.celebrate.countDaysTo}'
                                      ')',
                                  style: TextLocalStyles.roboto400.copyWith(
                                    color: themeState.secondaryTextColorShowcase,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            InkWell(
                              onTap: () {
                                //context.read<ShowcaseBloc>().add(GetShowcaseCardsEvent(2));
                                //catNumber = 0;
                                //setState(() {});
                              },
                              child: SizedBox(
                                width: 62,
                                height: 62,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(98, 198, 170, 0.1),
                                        Color.fromRGBO(68, 168, 140, 0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color.fromRGBO(98, 198, 170, 1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Намекнуть\nо желании',
                                        style: TextLocalStyles.roboto500.copyWith(
                                          color: const Color.fromRGBO(82, 182, 154, 1),
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        child: SvgPicture.asset(
                                          'assets/svg/share.svg',
                                          colorFilter: const ColorFilter.mode(
                                              Color.fromRGBO(82, 182, 154, 1), BlendMode.srcIn),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        const SizedBox(height: 3),
                        Column(
                          children: [
                            for (int i = 0; i < 3; i++) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  for (int j = 0; j < 3; j++) ...[
                                    ShowcasePresentWidget(
                                      callback: () {
                                        context.read<ShowcaseBloc>().add(
                                          GetShowcasePresentInfoEvent(
                                            id: int.tryParse(
                                              state.userModel.presents[i * 3 + j].id
                                            )!,
                                            context: context,
                                          ),
                                        );
                                      },
                                      id: state.userModel.presents[i * 3 + j].id,
                                      photo: state.userModel.presents[i * 3 + j].photo,
                                      video: state.userModel.presents[i * 3 + j].video,
                                      invested: state.userModel.presents[i * 3 + j].invested,
                                      total: state.userModel.presents[i * 3 + j].total,
                                      boughtEarly: state.userModel.presents[i * 3 + j].boughtEarly,
                                      groupPurchase:
                                          state.userModel.presents[i * 3 + j].groupPurchase,
                                      deliver: state.userModel.presents[i * 3 + j].deliver,
                                      likes: state.userModel.presents[i * 3 + j].likes,
                                      liked: state.userModel.presents[i * 3 + j].liked,
                                      comments: state.userModel.presents[i * 3 + j].comments,
                                      height: cardHeight,
                                      width: cardWight,
                                    ),
                                  ],
                                ],
                              ),
                              // const SizedBox(height: 1),
                            ]
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Итого собрано $investedSum (${investedSumPercentage.toStringAsFixed(0)}%)",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFA399D2),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 0; i < iconsForButtons.length; i++)
                              ButtonGroup(
                                colorMain: (catNumber - 1 == i)
                                    ? const Color.fromRGBO(82, 182, 154, 1)
                                    : const Color.fromRGBO(110, 210, 182, 1),
                                picture: iconsForButtons[i],
                                text: namesOfButtons[i],
                                size: buttonSize,
                                isPressed: catNumber - 1 == i,
                                onTap: () {},
                              )
                          ],
                        ),
                        const SizedBox(height: 3),
                        // const Expanded(child: SizedBox()),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget boughtEarly(BuildContext context) {
    return SizedBox(
      width: getWidth(context, 101),
      height: getHeight(context, 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(177, 138, 1, 0.6),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/card_showcase.svg'),
            SizedBox(
              width: getWidth(context, 3),
            ),
            Text(
              'Покупался\nранее',
              style: TextLocalStyles.roboto500.copyWith(
                color: Colors.white,
                fontSize: 12,
                height: 10.8 / 12,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget groupBuy(BuildContext context) {
    return SizedBox(
      width: getWidth(context, 101),
      height: getHeight(context, 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(33, 101, 52, 0.6),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/card_showcase.svg'),
            SizedBox(
              width: getWidth(context, 3),
            ),
            Text(
              'Групповая\nпокупка',
              style: TextLocalStyles.roboto500.copyWith(
                color: Colors.white,
                fontSize: 12,
                height: 10.8 / 12,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget deliver(BuildContext context) {
    return SizedBox(
      width: getWidth(context, 101),
      height: getHeight(context, 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 136, 136, 0.6),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/deliver_showcase.svg'),
            SizedBox(
              width: getWidth(context, 3),
            ),
            Text(
              'Выкуплен\nне вручен',
              style: TextLocalStyles.roboto500.copyWith(
                color: const Color.fromRGBO(14, 14, 14, 1),
                fontSize: 12,
                height: 10.8 / 12,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
