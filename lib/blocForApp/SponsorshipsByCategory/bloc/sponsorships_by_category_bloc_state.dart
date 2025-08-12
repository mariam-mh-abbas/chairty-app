part of 'sponsorships_by_category_bloc_bloc.dart';

@immutable
sealed class SponsorshipsByCategoryBlocState {}

final class SponsorshipsByCategoryBlocInitial extends SponsorshipsByCategoryBlocState {}
final class SponsorshipsByCategoryBlocLoading extends SponsorshipsByCategoryBlocState {}
final class SponsorshipsByCategoryBlocLoaded extends SponsorshipsByCategoryBlocState {
  final List<SponsorshipModel> SponsorshipsByCategory;

  SponsorshipsByCategoryBlocLoaded(this.SponsorshipsByCategory);
}
final class SponsorshipsByCategoryBlocError extends SponsorshipsByCategoryBlocState {
  final String ErrorMsg;

  SponsorshipsByCategoryBlocError(this.ErrorMsg);
}