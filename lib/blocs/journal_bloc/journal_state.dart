import 'package:mvp_taplan/models/models.dart';

class JournalState {
  final List<MvpContentModel> contentList;

  JournalState({required this.contentList});

  JournalState copyWith({
    List<MvpContentModel>? contentList,
  }) {
    return JournalState(
      contentList: contentList ?? this.contentList,
    );
  }
}
