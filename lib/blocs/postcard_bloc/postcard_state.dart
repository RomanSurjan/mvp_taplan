enum HolidayType {
  birthday,
  stream,
  just,
}

class PostcardState {
  final List<String> postcards;
  final Map<String, List> mapOfEvents;
  final List<String> nameOfEvents;
  final HolidayType currentHolidayType;
  final List<String> streamPostcards;
  final List<String> justPostcards;
  final List<String> hbPostcards;
  final String? postcardSign;

  PostcardState({
    required this.nameOfEvents,
    required this.postcards,
    required this.mapOfEvents,
    this.currentHolidayType = HolidayType.just,
    required this.streamPostcards,
    required this.justPostcards,
    required this.hbPostcards,
    this.postcardSign,
  });

  PostcardState copyWith({
    List<String>? postcards,
    Map<String, List>? mapOfEvents,
    HolidayType? currentHolidayType,
    List<String>? nameOfEvents,
    int? hbIndex,
    List<String>? streamPostcards,
    List<String>? justPostcards,
    List<String>? hbPostcards,
    String? postcardSign,
  }) {
    return PostcardState(
      postcards: postcards ?? this.postcards,
      mapOfEvents: mapOfEvents ?? this.mapOfEvents,
      currentHolidayType: currentHolidayType ?? this.currentHolidayType,
      nameOfEvents: nameOfEvents ?? this.nameOfEvents,
      streamPostcards: streamPostcards ?? this.streamPostcards,
      justPostcards: justPostcards ?? this.justPostcards,
      hbPostcards: hbPostcards ?? this.hbPostcards,
      postcardSign: postcardSign ?? this.postcardSign,
    );
  }
}
