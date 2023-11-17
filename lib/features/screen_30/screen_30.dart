import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:mvp_taplan/blocs/authorization_bloc/authorization_state.dart';
import 'package:mvp_taplan/blocs/cover_bloc/cover_bloc.dart';
import 'package:mvp_taplan/blocs/cover_bloc/cover_event.dart';
import 'package:mvp_taplan/blocs/cover_bloc/cover_state.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_event.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_state.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_bloc.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_event.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_bloc.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_event.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_state.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_bloc.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_event.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_event.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_state.dart';
import 'package:mvp_taplan/features/screen_215/screen_215.dart';
import 'package:mvp_taplan/features/screen_34/present_screen.dart';
import 'package:mvp_taplan/features/screen_wishlist/wish_list_screen.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/models/navigation_bar.dart';
import 'package:mvp_taplan/theme/colors.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class Screen30 extends StatefulWidget {
  final int bloggerId;

  const Screen30({
    super.key,
    required this.bloggerId,
  });

  @override
  Screen30State createState() => Screen30State();
}

class Screen30State extends State<Screen30> {
  var flagForTip = false;

  var isFirst = false;
  bool isTaped = false;
  bool isTapedHome = false;
  late Timer update;
  DateTime range = DateTime(2023);
  bool isTelegram = false;
  List<String> months = ['СЕНТЯБРЬ', 'ОКТЯБРЬ', 'НОЯБРЬ'];

  @override
  void initState() {
    super.initState();

    if(widget.bloggerId != context.read<CoverBloc>().state.bloggerId || context.read<CoverBloc>().state.myDreamDate.isEmpty) {
      //TODO вынести логику в COVERBLOC
      context.read<CoverBloc>().add(GetCoverEvent(bloggerId: widget.bloggerId));
      context.read<DateTimeBloc>().add(SetTimeToStreamEvent(bloggerId: widget.bloggerId));
    }
    context.read<PostcardBloc>().add(GetPostcardsEvent(bloggerId: widget.bloggerId));
    context.read<WishListBloc>().add(GetWishListEvent(bloggerId: widget.bloggerId));
    context.read<ShowcaseBloc>().add(GetShowcaseCardsEvent(bloggerId: widget.bloggerId, cat: 5));
    context.read<JournalBloc>().add(GetJournalContentEvent(bloggerId: widget.bloggerId));
    if (context.read<CoverBloc>().state.myDreamDate.isNotEmpty) {
      String dateBorn = context.read<CoverBloc>().state.myDreamDate;
      DateTime dateOfBorn = DateTime(
        int.parse(dateBorn.substring(0, 4)),
        int.parse(dateBorn.substring(5, 7)),
        int.parse(dateBorn.substring(8, 10)),
        int.parse(dateBorn.substring(11, 13)),
      );
      update = Timer.periodic(
        const Duration(seconds: 1),
            (timer) {
          DateTime nowDate = DateTime.now();
          range = DateTime(
            dateOfBorn.year - nowDate.year,
            dateOfBorn.month - nowDate.month,
            dateOfBorn.day - nowDate.day,
            dateOfBorn.hour - nowDate.hour,
            dateOfBorn.minute - nowDate.minute,
            dateOfBorn.second - nowDate.second,
          );
          if(mounted) {
            setState(() {});
          }
        },
      );
    }

  }

  @override
  void dispose() {
    update.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthorizationBloc, AuthState>(
          builder: (context, authState) {
            return BlocBuilder<DateTimeBloc, DateTimeState>(
              builder: (context, state) {
                if (state.rangeToStream == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.mainGreenColor,
                    ),
                  );
                }

                return BlocBuilder<CoverBloc, CoverState>(
                  builder: (context, coverState) {

                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://qviz.fun${coverState.covers[coverState.currentCoverId][0]}',
                          ),
                          fit: BoxFit.cover,
                          alignment: const Alignment(0.5, -0.66),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SvgPicture.asset('assets/svg/logo_cover.svg', width: getWidth(context, 340),),
                            ),
                          ),
                          Positioned.fill(
                            top: getHeight(context, 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                height: 20,
                                child: Image.network(
                                  'assets/images/sk_logo_light.png',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: getHeight(
                              context,
                              coverState.covers[coverState.currentCoverId][1][0][2],
                            ),
                            right: getWidth(
                              context,
                              coverState.covers[coverState.currentCoverId][1][0][1],
                            ),
                            child: Text(
                              coverState.strWish,
                              style: TextLocalStyles.mono400.copyWith(
                                fontSize: getHeight(context, 31),
                                height: 1,
                                fontWeight: FontWeight.w200,
                                color: coverState.covers[coverState.currentCoverId][1][0][0]
                                            .toString()
                                            .substring(2) ==
                                        '1'
                                    ? const Color.fromRGBO(57, 57, 57, 1)
                                    : const Color.fromRGBO(240, 247, 254, 1),
                              ),
                              textAlign: (coverState.covers[coverState.currentCoverId][1][0][0]
                                              .toString()
                                              .substring(1, 2) ==
                                          '1' ||
                                      coverState.covers[coverState.currentCoverId][1][0][0]
                                              .toString()
                                              .substring(1, 2) ==
                                          '3')
                                  ? TextAlign.left
                                  : coverState.covers[coverState.currentCoverId][1][0][0]
                                              .toString()
                                              .substring(1, 2) ==
                                          '5'
                                      ? TextAlign.center
                                      : TextAlign.right,
                            ),
                          ),
                          Positioned(
                            top: getHeight(
                              context,
                              coverState.covers[coverState.currentCoverId][1][4][1],
                            ),
                            left: getWidth(
                              context,
                              coverState.covers[coverState.currentCoverId][1][4][0],
                            ),
                            child: SizedBox(
                              height: getHeight(context, 48),
                              width: getWidth(context, 41),
                              child: SvgPicture.asset('assets/svg/openmoji_swipe.svg'),
                            ),
                          ),
                          Positioned(
                            top: getHeight(
                              context,
                              coverState.covers[coverState.currentCoverId][1][2][2],
                            ),
                            left: getWidth(
                              context,
                              coverState.covers[coverState.currentCoverId][1][2][1] > 100
                                  ? coverState.covers[coverState.currentCoverId][1][2][1] - 13
                                  : coverState.covers[coverState.currentCoverId][1][2][1],
                            ),
                            child: myDream(
                              context,
                              range,
                            ),
                          ),
                          Positioned(
                            top: getHeight(
                              context,
                              coverState.covers[coverState.currentCoverId][1][3][2],
                            ),
                            left: getWidth(
                                context,
                                coverState.covers[coverState.currentCoverId][1][3][1] > 100
                                    ? coverState.covers[coverState.currentCoverId][1][3][1] - 13
                                    : coverState.covers[coverState.currentCoverId][1][3][1]),
                            child: bouquetOfTheWeek(
                              context,
                              state.rangeToStream!,
                            ),
                          ),
                          Positioned(
                            top: getHeight(
                              context,
                              coverState.covers[coverState.currentCoverId][1][1][2],
                            ),
                            left: getWidth(
                              context,
                              coverState.covers[coverState.currentCoverId][1][1][1],
                            ),
                            child: wishList(context),
                          ),
                          Positioned(
                            bottom: getHeight(context, 100),
                            left: getWidth(context, 27),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coverState.username,
                                  style: TextLocalStyles.roboto400.copyWith(
                                    fontSize: 20,
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  '${coverState.description}\n${coverState.region}',
                                  style: TextLocalStyles.roboto400.copyWith(
                                    fontSize: 15,
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Positioned(
                          //   bottom: getHeight(context, 85),
                          //   left: getWidth(context, 28),
                          //   child: Text(
                          //     '${coverState.description}\n${coverState.region}',
                          //     style: TextLocalStyles.roboto400.copyWith(
                          //       fontSize: 15,
                          //       color: const Color.fromRGBO(255, 255, 255, 1),
                          //     ),
                          //   ),
                          // ),
                          // Positioned(
                          //   bottom: getHeight(context, 91),
                          //   left: getWidth(context, 226),
                          //   child: InkWell(
                          //     onTap: () {
                          //       if (widget.bloggerId == 1) {
                          //         coverState = CoverState(
                          //           myDreamDate: '',
                          //           everyWeekStream: '',
                          //           dreamPresentId: 0,
                          //           weekFlowerId: 0,
                          //           currentCoverId: 0,
                          //           covers: [[]],
                          //           strWish: '',
                          //           telegram: '',
                          //           region: '',
                          //           username: '',
                          //           description: '', bloggerId: 1,
                          //         );
                          //         Navigator.pushReplacementNamed(context, '/nb/journal_2/');
                          //       } else {
                          //         coverState = CoverState(
                          //           myDreamDate: '',
                          //           everyWeekStream: '',
                          //           dreamPresentId: 0,
                          //           weekFlowerId: 0,
                          //           currentCoverId: 0,
                          //           covers: [[]],
                          //           strWish: '',
                          //           telegram: '',
                          //           region: '',
                          //           username: '',
                          //           description: '', bloggerId: 45,
                          //         );
                          //         Navigator.pushReplacementNamed(context, '/nb/journal_1/');
                          //       }
                          //     },
                          //     child: Image.asset('assets/images/image 320.png'),
                          //   ),
                          // ),
                          Positioned(
                            bottom: getHeight(context, 90),
                            right: getWidth(context, 5),
                            child: SizedBox(
                              height: getHeight(context, 47),
                              width: getWidth(context, 109),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1),
                                      child: InkWell(
                                        onTap: () {
                                          if (coverState.currentCoverId != 0) {
                                            context.read<CoverBloc>().add(PrevCoverEvent());
                                          }
                                        },
                                        child: SizedBox(
                                          height: getHeight(context, 45),
                                          width: getWidth(context, 22),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              gradient: AppTheme.mainGreenGradient,
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                            child: coverState.currentCoverId != 0
                                                ? SvgPicture.asset(
                                                    'assets/svg/arrow_back.svg',
                                                    colorFilter: const ColorFilter.mode(
                                                      Color.fromRGBO(193, 184, 237, 1),
                                                      BlendMode.srcIn,
                                                    ),
                                                  )
                                                : RotatedBox(
                                                    quarterTurns: 3,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(right: 5, top: 2),
                                                      child: Text(
                                                        'old',
                                                        style: TextLocalStyles.mono400.copyWith(
                                                          fontSize: 20,
                                                          color:
                                                              const Color.fromRGBO(57, 57, 57, 1),
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${months[coverState.currentCoverId]}\n2023',
                                      style: TextLocalStyles.roboto400.copyWith(
                                        color: const Color.fromRGBO(57, 57, 57, 1),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 1),
                                      child: InkWell(
                                        onTap: () {
                                          if (coverState.currentCoverId !=
                                              (coverState.covers.length - 1)) {
                                            context.read<CoverBloc>().add(NextCoverEvent());
                                          }
                                        },
                                        child: SizedBox(
                                          height: getHeight(context, 45),
                                          width: getWidth(context, 22),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              gradient: AppTheme.mainGreenGradient,
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                            child: coverState.currentCoverId !=
                                                    (coverState.covers.length - 1)
                                                ? RotatedBox(
                                                    quarterTurns: 2,
                                                    child: SvgPicture.asset(
                                                      'assets/svg/arrow_back.svg',
                                                      colorFilter: const ColorFilter.mode(
                                                        Color.fromRGBO(193, 184, 237, 1),
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                  )
                                                : RotatedBox(
                                                    quarterTurns: 3,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(right: 2, top: 2),
                                                      child: Text(
                                                        'new',
                                                        style: TextLocalStyles.mono400.copyWith(
                                                          fontSize: 20,
                                                          color:
                                                              const Color.fromRGBO(57, 57, 57, 1),
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: getWidth(context, 0),
                            child: SizedBox(
                              width: getWidth(context, 375),
                              child: CustomNavigationBar(
                                onTapTelegram: () {
                                  isTelegram = true;
                                  setState(() {});

                                  Timer(
                                    const Duration(seconds: 3),
                                    () {
                                      isTelegram = false;
                                      setState(() {});
                                    },
                                  );
                                },
                                isTelegram: isTelegram,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

Widget bouquetOfTheWeek(BuildContext context, DateTime range) {
  return BlocBuilder<WishListBloc, WishListState>(
    builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Букет\nнедели',
            style: TextLocalStyles.mono400.copyWith(
              fontSize: getHeight(context, 24),
              height: 20.93 / 24,
              color: context
                          .read<CoverBloc>()
                          .state
                          .covers[context.read<CoverBloc>().state.currentCoverId][1][3][0]
                          .toString()
                          .substring(2) ==
                      '1'
                  ? const Color.fromRGBO(57, 57, 57, 1)
                  : const Color.fromRGBO(240, 247, 254, 1),
            ),
            textAlign: context
                        .read<CoverBloc>()
                        .state
                        .covers[context.read<CoverBloc>().state.currentCoverId][1][3][0]
                        .toString()
                        .substring(1, 2) ==
                    '1'
                ? TextAlign.left
                : TextAlign.right,
          ),
          const SizedBox(height: 1),
          Text(
            'Групповой\nподарок к',
            style: TextLocalStyles.mono400.copyWith(
              fontSize: 14,
              height: 12.21 / 14,
              color: context
                          .read<CoverBloc>()
                          .state
                          .covers[context.read<CoverBloc>().state.currentCoverId][1][3][0]
                          .toString()
                          .substring(2) ==
                      '1'
                  ? const Color.fromRGBO(57, 57, 57, 1)
                  : const Color.fromRGBO(240, 247, 254, 1),
            ),
            textAlign: context
                        .read<CoverBloc>()
                        .state
                        .covers[context.read<CoverBloc>().state.currentCoverId][1][3][0]
                        .toString()
                        .substring(1, 2) ==
                    '1'
                ? TextAlign.left
                : TextAlign.right,
          ),
          Text(
            'Периодическому\nстриму ',
            style: TextLocalStyles.mono400.copyWith(
              fontSize: 16,
              height: 13.95 / 16,
              color: context
                          .read<CoverBloc>()
                          .state
                          .covers[context.read<CoverBloc>().state.currentCoverId][1][3][0]
                          .toString()
                          .substring(2) ==
                      '1'
                  ? const Color.fromRGBO(57, 57, 57, 1)
                  : const Color.fromRGBO(240, 247, 254, 1),
            ),
            textAlign: context
                        .read<CoverBloc>()
                        .state
                        .covers[context.read<CoverBloc>().state.currentCoverId][1][3][0]
                        .toString()
                        .substring(1, 2) ==
                    '1'
                ? TextAlign.left
                : TextAlign.right,
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              containerTimer(context, range.day, 'дни'),
              Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
              containerTimer(context, range.hour, 'час'),
              Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
              containerTimer(context, range.minute, 'мин'),
              Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
              containerTimer(context, range.second, 'сек'),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: getHeight(context, 4)),
          ),
          RotatedBox(
            quarterTurns: 2,
            child: InkWell(
              onTap: () {
                final flowerModel = state.wishList.where((element) => element.position == 3).toList()[0];
                context
                    .read<PostcardBloc>()
                    .add(ChangeHolidayTypeEvent(currentHolidayType: HolidayType.stream));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Screen215(
                      currentModel: flowerModel,
                    ),
                  ),
                );
              },
              child: backSpaceButton(
                  context,
                  context
                          .read<CoverBloc>()
                          .state
                          .covers[context.read<CoverBloc>().state.currentCoverId][1][2][0]
                          .toString()
                          .substring(1, 2) ==
                      '2'),
            ),
          ),
        ],
      );
    },
  );
}

Widget myDream(BuildContext context, DateTime range) {
  return Align(
    alignment: Alignment.topRight,
    child: Column(
      crossAxisAlignment: context
                  .read<CoverBloc>()
                  .state
                  .covers[context.read<CoverBloc>().state.currentCoverId][1][2][0]
                  .toString()
                  .substring(1, 2) ==
              '1'
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          'Моя мечта',
          style: TextLocalStyles.mono400.copyWith(
            fontSize: getHeight(context, 24),
            height: 20.93 / 24,
            color: context
                        .read<CoverBloc>()
                        .state
                        .covers[context.read<CoverBloc>().state.currentCoverId][1][2][0]
                        .toString()
                        .substring(2) ==
                    '1'
                ? const Color.fromRGBO(57, 57, 57, 1)
                : const Color.fromRGBO(240, 247, 254, 1),
          ),
          textAlign: context
                      .read<CoverBloc>()
                      .state
                      .covers[context.read<CoverBloc>().state.currentCoverId][1][2][0]
                      .toString()
                      .substring(1, 2) ==
                  '1'
              ? TextAlign.left
              : TextAlign.right,
        ),
        Text(
          'Подарок ко \n Дню рождения?',
          style: TextLocalStyles.mono400.copyWith(
            fontSize: getHeight(context, 16),
            height: 13.95 / 14,
            color: context
                        .read<CoverBloc>()
                        .state
                        .covers[context.read<CoverBloc>().state.currentCoverId][1][2][0]
                        .toString()
                        .substring(2) ==
                    '1'
                ? const Color.fromRGBO(57, 57, 57, 1)
                : const Color.fromRGBO(240, 247, 254, 1),
          ),
          textAlign: context
                      .read<CoverBloc>()
                      .state
                      .covers[context.read<CoverBloc>().state.currentCoverId][1][2][0]
                      .toString()
                      .substring(1, 2) ==
                  '1'
              ? TextAlign.left
              : TextAlign.right,
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            containerTimer(context, range.month, 'мес'),
            Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
            containerTimer(context, range.day ~/ 7, 'нед'),
            Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
            containerTimer(context, range.day % 7, 'дни'),
            Padding(padding: EdgeInsets.only(left: getWidth(context, 2))),
            containerTimer(context, range.hour, 'час'),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 0.0049 * MediaQuery.of(context).size.height)),
        Align(
          alignment: context
                      .read<CoverBloc>()
                      .state
                      .covers[context.read<CoverBloc>().state.currentCoverId][1][2][0]
                      .toString()
                      .substring(1, 2) ==
                  '1'
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: RotatedBox(
            quarterTurns: 2,
            child: InkWell(
              onTap: () {
                context
                    .read<PostcardBloc>()
                    .add(ChangeHolidayTypeEvent(currentHolidayType: HolidayType.birthday));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const PresentScreen(buyingOption: BuyingOption.buyTogether)));
              },
              child: backSpaceButton(
                  context,
                  context
                          .read<CoverBloc>()
                          .state
                          .covers[context.read<CoverBloc>().state.currentCoverId][1][2][0]
                          .toString()
                          .substring(1, 2) ==
                      '2'),
            ),
          ),
        )
      ],
    ),
  );
}

Widget containerTimer(BuildContext context, int date, String label) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(114, 114, 117, 1),
          Color.fromRGBO(157, 167, 176, 0.6),
        ],
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(context, 6),
        vertical: getHeight(context, 3),
      ),
      child: Column(
        children: [
          Text(
            date < 10 ? '0$date' : '$date',
            style: TextLocalStyles.roboto500.copyWith(
              fontSize: 18,
              color: Colors.white,
              height: 15.7 / 18,
            ),
          ),
          Text(
            label,
            style: TextLocalStyles.roboto400.copyWith(
              color: Colors.white,
              fontSize: 10,
              height: 8.72 / 10,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget backSpaceButton(BuildContext context, bool isLeft) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: getWidth(context, 10)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2),
      gradient: AppTheme.mainGreenGradient,
      //color: Colors.transparent,
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(39, 54, 68, 0.35),
          blurRadius: 6,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: isLeft
        ? Image.asset('assets/images/image 231.png')
        : Image.asset('assets/images/image 222.png'),
  );
}

Widget wishList(BuildContext context) {
  final coverState = context.read<CoverBloc>().state;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RotatedBox(
        quarterTurns: 3,
        child: Text(
          'Список моих  желанных\nподарков  (wishlist)',
          style: TextLocalStyles.mono400.copyWith(
            height: 20 / 20,
            fontSize: 20,
            color:
                coverState.covers[coverState.currentCoverId][1][1][0].toString().substring(2) == '1'
                    ? const Color.fromRGBO(57, 57, 57, 1)
                    : const Color.fromRGBO(240, 247, 254, 1),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: getHeight(context, 4),
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const WishListScreen()));
        },
        child: backSpaceButton(
          context,
          coverState.covers[coverState.currentCoverId][1][1][0].toString().substring(1, 2) == '2'
              ? false
              : true,
        ),
      ),
    ],
  );
}

Widget myWishes(
  BuildContext context, {
  required DateTime rangeToStream,
  required DateTime rangeToBirthday,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Align(
        alignment: Alignment.topRight,
        child: Text(
          'Узнай\nбольше\nо моих\nжеланиях',
          style: TextLocalStyles.mono400.copyWith(
            fontSize: getHeight(context, 31),
            height: 1,
            fontWeight: FontWeight.w200,
          ),
          textAlign: TextAlign.right,
        ),
      ),
      SizedBox(height: getHeight(context, 64)),
      Padding(
        padding: EdgeInsets.only(
          top: getHeight(context, 16),
        ),
      ),
      myDream(
        context,
        rangeToBirthday,
      ),
      Padding(
        padding: EdgeInsets.only(
          top: getHeight(context, 26),
        ),
      ),
      bouquetOfTheWeek(context, rangeToStream)
    ],
  );
}
