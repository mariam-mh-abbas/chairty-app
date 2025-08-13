part of 'all_campaign_bloc.dart';

@immutable
sealed class AllCampaignState {}

final class AllCampaignInitial extends AllCampaignState {}
final class AllCampaignLoading extends AllCampaignState {}
final class AllCampaignLoaded extends AllCampaignState {
  final List <Allcampaignmodel> Allcampaigns ;
AllCampaignLoaded(this.Allcampaigns);
}
final class AllCampaignError extends AllCampaignState {
  String ErrorMsg;
  AllCampaignError(this.ErrorMsg);
}
