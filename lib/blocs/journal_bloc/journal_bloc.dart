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
      List<String> videosUrl = [];

      final response = await Dio().post(
        'https://qviz.fun/api/v1/content/',
        data: {
          'blogger_id': event.bloggerId,
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

      for(int i = 0; i < videos.length; i++){
        try{
          final response = await Dio().post(
            'https://qviz.fun/api/v1/get/video/',
            data: {
              'video_id': videos[i],
            },
          );

          videosUrl.add(response.data['video']);
        }catch(e){
          rethrow;
        }
      }

      emitter(
        state.copyWith(
          contentList: contentList,
          videosList: videosUrl,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
