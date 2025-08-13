part of 'bloc_details_campaign_bloc.dart';

@immutable
sealed class BlocDetailsCampaignState {}

final class BlocDetailsCampaignInitial extends BlocDetailsCampaignState {}
final class BlocDetailsCampaignLoading extends BlocDetailsCampaignState {}

final class BlocDetailsCampaignLoaded extends BlocDetailsCampaignState {
  final  DetailsCampaignModel campaignsDetails;

  BlocDetailsCampaignLoaded(this.campaignsDetails);
}
final class BlocDetailsCampaignError extends BlocDetailsCampaignState {
final String ErrorMsg;

  BlocDetailsCampaignError(this.ErrorMsg);
}