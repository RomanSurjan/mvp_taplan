abstract class ShowcaseEvent{

}

class GetShowcaseCardsEvent extends ShowcaseEvent{
  final int cat;

  GetShowcaseCardsEvent(this.cat);

}