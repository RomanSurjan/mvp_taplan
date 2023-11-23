import 'package:mvp_taplan/models/models.dart';

class JournalState {
  final List<MvpContentModel> contentList;
  final List<MvpVideoModel> videosList;

  JournalState({
    required this.contentList,
    required this.videosList,
  });

  JournalState copyWith({
    List<MvpContentModel>? contentList,
    List<MvpVideoModel>? videosList,
  }) {
    return JournalState(
      contentList: contentList ?? this.contentList,
      videosList: videosList ?? this.videosList,
    );
  }
}
