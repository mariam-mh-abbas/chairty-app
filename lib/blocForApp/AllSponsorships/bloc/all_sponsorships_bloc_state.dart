part of 'all_sponsorships_bloc_bloc.dart';

@immutable
sealed class AllSponsorshipsBlocState {}

final class AllSponsorshipsBlocInitial extends AllSponsorshipsBlocState {}
final class AllSponsorshipsBlocLoading extends AllSponsorshipsBlocState {}
final class AllSponsorshipsBlocLoaded extends AllSponsorshipsBlocState {
final  List<SponsorshipModel> allSponsorships;

  AllSponsorshipsBlocLoaded(this.allSponsorships);
}
final class AllSponsorshipsBlocError extends AllSponsorshipsBlocState {
  final String ErrorMsg;

  AllSponsorshipsBlocError(this.ErrorMsg);
}