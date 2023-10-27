abstract class CoverEvent {}

class NextCoverEvent extends CoverEvent {
  NextCoverEvent();
}

class PrevCoverEvent extends CoverEvent {
  PrevCoverEvent();
}

class GetCoverEvent extends CoverEvent {
  final int bloggerId;
  GetCoverEvent({required this.bloggerId});
}
