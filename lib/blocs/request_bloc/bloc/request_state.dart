part of 'request_bloc.dart';

@immutable
sealed class RequestState {}

final class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestSuccess extends RequestState {
  final List<RequestModel> requests;

  RequestSuccess(this.requests);
}

class RequestError extends RequestState {
  final String message;

  RequestError(this.message);
}

class RequestEmpty extends RequestState {}

class VolunteerRequestDetailSuccess extends RequestState {
  final VolunteerRequestDetailModel detail;
  VolunteerRequestDetailSuccess(this.detail);
}

class HelpRequestDetailSuccess extends RequestState {
  final HelpRequestDetailModel detail;
  HelpRequestDetailSuccess(this.detail);
}
