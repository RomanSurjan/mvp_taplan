import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_event.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_state.dart';

class PostcardBloc extends Bloc<PostcardEvent, PostcardState> {
  PostcardBloc()
      : super(PostcardState(
          postcards: [],
          mapOfEvents: {},
          nameOfEvents: [],
        )) {
    on<GetPostcardsEvent>(_onGetPostCards);
    on<ChangeHolidayTypeEvent>(_onChangeHoliday);
  }

  _onGetPostCards(GetPostcardsEvent event, Emitter<PostcardState> emitter) async {
    List<String> postcards = [];
    List<String> nameOfEvents = [];
    Map<String, List> mapOfEvents = {};
    try {
      var response = await Dio().post(
        'https://qviz.fun/api/v1/get/postcard/data/',
        data: {
          'blogger_id': '1',
        },
      );

      for (int i = 0; i < response.data['postcards'].length; i++) {
        postcards.add(response.data["postcards"][i][0]);
        nameOfEvents.add(response.data["postcards"][i][1]);
      }

      mapOfEvents.addAll(Map.from(response.data['events']));

      emitter(
        state.copyWith(
          postcards: postcards,
          mapOfEvents: mapOfEvents,
          nameOfEvents: nameOfEvents,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  _onChangeHoliday(ChangeHolidayTypeEvent event, Emitter<PostcardState> emitter) {
    emitter(
      state.copyWith(
        currentHolidayType: event.currentHolidayType,
      ),
    );
  }
}
