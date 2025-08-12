part of 'sponsorship_donaition_bloc.dart';

@immutable
sealed class SponsorshipDonaitionEvent {}
class DonateToSponsorship extends SponsorshipDonaitionEvent{
  final int SponsorshipId;
  final int amount;
  DonateToSponsorship(this.SponsorshipId,this.amount);

}