import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_event.dart';
import 'package:mvp_taplan/blocs/showcase_bloc/showcase_state.dart';
import 'package:mvp_taplan/features/screen_215/screen_215.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              countDaysTo: 0,
            ),
            name: '',
            presents: [],
          ),
          showcaseButtons: [],
          currentCat: 0,
        )) {
    on<GetShowcaseCardsEvent>(_onGetShowcase);
    on<GetShowcasePresentInfoEvent>(_onGetPresentInfo);
  }

  _onGetShowcase(GetShowcaseCardsEvent event, Emitter<ShowcaseState> emitter) async {
    List<ShowcaseButton> showcaseButtons = [];

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await Dio().post(
      'https://qviz.fun/api/v1/get/wishlist/',
      data: {
        'blogger_id': event.bloggerId,
        'cat': '${event.cat}',
      },
      options: token != null
          ? Options(
              headers: {
                'Authorization': 'Token $token',
              },
            )
          : null,
    );

    final UserModel userModel = UserModel.fromJson(response.data);

    for (int i = 0; i < response.data['cat'].length; i++) {
      String cat = response.data['cat'][i]['cat'];

      showcaseButtons.add(
        ShowcaseButton(
          id: response.data['cat'][i]['id'],
          cat: cat.replaceAll(r'\n', '\n'),
          icon: 'https://qviz.fun${response.data['cat'][i]['icon']}',
          available: response.data['cat'][i]['available'] == 1,
        ),
      );
    }

    emitter(
      state.copyWith(
        userModel: userModel,
        showcaseButtons: showcaseButtons,
        currentCat: event.cat,
      ),
    );
  }

  _onGetPresentInfo(GetShowcasePresentInfoEvent event, Emitter<ShowcaseState> emitter) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final response = await Dio().post(
        "https://qviz.fun/api/v1/presentinfo/",
        data: {
          'present_id': event.id,
        },
        options: token != null
            ? Options(
                headers: {
                  'Authorization': 'Token $token',
                },
              )
            : null,
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
        likes: response.data['present_info']['likes'],
        comments: response.data['present_info']['comments'],
        liked: response.data['present_info']['liked'],
      );

      navigationToScreen215(
        event.context,
        currentPresentModel,
      );
      emitter(
        state.copyWith(
          currentPresentModel: currentPresentModel,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  void navigationToScreen215(BuildContext context, currentPresentModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Screen215(
          currentModel: currentPresentModel,
          fromShowcase: true,
          onBack: () {
            add(GetShowcaseCardsEvent(bloggerId: 1, cat: state.currentCat));
          },
        ),
      ),
    );
  }
}
