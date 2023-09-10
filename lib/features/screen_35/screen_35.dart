import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_bloc.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_state.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_state.dart';
import 'package:mvp_taplan/features/screen_35/buttons_for_categories.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen35 extends StatefulWidget {
  const Screen35({Key? key}) : super(key: key);

  @override
  State<Screen35> createState() => _Screen35State();
}

class _Screen35State extends State<Screen35> {

  static const List<String> iconsForButtons = [
    'assets/svg/bouquete.svg',
    'assets/svg/jewerly.svg',
    'assets/svg/picture.svg',
    'assets/svg/photos.svg',
    'assets/svg/sculpture.svg',
  ];

  static const List<String> namesOfButtons = [
    "Авторские\nбукеты",
    'Ювелирные\nукрашение',
    'Картины\nхудожников',
    'Авторские\nфотографии',
    'Скульптура\nи декор',
  ];

  int catNumber = 1;

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Список желанных подарков',
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context,themeState) {
          return BlocBuilder<ShowcaseBloc, ShowcaseState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context, 16),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: getHeight(context, 17),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: getHeight(context, 54),
                          width: getHeight(context, 54),
                          child: const DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/img.png'),
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        SizedBox(width: getWidth(context, 8)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Наталья Фадеева',
                              style: TextLocalStyles.roboto500.copyWith(
                                color: themeState.presentScreenLabelColor,
                                height: 16.41 / 14,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Ближайший праздник',
                              style: TextLocalStyles.roboto600.copyWith(
                                color: themeState.birthdayLabelShowcase,
                                height: 16.41 / 14,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'День рождения',
                              style: TextLocalStyles.roboto400.copyWith(
                                color: themeState.birthdayLabelShowcase,
                                height: 14.06 / 12,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '30.06 (27+ дней)',
                              style: TextLocalStyles.roboto400.copyWith(
                                color: themeState.secondaryTextColorShowcase,
                                height: 14.06 / 12,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: (){
                            //context.read<ShowcaseBloc>().add(GetShowcaseCardsEvent(2));
                            //catNumber = 0;
                            //setState(() {});
                          },
                          child: SizedBox(
                            width: getWidth(context, 114),
                            height: getHeight(context, 46),
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
                              child: Center(
                                child: Text(
                                  'Желанные\nбукеты',
                                  style: TextLocalStyles.roboto500.copyWith(
                                    color: const Color.fromRGBO(82, 182, 154, 1),
                                    fontSize: 14,
                                    height: 16.41 / 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 16),
                    ),
                    Column(
                      children: [
                        for (int i = 0; i < 3; i++) ...[
                          Row(
                            children: [
                              for (int j = 0; j < 3; j++) ...[
                                SizedBox(
                                  width: getWidth(context, 114),
                                  height: getHeight(context, 128),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          state.listOfCards[i * 3 + j].photo,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: state.listOfCards[i * 3 + j].boughtEarly
                                          ? boughtEarly(context)
                                          : state.listOfCards[i * 3 + j].groupPurchase
                                              ? groupBuy(context)
                                              : state.listOfCards[i * 3 + j].deliver
                                                  ? deliver(context)
                                                  : null,
                                    ),
                                  ),
                                ),
                                if ((i * 3 + j) % 3 != 2)
                                  SizedBox(
                                    width: getWidth(context, 2),
                                  )
                              ],
                            ],
                          ),
                          SizedBox(height: getHeight(context, 2)),
                        ]
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 65),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for(int i = 0; i< iconsForButtons.length; i++)
                        ButtonGroup(
                          colorMain: const Color.fromRGBO(163, 153, 210, 1),
                          picture: iconsForButtons[i],
                          text: namesOfButtons[i],
                          isPressed: catNumber - 1 == i,
                          onTap: () {},
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          );
        }
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
