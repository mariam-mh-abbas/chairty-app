part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

class GetNotificationEvent extends NotificationEvent {}

class DeleteAllNotifications extends NotificationEvent {}

class DeleteNotificationById extends NotificationEvent {
  final int id;
  DeleteNotificationById(this.id);
}

class UpdateLastSeenNotifications extends NotificationEvent {
  final int lastSeen;
  UpdateLastSeenNotifications(this.lastSeen);
}
