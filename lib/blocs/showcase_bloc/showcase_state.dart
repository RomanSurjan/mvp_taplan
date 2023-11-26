import 'package:mvp_taplan/features/screen_wishlist/present_model.dart';

class ShowcaseState {
  UserModel userModel;
  MvpPresentModel? currentPresentModel;
  List<ShowcaseButton> showcaseButtons;

  ShowcaseState({
    required this.userModel,
    this.currentPresentModel,
    required this.showcaseButtons,
  });

  ShowcaseState copyWith({
    UserModel? userModel,
    MvpPresentModel? currentPresentModel,
    List<ShowcaseButton>? showcaseButtons,
  }) {
    return ShowcaseState(
      userModel: userModel ?? this.userModel,
      currentPresentModel: currentPresentModel ?? this.currentPresentModel,
      showcaseButtons: showcaseButtons ?? this.showcaseButtons,
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
  final int day;
  final int month;
  final int countDaysTo;

  Celebrate(
      {required this.id,
      required this.name,
      required this.date,
      required this.day,
      required this.month,
      required this.countDaysTo});

  factory Celebrate.fromJson(List<dynamic> json) {
    final DateTime celebrateTime = DateTime.parse("${json[2] as String} 00:00:00.000");
    final DateTime currentTime = DateTime.now();
    int temp = (celebrateTime.difference(currentTime).inDays) + 1;
    int daysBetween = (temp < 0) ? 0 : temp;
    return Celebrate(
        id: json[0] as int,
        name: json[1] as String,
        date: json[2] as String,
        day: celebrateTime.day,
        month: celebrateTime.month,
        countDaysTo: daysBetween);
  }

  int nearestCelebrationDaysCount(String date) {
    int result = 0;
    // int days = int.tryParse()
    return result;
  }
}

class ShowcaseCard {
  final String id;
  final String photo;
  final int? video;
  final int invested;
  final int total;
  final bool boughtEarly;
  final bool groupPurchase;
  final bool deliver;
  final int likes;
  final bool liked;
  final int comments;

  ShowcaseCard(
      {required this.id,
      required this.photo,
      this.video,
      required this.invested,
      required this.total,
      required this.boughtEarly,
      required this.groupPurchase,
      required this.deliver,
      required this.likes,
      required this.liked,
      required this.comments});

  factory ShowcaseCard.fromJson(Map<String, dynamic> json) {
    return ShowcaseCard(
        id: json['id'] as String,
        photo: json['photo'] as String,
        video: json['video'] as int?,
        invested: json['invested'] as int,
        total: json['total'] as int,
        boughtEarly: json['bought_early'] != 0,
        groupPurchase: json['group_purchase'] as bool,
        deliver: json['deliver'] != 0,
        likes: json['likes'] as int,
        liked: json['liked'] != 0,
        comments: json['comments'] as int);
  }
}

class ShowcaseButton {
  int id;
  String cat;
  String icon;
  bool available;

  ShowcaseButton({
    required this.id,
    required this.cat,
    required this.icon,
    required this.available,
  });
}
