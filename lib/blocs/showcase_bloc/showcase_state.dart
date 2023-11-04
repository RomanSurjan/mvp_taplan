import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';

class ShowcaseState {
  UserModel userModel;
  MvpPresentModel? currentPresentModel;

  ShowcaseState({
    required this.userModel,
    this.currentPresentModel,
  });

  ShowcaseState copyWith({
    UserModel? userModel,
    MvpPresentModel? currentPresentModel,
  }) {
    return ShowcaseState(
      userModel: userModel ?? this.userModel,
      currentPresentModel: currentPresentModel ?? this.currentPresentModel,
    );
  }
}


class UserModel {
  final Celebrate celebrate;
  final String name;
  final List<ShowcaseCard> presents;

  UserModel({required this.celebrate, required this.name, required this.presents});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      celebrate: Celebrate.fromJson(json['nearest_holiday'] as List<dynamic>),
      name: json['username'] as String,
      presents: (json["presents"] as List<dynamic>).map((dynamic e) {
        final showcaseCard = ShowcaseCard.fromJson(e as Map<String, dynamic>);
        return showcaseCard;
      }).toList(),
    );
  }
}

class Celebrate {
  final int id;
  final String name;
  final String date;

  Celebrate({required this.id, required this.name, required this.date});

  factory Celebrate.fromJson(List<dynamic> json) {
    return Celebrate(
      id: json[0] as int,
      name: json[1] as String,
      date: json[2] as String,
    );
  }
}

class ShowcaseCard {
  final String id;
  final String photo;
  final int invested;
  final int total;
  final bool boughtEarly;
  final bool groupPurchase;
  final bool deliver;

  ShowcaseCard({
    required this.id,
    required this.photo,
    required this.invested,
    required this.total,
    required this.boughtEarly,
    required this.groupPurchase,
    required this.deliver,
  });

  factory ShowcaseCard.fromJson(Map<String, dynamic> json) {
    return ShowcaseCard(
      id: json['id'] as String,
      photo: json["photo"] as String,
      invested: json["invested"] as int,
      total: json["total"] as int,
      boughtEarly: json["bought_early"] != 0,
      groupPurchase: json["group_purchase"] as bool,
      deliver: json["deliver"] != 0,
    );
  }
}