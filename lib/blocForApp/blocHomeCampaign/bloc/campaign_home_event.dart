part of 'campaign_home_bloc.dart';

@immutable
sealed class CampaignHomeEvent {}
class FetchedCampaign extends CampaignHomeEvent{}