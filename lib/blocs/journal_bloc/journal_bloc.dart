import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_event.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_state.dart';
import 'package:mvp_taplan/models/models.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  JournalBloc()
      : super(
          JournalState(
            contentList: [],
            videosList: [],
          ),
        ) {
    on<GetJournalContentEvent>(_onGetJournalContent);
  }

  _onGetJournalContent(GetJournalContentEvent event, Emitter<JournalState> emitter) async {
    try {
      List<MvpContentModel> contentList = [];
      List<int> videos = [];

      final response = await Dio().post(
        'https://qviz.fun/api/v1/content/',
        data: {
          'blogger_id': '1',
        },
      );

      for (int i = 0; i < response.data.length; i++) {
        contentList.add(
          MvpContentModel(
            label: response.data[i]['paragraph'],
            page: response.data[i]['page'],
            videos: response.data[i]['video'],
          ),
        );
      }

      for (int i = 0; i < contentList.length; i++) {
        videos.addAll(contentList[i].videos.cast());
      }

      emitter(
        state.copyWith(
          contentList: contentList.getRange(6, contentList.length - 1).toList(),
          videosList: videos,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
