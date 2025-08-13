part of 'bloc_humancase_details_bloc.dart';

@immutable
sealed class BlocHumancaseDetailsEvent {}
 class FetchHumancaseDetailsEvent extends BlocHumancaseDetailsEvent {
  final int id;

  FetchHumancaseDetailsEvent(this.id);
 }