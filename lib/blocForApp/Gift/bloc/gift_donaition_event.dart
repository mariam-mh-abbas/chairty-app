part of 'gift_donaition_bloc.dart';

@immutable
sealed class GiftDonaitionEvent {}
final class DonateAsGift extends GiftDonaitionEvent{
final  Giftmodel gift;

  DonateAsGift(this.gift);
}