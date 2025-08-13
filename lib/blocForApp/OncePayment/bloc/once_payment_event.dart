part of 'once_payment_bloc.dart';

@immutable
sealed class OncePaymentEvent {}
class OncePayment extends OncePaymentEvent{
  final List<OncePaymentmodel> payedItems;

  OncePayment(this.payedItems);
}