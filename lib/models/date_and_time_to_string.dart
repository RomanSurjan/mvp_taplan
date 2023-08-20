part of 'models.dart';

String dateToString(String date) {
  final dateList = date.split('-');

  return '${dateList[2]}.${dateList[1]}.${dateList[0]}';
}

String timeToString(String time) {
  final timeList = time.split(':');

  return '${timeList[0]}.${timeList[1]}';
}