import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_event.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_state.dart';
import 'package:mvp_taplan/features/screen_215/screen_215.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';

class ShowcaseBloc extends Bloc<ShowcaseEvent, ShowcaseState> {
  ShowcaseBloc()
      : super(ShowcaseState(
          userModel: UserModel(
            celebrate: Celebrate(
              id: 0,
              name: '',
              date: '',
              day: 0,
              month: 0,
              countDaysTo: 0
            ),
            name: '',
            presents: [],
          ),
        )) {
    on<GetShowcaseCardsEvent>(_onGetShowcase);
    on<GetShowcasePresentInfoEvent>(_onGetPresentInfo);
  }

  _onGetShowcase(
    GetShowcaseCardsEvent event,
    Emitter<ShowcaseState> emitter
  ) async {
    final response = await Dio().post(
      'https://qviz.fun/api/v1/get/wishlist/',
      data: {
        'blogger_id': event.bloggerId,
        'cat': '${event.cat}',
      },
    );

    final UserModel userModel = UserModel.fromJson(response.data);

    emitter(
      state.copyWith(
        userModel: userModel,
      ),
    );
  }

  _onGetPresentInfo(GetShowcasePresentInfoEvent event, Emitter<ShowcaseState> emitter) async {
    try {
      final response = await Dio().post(
        "https://qviz.fun/api/v1/presentinfo/",
        data: {
          'present_id': event.id,
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
      emitter(
        state.copyWith(
          currentPresentModel: currentPresentModel,
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(
        event.context, MaterialPageRoute(
          builder: (_)=> Screen215(currentModel: currentPresentModel)
        )
      );
    } catch (e) {
      rethrow;
    }
  }
}
