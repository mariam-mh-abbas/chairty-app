part of 'campaign_by_category_id_bloc.dart';

@immutable
sealed class CampaignByCategoryIdEvent {}
 class FetchCampaignByCategoryId extends CampaignByCategoryIdEvent{
  int categoryId;
  FetchCampaignByCategoryId(this.categoryId );
 }