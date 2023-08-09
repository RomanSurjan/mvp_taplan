class MvpPresentDataModel {
  final String firstGrade;
  final String secondGrade;
  final String thirdGrade;
  final int firstValue;
  final int secondValue;
  final int thirdValue;
  final String? firstPhoto;
  final String? secondPhoto;
  final String? thirdPhoto;

  MvpPresentDataModel({
    required this.firstGrade,
    required this.secondGrade,
    required this.thirdGrade,
    required this.firstValue,
    required this.secondValue,
    required this.thirdValue,
    this.firstPhoto,
    this.secondPhoto,
    this.thirdPhoto,
  });
}
