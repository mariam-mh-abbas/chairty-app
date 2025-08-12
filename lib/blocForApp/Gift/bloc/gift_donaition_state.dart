part of 'gift_donaition_bloc.dart';

@immutable
sealed class GiftDonaitionState {}

final class GiftDonaitionInitial extends GiftDonaitionState {}
final class GiftDonaitionProcess extends GiftDonaitionState {}
final class GiftDonaitionSuccess extends GiftDonaitionState {
final  String SuccessMsg;

  GiftDonaitionSuccess(this.SuccessMsg);
}
final class GiftDonaitionError extends GiftDonaitionState {
  final  String ErrorMsg;

  GiftDonaitionError(this.ErrorMsg);
}
