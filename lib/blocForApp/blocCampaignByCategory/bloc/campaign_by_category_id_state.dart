part of 'campaign_by_category_id_bloc.dart';

@immutable
sealed class CampaignByCategoryIdState {}

final class CampaignByCategoryIdInitial extends CampaignByCategoryIdState {}
final class CampaignByCategoryIdLoading extends CampaignByCategoryIdState {}
final class CampaignByCategoryIdLoaded extends CampaignByCategoryIdState {
  final List <Allcampaignmodel> CampaignByCategory ;
CampaignByCategoryIdLoaded(this.CampaignByCategory);
}
final class CampaignByCategoryIdError extends CampaignByCategoryIdState {
  String ErrorMsg;
  CampaignByCategoryIdError(this.ErrorMsg);
}