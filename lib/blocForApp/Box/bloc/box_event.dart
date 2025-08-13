part of 'box_bloc.dart';

@immutable
sealed class BoxEvent {}
final class FetchBoxData extends BoxEvent {
final  String Type;


  FetchBoxData(this.Type);
}