import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';

abstract class WishListEvent {}

class GetWishListEvent extends WishListEvent {
  final int bloggerId;
  GetWishListEvent({required this.bloggerId});
}

class SwapModelsEvent extends WishListEvent {
  final int index;

  SwapModelsEvent({required this.index});
}

class GetDataOfCurrentModel extends WishListEvent {
  final MvpPresentModel currentModel;

  GetDataOfCurrentModel({required this.currentModel});
}

