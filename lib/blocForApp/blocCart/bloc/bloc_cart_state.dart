
part of 'bloc_cart_bloc.dart';

@immutable
sealed class BlocCartState {}

final class BlocCartInitial extends BlocCartState {}
class CartLoading extends BlocCartState {}
class CartLoaded extends BlocCartState {
  final List<CartItemModel> cartitems;

  CartLoaded(this.cartitems);
}
final class AddedToCart extends BlocCartState {}

final class DeletedFromCart extends BlocCartState {}

final class ClearedCart extends BlocCartState {}
