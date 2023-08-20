import 'package:mvp_taplan/blocs/postcard_bloc/postcard_state.dart';

abstract class PostcardEvent{

}


class GetPostcardsEvent extends PostcardEvent{

  GetPostcardsEvent();
}

class ChangeHolidayTypeEvent extends PostcardEvent {
  final HolidayType currentHolidayType;

  ChangeHolidayTypeEvent({required this.currentHolidayType});
}

