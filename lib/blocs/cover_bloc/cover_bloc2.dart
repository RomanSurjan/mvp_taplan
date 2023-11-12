import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cover_event.dart';
import 'cover_state.dart';

class CoverBloc2 extends Bloc<CoverEvent, CoverState> {
  CoverBloc2()
      : super(CoverState(
    myDreamDate: '',
    everyWeekStream: '',
    dreamPresentId: 0,
    weekFlowerId: 0,
    currentCoverId: 0,
    covers: [[]],
    strWish: '',
    telegram: '',
    region: '',
    username: '',
    description: '',
    bloggerId: 1,
  )) {
    on<NextCoverEvent>(_onNextCover);
    on<PrevCoverEvent>(_onPrevCover);
    on<GetCoverEvent>(_onGetCover);
  }

  _onGetCover(GetCoverEvent event, Emitter<CoverState> emitter) async {
    try {
      final response = await Dio().post(
        'https://qviz.fun/api/v1/get/taplink/',
        data: {
          'blogger_id': event.bloggerId,
        },
      );

      String strWish = '';
      switch (response.data['covers'][0][1][0][0].toString().substring(1, 2)) {
        case '1':
          strWish = 'Узнай\nбольше\nо моих\nжеланиях';
          break;
        case '2':
          strWish = 'Узнай\nбольше\nо моих\nжеланиях';
          break;
        case '3':
          strWish = 'Узнай больше\nо моих желаниях';
          break;
        case '4':
          strWish = 'Узнай больше\nо моих желаниях';
          break;
        case '5':
          strWish = 'Узнай больше о моих желаниях';
          break;
      }
      emitter(
        state.copyWith(
          myDreamDate: response.data['my_dream_date'],
          everyWeekStream: response.data['every_week_stream'],
          dreamPresentId: response.data['dream_present_id'],
          covers: response.data['covers'],
          weekFlowerId: response.data['week_flower_id'],
          currentCoverId: 0,
          strWish: strWish,
          telegram: response.data['telegram'],
          region: response.data['region'],
          username: response.data['username'],
          description: response.data['description'],
          bloggerId: event.bloggerId,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  _onNextCover(NextCoverEvent event, Emitter<CoverState> emitter) {
    int id = state.currentCoverId + 1;

    String strWish = '';
    switch (state.covers[id][1][0][0].toString().substring(1, 2)) {
      case '1':
        strWish = 'Узнай\nбольше\nо моих\nжеланиях';
        break;
      case '2':
        strWish = 'Узнай\nбольше\nо моих\nжеланиях';
        break;
      case '3':
        strWish = 'Узнай больше\nо моих желаниях';
        break;
      case '4':
        strWish = 'Узнай больше\nо моих желаниях';
        break;
      case '5':
        strWish = 'Узнай больше о моих желаниях';
        break;
    }

    emitter(
      state.copyWith(
        currentCoverId: id,
        strWish: strWish,
      ),
    );
  }

  _onPrevCover(PrevCoverEvent event, Emitter<CoverState> emitter) {
    int id = state.currentCoverId - 1;
    String strWish = '';
    switch (state.covers[id][1][0][0].toString().substring(1, 2)) {
      case '1':
        strWish = 'Узнай\nбольше\nо моих\nжеланиях';
        break;
      case '2':
        strWish = 'Узнай\nбольше\nо моих\nжеланиях';
        break;
      case '3':
        strWish = 'Узнай больше\nо моих желаниях';
        break;
      case '4':
        strWish = 'Узнай больше\nо моих желаниях';
        break;
      case '5':
        strWish = 'Узнай больше о моих желаниях';
        break;
    }
    emitter(
      state.copyWith(
        currentCoverId: id,
        strWish: strWish,
      ),
    );
  }
}
