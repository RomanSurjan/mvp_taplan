import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_event.dart';
import 'package:mvp_taplan/blocs/journal_bloc/journal_state.dart';
import 'package:mvp_taplan/features/screen_215/screen_215.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';
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
    on<GetPresentEvent>(_onGetPresent);
  }

  _onGetJournalContent(GetJournalContentEvent event, Emitter<JournalState> emitter) async {
    try {
      List<MvpContentModel> contentList = [];
      List<int> videos = [];
      List<MvpVideoModel> videoModels = [];

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

      for (int i = 0; i < videos.length; i++) {
        try {
          final response = await Dio().post(
            'https://qviz.fun/api/v1/get/video/',
            data: {
              'video_id': videos[i],
            },
          );

          videoModels.add(
            MvpVideoModel(
              videoUrl: response.data['video'],
              presentId: response.data['present_id'],
              likes: response.data['likes'],
              isLiked: response.data['liked'],
              comments: response.data['comments'],
            ),
          );
        } catch (e) {
          rethrow;
        }
      }

      emitter(
        state.copyWith(
          contentList: contentList,
          videosList: videoModels,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  _onGetPresent(GetPresentEvent event, Emitter<JournalState> emitter) async {
    final response = await Dio().post(
      'https://qviz.fun/api/v1/presentinfo/',
      data: {
        'present_id': event.presentId,
      },
    );

    final currentPresentModel = MvpPresentModel(
      bigImage: response.data['present_info']['present_photo_2'],
      smallImage: response.data['present_info']['present_photo_1'],
      label: response.data['present_info']['present_name'],
      fullPrice: response.data['present_info']['total'],
      alreadyGet: response.data['present_info']['invested'],
      position: response.data['present_info']['position'],
      id: response.data['present_info']['id'],
      type: response.data['present_info']['type'],
      gradeNameFirst: response.data['small_grades']['grade_name_1'],
      gradeNameSecond: response.data['small_grades']['grade_name_2'],
      gradeNameThird: response.data['small_grades']['grade_name_3'],
      gradeValueFirst: response.data['small_grades']['grade_value_1'],
      gradeValueSecond: response.data['small_grades']['grade_value_2'],
      gradeValueThird: response.data['small_grades']['grade_value_3'],
      gradePhotoFirst: response.data['small_grades']['grade_photo_1'],
      gradePhotoSecond: response.data['small_grades']['grade_photo_2'],
      gradePhotoThird: response.data['small_grades']['grade_photo_3'],
      videoId: response.data['present_info']['present_video'],
    );


    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (_) => Screen215(currentModel: currentPresentModel),
      ),
    );
  }
}
