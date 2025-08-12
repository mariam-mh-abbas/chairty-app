part of 'request_bloc.dart';

@immutable
sealed class RequestEvent {}

class HelpRequestEvent extends RequestEvent {}

class VolunteerRequestEvent extends RequestEvent {}

class VolunteerRequestDetailsEvent extends RequestEvent {
  final int requestId;

  VolunteerRequestDetailsEvent(this.requestId);
}

class HelpRequestDetailsEvent extends RequestEvent {
  final int requestId;
  HelpRequestDetailsEvent(this.requestId);
}
