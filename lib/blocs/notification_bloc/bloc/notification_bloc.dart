import 'package:bloc/bloc.dart';
import 'package:charity_project/models/volunteering_model.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<GetNotificationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
