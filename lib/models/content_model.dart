part of 'models.dart';

class MvpContentModel {
  final String label;
  final int page;
  final List videos;

  MvpContentModel({
    required this.label,
    required this.page,
    required this.videos,
  });
}

class MvpVideoModel {
  final String videoUrl;
  final int? presentId;
  final int likes;
  final bool isLiked;
  final int comments;

  MvpVideoModel({
    required this.videoUrl,
    this.presentId,
    required this.likes,
    required this.isLiked,
    required this.comments,
  });
}
