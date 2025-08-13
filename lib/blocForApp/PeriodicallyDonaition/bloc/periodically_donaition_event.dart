part of 'periodically_donaition_bloc.dart';

@immutable
sealed class PeriodicallyDonaitionEvent {}
 class DonaitePeriodically extends PeriodicallyDonaitionEvent {
  final Periodicallydonaitionmodel periodicallydonaitionitem;

  DonaitePeriodically(this.periodicallydonaitionitem);
 }