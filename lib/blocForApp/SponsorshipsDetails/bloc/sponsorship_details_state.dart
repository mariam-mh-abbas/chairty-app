part of 'sponsorship_details_bloc.dart';

@immutable
sealed class SponsorshipDetailsState {}

final class SponsorshipDetailsInitial extends SponsorshipDetailsState {}
final class SponsorshipDetailsLoading extends SponsorshipDetailsState {}
final class SponsorshipDetailsLoaded extends SponsorshipDetailsState {
  final SponsorshipDetailsmodel sponsorshipDetailsmodel;

  SponsorshipDetailsLoaded(this.sponsorshipDetailsmodel);
}
final class SponsorshipDetailsError extends SponsorshipDetailsState {
  final String ErrorMsg;

  SponsorshipDetailsError(this.ErrorMsg);
}

