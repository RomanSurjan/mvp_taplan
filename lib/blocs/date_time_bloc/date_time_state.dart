class DateTimeState {
  final String date;

  final String time;

  final DateTime? dateTimeOfStream;

  final DateTime? rangeToStream;

  DateTimeState({
    required this.date,
    required this.time,
    this.dateTimeOfStream,
    this.rangeToStream,
  });

  DateTimeState copyWith({
    String? date,
    String? time,
    DateTime? dateTimeOfStream,
    DateTime? rangeToStream,
  }) {
    return DateTimeState(
      date: date ?? this.date,
      time: time ?? this.time,
      dateTimeOfStream: dateTimeOfStream,
      rangeToStream: rangeToStream,
    );
  }
}
