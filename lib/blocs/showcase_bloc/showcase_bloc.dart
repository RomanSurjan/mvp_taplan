import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_event.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_state.dart';

class ShowcaseBloc extends Bloc<ShowcaseEvent, ShowcaseState> {
  ShowcaseBloc() : super(ShowcaseState(listOfCards: [])) {
    on<GetShowcaseCardsEvent>(_onGetShowcase);
  }

  _onGetShowcase(GetShowcaseCardsEvent event, Emitter<ShowcaseState> emitter) async {
    final listOfCards = <ShowcaseCard>[];

    final response = await Dio().post(
      'https://qviz.fun/api/v1/get/wishlist/',
      data: {
        'blogger_id': "1",
        'cat': '${event.cat}',
      },
    );

    for (int i = 0; i < response.data.length; i++) {
      listOfCards.add(
        ShowcaseCard(
          id: response.data[i]['id'],
          photo: response.data[i]["photo"],
          boughtEarly: response.data[i]["bought_early"] != 0,
          groupPurchase: response.data[i]["group_purchase"],
          deliver: response.data[i]["deliver"] != 0,
        ),
      );
    }

    emitter(
      state.copyWith(
        listOfCards: listOfCards,
      ),
    );
  }
}
