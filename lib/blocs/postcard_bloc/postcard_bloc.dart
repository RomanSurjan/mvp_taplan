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
          streamPostcards: [],
          justPostcards: [],
          hbPostcards: [],
        )) {
    on<GetPostcardsEvent>(_onGetPostCards);
    on<ChangeHolidayTypeEvent>(_onChangeHoliday);
  }

  _onGetPostCards(GetPostcardsEvent event, Emitter<PostcardState> emitter) async {
    List<String> postcards = [];
    List<String> nameOfEvents = [];
    Map<String, List> mapOfEvents = {};
    List<String> simplePostcards = [];
    List<String> streamPostcards = [];
    List<String> justPostcards = [];
    List<String> hbPostcards = [];

    int hbIndex = 0;

    try {
      var response = await Dio().post(
        'https://qviz.fun/api/v1/get/postcard/data/',
        data: {
          'blogger_id': '1',
        },
      );

      hbIndex = response.data['hb_index'];

      for(int i = 0; i<response.data['simple_postcards'].length; i++){
        simplePostcards.add(response.data['simple_postcards'][i]);
      }

      for (int i = 0; i < response.data['postcards'].length; i++) {
        postcards.add(response.data["postcards"][i][0]);
        nameOfEvents.add(response.data["postcards"][i][1]);
      }

      justPostcards.addAll([
        postcards[0],
        postcards[1],
        postcards[2],
        postcards[3],
      ]);
      justPostcards.addAll(simplePostcards);
      justPostcards.addAll(postcards.getRange(4, postcards.length-1));

      streamPostcards.addAll([
        postcards[0],
        postcards[1],
        postcards[2],
        postcards[3],
        postcards[4],
        simplePostcards[0],
        postcards[5],
        simplePostcards[1],
        postcards[6],
        simplePostcards[2],
        postcards[7],
        simplePostcards[3],
        postcards[8],
        simplePostcards[4],
        postcards[9],
      ]);
      streamPostcards.addAll(postcards.getRange(10, postcards.length-1));

      if(hbIndex - 4 >  0){
        hbPostcards.addAll([
          postcards[hbIndex-4],
          postcards[hbIndex-3],
          postcards[hbIndex-2],
          postcards[hbIndex-1],
          postcards[hbIndex],
          simplePostcards[0],
          postcards[hbIndex+1],
          simplePostcards[1],
          postcards[hbIndex+2],
          simplePostcards[2],
          postcards[hbIndex+3],
          simplePostcards[4],
        ]);
        hbPostcards.addAll(postcards.getRange(hbIndex+4, postcards.length-1));
        hbPostcards.addAll(postcards.getRange(0, hbIndex-5));
      }

      mapOfEvents.addAll(Map.from(response.data['events']));

      emitter(
        state.copyWith(
          postcards: postcards,
          mapOfEvents: mapOfEvents,
          nameOfEvents: nameOfEvents,
          justPostcards: justPostcards,
          streamPostcards: streamPostcards,
          hbPostcards: hbPostcards
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
