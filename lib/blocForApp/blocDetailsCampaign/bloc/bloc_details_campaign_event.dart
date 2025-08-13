part of 'bloc_details_campaign_bloc.dart';

@immutable
sealed class BlocDetailsCampaignEvent {}
 class FetchDetailsCampaignEvent extends BlocDetailsCampaignEvent{
  final int id;

  FetchDetailsCampaignEvent(this.id);
 }