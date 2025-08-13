part of 'once_payment_bloc.dart';

@immutable
sealed class OncePaymentState {}

final class OncePaymentInitial extends OncePaymentState {}
final class OncePaymentProcess extends OncePaymentState {}
final class OncePaymentSuccess extends OncePaymentState {
final  String SuccessMsg;

  OncePaymentSuccess(this.SuccessMsg);
}
final class OncePaymentFailure extends OncePaymentState {
  final String ErrorMsg;

  OncePaymentFailure(this.ErrorMsg);
}
