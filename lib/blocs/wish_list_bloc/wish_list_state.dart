import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';

class WishListState {
  final List<MvpPresentModel> wishList;
  final MvpPresentModel? currentModel;

  WishListState({
    required this.wishList,
    this.currentModel,
  });

  WishListState copyWith({
    List<MvpPresentModel>? wishList,
    MvpPresentModel? currentModel,
  }) {
    return WishListState(
      wishList: wishList ?? this.wishList,
      currentModel: currentModel ?? this.currentModel,
    );
  }
}
