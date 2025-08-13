part of 'periodically_donaition_bloc.dart';

@immutable
sealed class PeriodicallyDonaitionState {}

final class PeriodicallyDonaitionInitial extends PeriodicallyDonaitionState {}
final class PeriodicallyDonaitionProcess extends PeriodicallyDonaitionState {}
final class PeriodicallyDonaitionSuccess extends PeriodicallyDonaitionState {}
final class PeriodicallyDonaitionError extends PeriodicallyDonaitionState {
  final String ErrorMsg;

  PeriodicallyDonaitionError(this.ErrorMsg);
}
