part of 'bloc_cart_bloc.dart';

@immutable
sealed class BlocCartEvent {}
class AddToCart extends BlocCartEvent{
  final CartItemModel cartItem;

  AddToCart(this.cartItem);
}
class DeleteFromCart extends BlocCartEvent{
  final int cartItemDeleted;

  DeleteFromCart(this.cartItemDeleted);
}
class ClearCart extends BlocCartEvent{}
