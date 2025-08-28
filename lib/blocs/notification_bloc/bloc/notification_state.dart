part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<VolunteeringModel> notification;

  NotificationSuccess(this.notification);
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}

class NotificationEmpty extends NotificationState {}
