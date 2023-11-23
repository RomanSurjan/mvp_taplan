import 'package:flutter/material.dart';

abstract class JournalEvent {}

class GetJournalContentEvent extends JournalEvent {
  final int bloggerId;

  GetJournalContentEvent({required this.bloggerId});
}

class GetPresentEvent extends JournalEvent {
  final int presentId;
  final BuildContext context;

  GetPresentEvent({
    required this.presentId,
    required this.context,
  });
}
