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
}
