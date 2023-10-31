import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_event.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_state.dart';
import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListState(wishList: [])) {
    on<GetWishListEvent>(_onGetWishList);
    on<SwapModelsEvent>(_onSwapModel);
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
            type: el['type'],
            gradeNameFirst: el['grades']['grade_name_1'],
            gradeNameSecond: el['grades']['grade_name_2'],
            gradeNameThird: el['grades']['grade_name_3'],
            gradeValueFirst: el['grades']['grade_value_1'],
            gradeValueSecond: el['grades']['grade_value_2'],
            gradeValueThird: el['grades']['grade_value_3'],
            gradePhotoFirst: el['grades']['grade_photo_1'],
            gradePhotoSecond: el['grades']['grade_photo_2'],
            gradePhotoThird: el['grades']['grade_photo_3'],
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

    emitter(
      state.copyWith(
        wishList: listOfModels,
        currentModel: listOfModels[0],
      ),
    );
  }
}
