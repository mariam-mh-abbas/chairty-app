part of 'contact_us_bloc.dart';

@immutable
sealed class ContactUsState {}

final class ContactUsInitial extends ContactUsState {}

class MessageLoading extends ContactUsState {}

class MessageSuccess extends ContactUsState {
  final String responseMessage;

  MessageSuccess({required this.responseMessage});
}

class MessageFailure extends ContactUsState {
  final String error;

  MessageFailure({required this.error});
}
