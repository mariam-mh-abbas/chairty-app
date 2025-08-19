part of 'reports_bloc.dart';

@immutable
sealed class ReportsState {}

final class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsSuccess extends ReportsState {
  final List<ReportsModel> reports;

  ReportsSuccess(this.reports);
}

class ReportsError extends ReportsState {
  final String message;

  ReportsError(this.message);
}

class ReportsEmpty extends ReportsState {}
