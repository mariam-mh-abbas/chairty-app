part of 'reports_bloc.dart';

@immutable
sealed class ReportsEvent {}

class GetReportsEvent extends ReportsEvent {}
