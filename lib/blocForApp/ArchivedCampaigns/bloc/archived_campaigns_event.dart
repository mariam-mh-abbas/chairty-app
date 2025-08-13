part of 'archived_campaigns_bloc.dart';

@immutable
sealed class ArchivedCampaignsEvent {}
final class FetchArchivedCampaigns extends ArchivedCampaignsEvent {}