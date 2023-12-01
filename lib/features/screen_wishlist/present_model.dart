class MvpPresentModel {
  String bigImage;
  String smallImage;
  String label;
  int fullPrice;
  int alreadyGet;
  int position;
  int id;
  int type;
  String gradeNameFirst;
  String gradeNameSecond;
  String gradeNameThird;
  int gradeValueFirst;
  int gradeValueSecond;
  int gradeValueThird;
  String? gradePhotoFirst;
  String? gradePhotoSecond;
  String? gradePhotoThird;
  int? videoId;
  int? likes;
  int? comments;
  int? liked;


  MvpPresentModel({
    required this.bigImage,
    required this.smallImage,
    required this.label,
    required this.fullPrice,
    required this.alreadyGet,
    required this.position,
    required this.id,
    required this.type,
    required this.gradeNameFirst,
    required this.gradeNameSecond,
    required this.gradeNameThird,
    required this.gradeValueFirst,
    required this.gradeValueSecond,
    required this.gradeValueThird,
    this.gradePhotoFirst,
    this.gradePhotoSecond,
    this.gradePhotoThird,
    this.videoId,
    this.likes,
    this.comments,
    this.liked,
  });
}
