class PostcardState {
  final List<String> postcards;

  PostcardState({required this.postcards});

  PostcardState copyWith({
    List<String>? postcards
  }) {
    return PostcardState(
      postcards: postcards ?? this.postcards,
    );
  }
}
