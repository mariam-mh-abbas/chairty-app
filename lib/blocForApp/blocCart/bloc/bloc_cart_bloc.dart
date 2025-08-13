import 'package:bloc/bloc.dart';
import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
import 'package:charity_project/config/service_locater.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bloc_cart_event.dart';
part 'bloc_cart_state.dart';

class BlocCartBloc extends Bloc<BlocCartEvent, BlocCartState> {
final List <CartItemModel> cartItems = [];
  BlocCartBloc() : super(BlocCartInitial()) {
    loadCartFromStorage();
    on<AddToCart>((event, emit) async{
     final index = cartItems.indexWhere((element)=>element.id == event.cartItem.id);
     if (index != -1) {
     final updatedItem = cartItems[index].copyWith(
      Amount: (cartItems[index].Amount ?? 0) + (event.cartItem.Amount ?? 0),
     );
     cartItems[index]=updatedItem;
     } else {
       cartItems.add(event.cartItem);
     }
     await saveCartToStorage();
     emit(AddedToCart());
    }
    );
   on<DeleteFromCart>((event, emit) async {
    cartItems.removeWhere((element)=> element.id == event.cartItemDeleted);
    await saveCartToStorage();
     emit(DeletedFromCart());
   });

   on<ClearCart>((event, emit) async{
    cartItems.clear();
    await saveCartToStorage();
     emit(ClearedCart());
   });
  }
 List<CartItemModel> getList(){
 return List.unmodifiable(cartItems);
  }

  int get(){
 return cartItems.fold(0, (sum, item) => sum + (item.Amount ?? 0));
  }

Future<void> saveCartToStorage() async{
  final prefs = serviceLocater<SharedPreferences>();
  final  jsonList = 
 cartItems.map((item) => item.toJson()).toList();
    await prefs.setStringList('cart_items', jsonList);
  }
  Future<void> loadCartFromStorage() async{
  final prefs = serviceLocater<SharedPreferences>();
  final List<String>? jsonList = prefs.getStringList('cart_items');
  if (jsonList != null) {
  cartItems.clear();
  cartItems.addAll(jsonList.map((itemJson) => CartItemModel.fromJson(itemJson)));
  emit(AddedToCart());
  }
  }
}

