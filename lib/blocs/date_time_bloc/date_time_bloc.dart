import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_event.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_state.dart';

class DateTimeBloc extends Bloc<DateTimeEvent, DateTimeState> {
  final String date;
  final String time;

  DateTimeBloc({
    required this.date,
    required this.time,
  }) : super(DateTimeState(
          date: date,
          time: time,
        )) {
    on<ChangeDateEvent>(_onDate);
    on<ChangeTimeEvent>(_onTime);
  }

  _onDate(ChangeDateEvent event, Emitter<DateTimeState> emitter) {
    emitter(
      state.copyWith(date: event.date),
    );
  }

  _onTime(ChangeTimeEvent event, Emitter<DateTimeState> emitter) {
    emitter(state.copyWith(time: event.time));
  }
}
