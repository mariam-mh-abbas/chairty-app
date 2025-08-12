part of 'gift_bloc.dart';

@immutable
sealed class GiftState {}

final class GiftInitial extends GiftState {}

class GiftLoading extends GiftState {}

class GiftSuccess extends GiftState {
  final List<GiftModel> gifts;

  GiftSuccess(this.gifts);
}

class GiftError extends GiftState {
  final String message;

  GiftError(this.message);
}

class GiftEmpty extends GiftState {}
