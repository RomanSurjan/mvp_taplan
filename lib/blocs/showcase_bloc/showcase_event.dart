import 'package:flutter/material.dart';

abstract class ShowcaseEvent{

}

class GetShowcaseCardsEvent extends ShowcaseEvent{
  final int bloggerId;
  final int cat;

  GetShowcaseCardsEvent({required this.bloggerId, required this.cat});

}

class GetShowcasePresentInfoEvent extends ShowcaseEvent{
  final int id;
  final BuildContext context;

  GetShowcasePresentInfoEvent({required this.id, required this.context});
}

