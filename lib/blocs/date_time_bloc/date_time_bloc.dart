import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_event.dart';
import 'package:mvp_taplan/blocs/date_time_bloc/date_time_state.dart';

class DateTimeBloc extends Bloc<DateTimeEvent, DateTimeState> {
  final String date;
  final String time;

  Timer? timer;

  DateTimeBloc({
    required this.date,
    required this.time,
  }) : super(DateTimeState(
    date: date,
    time: time,
  )) {
    on<ChangeDateEvent>(_onDate);
    on<ChangeTimeEvent>(_onTime);
    on<SetTimeToStreamEvent>(_onSetTime);
    on<CalculateRangeToStreamEvent>(_onCalculate);
  }

  _onDate(ChangeDateEvent event, Emitter<DateTimeState> emitter) {
    emitter(
      state.copyWith(date: event.date),
    );
  }

  _onTime(ChangeTimeEvent event, Emitter<DateTimeState> emitter) {
    emitter(state.copyWith(time: event.time));
  }

  _onSetTime(SetTimeToStreamEvent event, Emitter<DateTimeState> emitter) async {
    try {
      final response = await Dio().post(
        'https://qviz.fun/api/v1/get/taplink/',
        data: {
          'blogger_id': '45',
        },
      );
      final dateOfStreamString = response.data['every_week_stream'] as String;

      final dateString = dateOfStreamString.substring(0, dateOfStreamString.indexOf('T'));
      final timeString = dateOfStreamString.substring(dateOfStreamString.indexOf('T') + 1);

      final listForDate = dateString.split('-');
      final listForTime = timeString.split(':');

      final dateTimeOfStream = DateTime(
        int.parse(listForDate[0]),
        int.parse(listForDate[1]),
        int.parse(listForDate[2]),
        int.parse(listForTime[0]),
        int.parse(listForTime[1]),
        int.parse(listForTime[2]),
      );


      emitter(
        state.copyWith(
          dateTimeOfStream: dateTimeOfStream,
        ),
      );
    } catch (e) {
      rethrow;
    }
    var range = DateTime.now();
    final dateOfStream = state.dateTimeOfStream;
    if (dateOfStream != null) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
            (timer) {
          DateTime nowDate = DateTime.now();
          range = DateTime(
            dateOfStream.year - nowDate.year,
            dateOfStream.month - nowDate.month,
            dateOfStream.day - nowDate.day,
            dateOfStream.hour - nowDate.hour,
            dateOfStream.minute - nowDate.minute,
            dateOfStream.second - nowDate.second,
          );
          add(CalculateRangeToStreamEvent(range));

        },
      );


    }
  }

    _onCalculate(CalculateRangeToStreamEvent event, Emitter<DateTimeState> emitter) {

      emitter(
        state.copyWith(
          rangeToStream: event.range,
        ),
      );
    }

    @override
    Future<void> close() {
      timer?.cancel();
      timer = null;

      return super.close();
    }
  }
