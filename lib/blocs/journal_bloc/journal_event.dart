abstract class JournalEvent{

}

class GetJournalContentEvent extends JournalEvent{

}

class CheckHasProductEvent extends JournalEvent{
  final int videoId;

  CheckHasProductEvent({required this.videoId});
}