part of 'sponsorships_bloc.dart';

@immutable
sealed class SponsorshipsState {}

final class SponsorshipsInitial extends SponsorshipsState {}

class SponsorshipLoading extends SponsorshipsState {}

class SponsorshipSuccess extends SponsorshipsState {
  final List<PlanModel> sponorships;

  SponsorshipSuccess(this.sponorships);
}

class SponsorshipActionSuccess extends SponsorshipsState {
  SponsorshipActionSuccess();
}

class SponsorshipError extends SponsorshipsState {
  final String message;

  SponsorshipError(this.message);
}

class SponsorshipEmpty extends SponsorshipsState {}
