abstract class PaymentEvent{

}

class InitPaymentEvent extends PaymentEvent{
  final int amount;
  final int presentId;
  final String? postcardSign;

  InitPaymentEvent({required this.amount, required this.presentId, this.postcardSign});
}