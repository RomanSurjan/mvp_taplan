class CoverState {
  String myDreamDate;
  String everyWeekStream;
  int dreamPresentId;
  List covers;
  int weekFlowerId;
  int currentCoverId;
  String strWish;
  String telegram;
  String region;
  String username;
  String description;
  int bloggerId;

  CoverState({
    required this.myDreamDate,
    required this.everyWeekStream,
    required this.dreamPresentId,
    required this.covers,
    required this.weekFlowerId,
    required this.currentCoverId,
    required this.strWish,
    required this.telegram,
    required this.region,
    required this.username,
    required this.description,
    required this.bloggerId,
  });

  CoverState copyWith({
    String? myDreamDate,
    String? everyWeekStream,
    int? dreamPresentId,
    List? covers,
    int? weekFlowerId,
    int? currentCoverId,
    String? strWish,
    String? telegram,
    String? region,
    String? username,
    String? description,
    int? bloggerId

  }) {
    return CoverState(
      myDreamDate: myDreamDate ?? this.myDreamDate,
      everyWeekStream: everyWeekStream ?? this.everyWeekStream,
      dreamPresentId: dreamPresentId ?? this.dreamPresentId,
      covers: covers ?? this.covers,
      weekFlowerId: weekFlowerId ?? this.weekFlowerId,
      currentCoverId: currentCoverId ?? this.currentCoverId,
      strWish: strWish ?? this.strWish,
      telegram: telegram ?? this.telegram,
      region: region ?? this.region,
      username: username ?? this.username,
      description: description ?? this.description,
      bloggerId: bloggerId ?? this.bloggerId,
    );
  }
}
