import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_event.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_state.dart';
import 'package:mvp_taplan/features/screen_214/mvp_present_data_model.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListState(wishList: [])) {
    on<GetWishListEvent>(_onGetWishList);
    on<SwapModelsEvent>(_onSwapModel);
    on<GetDataOfCurrentModel>(_onGetDataOfCurrentModel);
  }

  _onGetWishList(GetWishListEvent event, Emitter<WishListState> emitter) async {
    List<MvpPresentModel> wishList = [];
    try {
      var response = await Dio().post(
        'https://qviz.fun/api/v1/presentinfo/',
        data: {
          'blogger_id': '1',
        },
      );

      for (final el in response.data['present_info']) {
        wishList.add(
          MvpPresentModel(
            bigImage: el['present_photo_2'],
            smallImage: el['present_photo_1'],
            label: el['present_name'],
            fullPrice: el['total'],
            alreadyGet: el['invested'],
            position: el['position'],
            id: el['id'],
          ),
        );
      }

      wishList.sort((a, b) => a.position.compareTo(b.position));

      emitter(
        state.copyWith(
          wishList: wishList,
          currentModel: wishList[0],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  _onSwapModel(SwapModelsEvent event, Emitter<WishListState> emitter) {
    final listOfModels = state.wishList;
    final additionalModel = listOfModels[0];
    listOfModels[0] = listOfModels[event.index];
    listOfModels[event.index] = additionalModel;
    emitter(state.copyWith(
      wishList: listOfModels,
      currentModel: listOfModels[0],
    ));
  }

  _onGetDataOfCurrentModel(GetDataOfCurrentModel event, Emitter<WishListState> emitter) async {
    try {

      var response = await Dio().post(
        'https://qviz.fun/api/v1/presentinfo/',
        data: {
          'present_id': event.currentModel.id.toString(),
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

      emitter(
        state.copyWith(
          currentInfo: currentPresentDataModel,
        ),
      );

    } catch (e) {
      rethrow;
    }
  }
}
