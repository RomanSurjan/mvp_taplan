abstract class JournalEvent{

}

class GetJournalContentEvent extends JournalEvent{
  final int bloggerId;
  GetJournalContentEvent({required this.bloggerId});

}

class CheckHasProductEvent extends JournalEvent{
  final int videoId;

  CheckHasProductEvent({required this.videoId});
}