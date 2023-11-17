abstract class DateTimeEvent{

}


class ChangeDateEvent extends DateTimeEvent{
  final String date;

  ChangeDateEvent({required this.date});
}

class ChangeTimeEvent extends DateTimeEvent {
  final String time;

  ChangeTimeEvent({required this.time});

}

class SetTimeToStreamEvent extends DateTimeEvent{
  final int bloggerId;
  SetTimeToStreamEvent({required this.bloggerId});
}

class CalculateRangeToStreamEvent extends DateTimeEvent{
  final DateTime range;

  CalculateRangeToStreamEvent(this.range);
}