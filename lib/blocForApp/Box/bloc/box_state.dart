part of 'box_bloc.dart';

@immutable
sealed class BoxState {}

final class BoxInitial extends BoxState {}
final class BoxLoading extends BoxState {}
final class BoxLoaded extends BoxState {
  final BoxModel box ;

  BoxLoaded(this.box);
}
final class BoxError extends BoxState {
final  String ErrorMsg;

  BoxError(this.ErrorMsg);
}
