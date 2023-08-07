
abstract class BuyTogetherEvent{

}

class SetAdditionalSumEvent extends BuyTogetherEvent {
  final double additionalSum;

  SetAdditionalSumEvent({required this.additionalSum});
}