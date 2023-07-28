class DateTimeState {
  final String date;

  final String time;

  DateTimeState({
    required this.date,
    required this.time,
  });

  DateTimeState copyWith({
    String? date,
    String? time,
  }) {
    return DateTimeState(
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}
