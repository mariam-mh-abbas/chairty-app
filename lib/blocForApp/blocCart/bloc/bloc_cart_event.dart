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
class SaveCart extends BlocCartEvent{
  final String? userId;

  SaveCart(this.userId);

  
}
class LoadCart extends BlocCartEvent{
  final String? userId;

  LoadCart(this.userId);
}
class ClearCart extends BlocCartEvent{}
class LoggedOut extends BlocCartEvent{}
