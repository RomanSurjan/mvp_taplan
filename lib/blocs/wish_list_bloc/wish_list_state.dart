import 'package:dio/dio.dart';
import 'package:mvp_taplan/features/screen_214/mvp_present_data_model.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';

class WishListState {
  final List<MvpPresentModel> wishList;
  final MvpPresentModel? currentModel;
  final MvpPresentDataModel? currentInfo;

  WishListState({
    required this.wishList,
    this.currentModel,
    this.currentInfo,
  });

  WishListState copyWith({
    List<MvpPresentModel>? wishList,
    MvpPresentModel? currentModel,
    MvpPresentDataModel? currentInfo,
  }) {
    return WishListState(
      wishList: wishList ?? this.wishList,
      currentModel: currentModel ?? this.currentModel,
      currentInfo: currentInfo ?? this.currentInfo,
    );
  }

  Future<MvpPresentDataModel> getModelInfo(int currentId) async {
    var response = await Dio().post(
      'https://qviz.fun/api/v1/presentinfo/',
      data: {
        'present_id': currentId.toString(),
      },
    );

    final currentPresentDataModel = MvpPresentDataModel(
      firstGrade: response.data['small_grades']['grade_name_1'],
      secondGrade: response.data['small_grades']['grade_name_2'],
      thirdGrade: response.data['small_grades']['grade_name_3'],
      firstValue: response.data['small_grades']['grade_value_1'],
      secondValue: response.data['small_grades']['grade_value_2'],
      thirdValue: response.data['small_grades']['grade_value_3'],
      firstPhoto: response.data['small_grades']['grade_photo_1'],
      secondPhoto: response.data['small_grades']['grade_photo_2'],
      thirdPhoto: response.data['small_grades']['grade_photo_3'],
    );

    return currentPresentDataModel;
  }
}
