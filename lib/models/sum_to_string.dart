String sumToString(int value){
  String stringValue = value.toString();
  if(value ~/ 1000 != 0){
    stringValue = '${stringValue.substring(0,stringValue.length-3)} ${stringValue.substring(stringValue.length-3)}';
  }
  if(value ~/ 1000000 != 0){
    stringValue = '${stringValue.substring(0,stringValue.length-7)} ${stringValue.substring(stringValue.length-7)}';

  }
  return stringValue;
}