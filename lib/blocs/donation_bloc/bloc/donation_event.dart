part of 'donation_bloc.dart';

@immutable
sealed class DonationEvent {}

class DonationInKindEvent extends DonationEvent {}

class DonationPeriodicallyEvent extends DonationEvent {}

class DonationRegularEvent extends DonationEvent {}

class DeactivatePlanEvent extends DonationEvent {
  final int planId;
  DeactivatePlanEvent(this.planId);
}

class ReactivatePlanEvent extends DonationEvent {
  final int planId;
  ReactivatePlanEvent(this.planId);
}
