part of 'sponsorships_bloc.dart';

@immutable
sealed class SponsorshipsEvent {}

class GetSponsorshipEvent extends SponsorshipsEvent {}

class DeactivateSponsorshipEvent extends SponsorshipsEvent {
  final int planId;

  DeactivateSponsorshipEvent(this.planId);
}

class ReactivateSponsorshipEvent extends SponsorshipsEvent {
  final int planId;

  ReactivateSponsorshipEvent(this.planId);
}
