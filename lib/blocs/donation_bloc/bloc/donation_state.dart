part of 'donation_bloc.dart';

@immutable
sealed class DonationState {}

final class DonationInitial extends DonationState {}

class DonationLoading extends DonationState {}

class DonationInKindSuccess extends DonationState {
  final List<InKindModel> inkinds;

  DonationInKindSuccess(this.inkinds);
}

class DonationPeriodicallySuccess extends DonationState {
  final List<PeriodicallyModel> plans;
  DonationPeriodicallySuccess(this.plans);
}

class PlanActionSuccess extends DonationState {
  final PeriodicallyModel updatedPlan;
  PlanActionSuccess(this.updatedPlan);
}

class DonationRegularSuccess extends DonationState {
  DonationRegularSuccess();
}

class DonationError extends DonationState {
  final String message;

  DonationError(this.message);
}

class DonationEmpty extends DonationState {}
