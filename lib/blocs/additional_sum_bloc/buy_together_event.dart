
abstract class BuyTogetherEvent{

}

class SetAdditionalSumEvent extends BuyTogetherEvent {
  final int additionalSum;

  SetAdditionalSumEvent({required this.additionalSum});
}