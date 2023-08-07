// List<String> postcards = [];
//
// void getPostcards() async {
//   var response = await Dio().get('https://qviz.fun/api/v1/get/postcard/data/');
//
//   for(int i = 0; i<response.data['postcards'].length; i ++){
//     postcards.add(response.data["postcards"][i]);
//   }
//
// }

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_event.dart';
import 'package:mvp_taplan/blocs/postcard_bloc/postcard_state.dart';

class PostcardBloc extends Bloc<PostcardEvent, PostcardState> {
  PostcardBloc() : super(PostcardState(postcards: [])) {
    on<GetPostcardsEvent>(_onGetPostCards);
  }

  _onGetPostCards(GetPostcardsEvent event, Emitter<PostcardState> emitter) async {
    List<String> postcards = [];
    try {
      var response = await Dio().post(
        'https://qviz.fun/api/v1/get/postcard/data/',
        data:  {
          'blogger_id': '1',
        },
      );

      for (int i = 0; i < response.data['postcards'].length; i++) {
        postcards.add(response.data["postcards"][i]);
      }

      emitter(
        state.copyWith(postcards: postcards),
      );
    } catch (e) {
      rethrow;
    }
  }
}
