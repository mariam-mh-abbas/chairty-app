part of 'archived_campaigns_bloc.dart';

@immutable
sealed class ArchivedCampaignsState {}

final class ArchivedCampaignsInitial extends ArchivedCampaignsState {}
final class ArchivedCampaignsLoading extends ArchivedCampaignsState {}
final class ArchivedCampaignsLoaded extends ArchivedCampaignsState {
   final List <ArchivedCampaignsModel> ArchivedCampaigns ;
ArchivedCampaignsLoaded(this.ArchivedCampaigns);
}
final class ArchivedCampaignsError extends ArchivedCampaignsState {
  final  String ErrorMsg;
  ArchivedCampaignsError(this.ErrorMsg);
}
