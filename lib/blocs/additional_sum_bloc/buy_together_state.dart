class BuyTogetherState {
  final int additionalSum;

  BuyTogetherState({required this.additionalSum});

  BuyTogetherState copyWith({
    int? additionalSum,
  }) {
    return BuyTogetherState(
      additionalSum: additionalSum ?? this.additionalSum,
    );
  }
}
