part of 'contact_us_bloc.dart';

@immutable
sealed class ContactUsEvent {}

class SendMessageEvent extends ContactUsEvent {
  final String phone;
  final String message;

  SendMessageEvent({required this.phone, required this.message});
}
