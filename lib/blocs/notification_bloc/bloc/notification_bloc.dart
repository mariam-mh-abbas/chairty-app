import 'package:bloc/bloc.dart';
import 'package:charity_project/models/notification_model.dart';
import 'package:charity_project/models/volunteering_model.dart';
import 'package:charity_project/services/notification_service.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationService notificationService;
  NotificationBloc(this.notificationService) : super(NotificationInitial()) {
    // on<GetNotificationEvent>((event, emit) async {
    //   try {
    //     final notifications = await notificationService.getAllNotifications();
    //     if (notifications == null || notifications.isEmpty) {
    //       emit(NotificationEmpty());
    //     } else {
    //       final prefs = await SharedPreferences.getInstance();
    //       final lastSeen = prefs.getInt('lastSeenCount') ?? 0;
    //       final currentCount = notifications.length;

    //       emit(NotificationSuccess(notifications));
    //       emit(NotificationBadgeState(
    //           currentCount: currentCount, lastSeenCount: lastSeen));
    //     }
    //   } catch (e) {
    //     emit(NotificationError(e.toString()));
    //   }
    // });

    on<GetNotificationEvent>((event, emit) async {
      try {
        final notifications = await notificationService.getAllNotifications();
        if (notifications == null || notifications.isEmpty) {
          emit(NotificationEmpty());
        } else
          emit(NotificationSuccess(notifications));
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });
    on<DeleteAllNotifications>((event, emit) async {
      try {
        final success = await notificationService.deleteAllNotifications();
        if (success) {
          emit(NotificationDeleteSuccess("Success"));
        } else {
          emit(NotificationError("Error"));
        }
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });

    on<DeleteNotificationById>((event, emit) async {
      try {
        final success =
            await notificationService.deleteNotificationById(event.id);
        if (success) {
          emit(NotificationDeleteSuccess("Success"));
        } else {
          emit(NotificationError("Error"));
        }
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });

    // on<UpdateLastSeenNotifications>((event, emit) async {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setInt('lastSeenCount', event.lastSeen);

    //   final currentCount = state is NotificationBadgeState
    //       ? (state as NotificationBadgeState).currentCount
    //       : 0;

    //   emit(NotificationBadgeState(
    //       currentCount: currentCount, lastSeenCount: event.lastSeen));
    // });
  }
}
