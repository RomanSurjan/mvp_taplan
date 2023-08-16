import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_event.dart';
import 'package:mvp_taplan/blocs/wish_list_bloc/wish_list_state.dart';
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
    add(GetDataOfCurrentModel(currentModel: listOfModels[0]));
    emitter(state.copyWith(
      wishList: listOfModels,
      currentModel: listOfModels[0],
    ));
  }

  _onGetDataOfCurrentModel(GetDataOfCurrentModel event, Emitter<WishListState> emitter) async {
    try {

      final currentPresentDataModel = await state.getModelInfo(event.currentModel.id);

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
