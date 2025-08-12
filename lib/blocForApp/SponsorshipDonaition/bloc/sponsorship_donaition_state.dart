part of 'sponsorship_donaition_bloc.dart';

@immutable
sealed class SponsorshipDonaitionState {}

final class SponsorshipDonaitionInitial extends SponsorshipDonaitionState {}
final class SponsorshipDonaitionProcess extends SponsorshipDonaitionState {}
final class SponsorshipDonaitionSuccess extends SponsorshipDonaitionState {}
final class SponsorshipDonaitionError extends SponsorshipDonaitionState {
 final String ErrorMsg;

  SponsorshipDonaitionError(this.ErrorMsg);
}