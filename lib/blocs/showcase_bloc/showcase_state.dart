class UserModel {

  final Celebrate celebrate;
  final String name;
  final List<ShowcaseCard> presents;

  UserModel({
    required this.celebrate,
    required this.name,
    required this.presents
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      celebrate: Celebrate.fromJson(json['nearest_holiday'] as List<dynamic>),
      name: json['username'] as String,
      presents: (json["presents"] as List<dynamic>).map((dynamic e) {
        ShowcaseCard showcaseCard = ShowcaseCard.fromJson(e as Map<String, dynamic>);
        return showcaseCard;
      }).toList(),
    );
  }

}

class Celebrate {

  final int id;
  final String name;
  final String date;

  Celebrate({
    required this.id,
    required this.name,
    required this.date
  });

  factory Celebrate.fromJson(List<dynamic> json){
    return Celebrate(
      id: json[0] as int,
      name: json[1] as String,
      date: json[2] as String
    );
  }

}

class ShowcaseCard {

  final String id;
  final String photo;
  final bool boughtEarly;
  final bool groupPurchase;
  final bool deliver;

  ShowcaseCard({
    required this.id,
    required this.photo,
    required this.boughtEarly,
    required this.groupPurchase,
    required this.deliver,
  });

  factory ShowcaseCard.fromJson(Map<String, dynamic> json){
    return ShowcaseCard(
      id: json['id'],
      photo: json["photo"],
      boughtEarly: json["bought_early"] != 0,
      groupPurchase: json["group_purchase"],
      deliver: json["deliver"] != 0,
    );
  }

}

class ShowcaseState {

  UserModel userModel;

  ShowcaseState({required this.userModel});

  ShowcaseState copyWith({
    UserModel? userModel,
  }) {
    return ShowcaseState(
      userModel: userModel ?? this.userModel,
    );
  }

}
