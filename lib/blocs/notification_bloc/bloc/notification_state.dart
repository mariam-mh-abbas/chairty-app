part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationSuccess(this.notifications);
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}

class NotificationDeleteSuccess extends NotificationState {
  final String message;

  NotificationDeleteSuccess(this.message);
}

class NotificationEmpty extends NotificationState {}

class NotificationBadgeState extends NotificationState {
  final int currentCount;
  final int lastSeenCount;

  NotificationBadgeState(
      {required this.currentCount, required this.lastSeenCount});
}
