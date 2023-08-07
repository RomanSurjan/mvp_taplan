class BuyTogetherState {
  final double additionalSum;

  BuyTogetherState({required this.additionalSum});

  BuyTogetherState copyWith({
    double? additionalSum,
  }) {
    return BuyTogetherState(
      additionalSum: additionalSum ?? this.additionalSum,
    );
  }
}
