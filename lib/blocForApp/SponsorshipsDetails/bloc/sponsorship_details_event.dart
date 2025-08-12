part of 'sponsorship_details_bloc.dart';

@immutable
sealed class SponsorshipDetailsEvent {}
final class FetchSponsorshipDetails extends SponsorshipDetailsEvent{
  final int id;

  FetchSponsorshipDetails(this.id);
}