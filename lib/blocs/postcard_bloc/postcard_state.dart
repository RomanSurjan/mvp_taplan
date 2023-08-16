class PostcardState {
  final List<String> postcards;
  final Map<String, List> mapOfEvents;

  PostcardState({
    required this.postcards,
    required this.mapOfEvents,
  });

  PostcardState copyWith({
    List<String>? postcards,
    Map<String, List>? mapOfEvents,
  }) {
    return PostcardState(
      postcards: postcards ?? this.postcards,
      mapOfEvents: mapOfEvents ?? this.mapOfEvents,
    );
  }
}
