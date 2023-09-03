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
}

class ShowcaseState {
  List<ShowcaseCard> listOfCards;

  ShowcaseState({required this.listOfCards});

  ShowcaseState copyWith({
    List<ShowcaseCard>? listOfCards,
  }) {
    return ShowcaseState(
      listOfCards: listOfCards ?? this.listOfCards,
    );
  }
}
