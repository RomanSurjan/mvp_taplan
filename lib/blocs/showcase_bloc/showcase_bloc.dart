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
          id: response.data["presents"][i]['id'],
          photo: response.data["presents"][i]["photo"],
          boughtEarly: response.data["presents"][i]["bought_early"] != 0,
          groupPurchase: response.data["presents"][i]["group_purchase"],
          deliver: response.data["presents"][i]["deliver"] != 0,
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
