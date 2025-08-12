part of 'sponsorships_by_category_bloc_bloc.dart';

@immutable
sealed class SponsorshipsByCategoryBlocEvent {}
final  class FetchSponsorshipsByCategory extends SponsorshipsByCategoryBlocEvent {
 final int id ;

  FetchSponsorshipsByCategory(this.id);
}