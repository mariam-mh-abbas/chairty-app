part of 'in_kind_donaition_bloc.dart';

@immutable
sealed class InKindDonaitionState {}

final class InKindDonaitionInitial extends InKindDonaitionState {}
final class InKindDonaitionProcess extends InKindDonaitionState {}
final class InKindDonaitionSuccess extends InKindDonaitionState {
  final String SuccessMsg;

  InKindDonaitionSuccess(this.SuccessMsg);
}
final class InKindDonaitionError extends InKindDonaitionState {
  final String ErrorMsg;

  InKindDonaitionError(this.ErrorMsg);
}
