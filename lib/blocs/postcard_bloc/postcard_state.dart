enum HolidayType {
  birthday,
  stream,
  just,
}

class PostcardState {
  final List<String> postcards;
  final Map<String, List> mapOfEvents;
  final HolidayType currentHolidayType;

  PostcardState({
    required this.postcards,
    required this.mapOfEvents,
    this.currentHolidayType = HolidayType.just,
  });

  PostcardState copyWith({
    List<String>? postcards,
    Map<String, List>? mapOfEvents,
    HolidayType? currentHolidayType,
  }) {
    return PostcardState(
      postcards: postcards ?? this.postcards,
      mapOfEvents: mapOfEvents ?? this.mapOfEvents,
      currentHolidayType: currentHolidayType ?? this.currentHolidayType,
    );
  }
}
