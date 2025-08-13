part of 'campaign_home_bloc.dart';

@immutable
sealed class CampaignHomeState {}

final class CampaignHomeInitial extends CampaignHomeState {}
final class CampaignHomeLoading extends CampaignHomeState {}
final class CampaignHomeLoaded extends CampaignHomeState {
  List <CampaignHomeModel> Campaigns ;
  
  CampaignHomeLoaded(this.Campaigns);
}
final class CampaignHomeError extends CampaignHomeState {
  String ErrorMsg;
    CampaignHomeError(this.ErrorMsg);
}