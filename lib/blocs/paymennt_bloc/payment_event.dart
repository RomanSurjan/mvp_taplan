abstract class PaymentEvent{

}

class InitPaymentEvent extends PaymentEvent{
  final int amount;

  InitPaymentEvent(this.amount);
}