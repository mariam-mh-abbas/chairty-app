import 'package:bloc/bloc.dart';
import 'package:charity_project/services/contact_us_service.dart';
import 'package:meta/meta.dart';

part 'contact_us_event.dart';
part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  final ContactUsService contactUsService;
  ContactUsBloc(this.contactUsService) : super(ContactUsInitial()) {
    on<SendMessageEvent>((event, emit) async {
      emit(MessageLoading());
      try {
        final response = await contactUsService.SendMessage(
          phone: event.phone,
          message: event.message,
        );
        emit(MessageSuccess(responseMessage: response.data['message']));
      } catch (e) {
        emit(MessageFailure(error: e.toString()));
      }
    });
  }
}
