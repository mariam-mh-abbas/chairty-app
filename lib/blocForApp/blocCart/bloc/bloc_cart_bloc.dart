import 'package:bloc/bloc.dart';
import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
import 'package:charity_project/config/service_locater.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bloc_cart_event.dart';
part 'bloc_cart_state.dart';

// class BlocCartBloc extends Bloc<BlocCartEvent, BlocCartState> {
// final List <CartItemModel> cartItems = [];
//   BlocCartBloc() : super(BlocCartInitial()) {
//     loadCartFromStorage();
//     on<AddToCart>((event, emit) async{
//      final index = cartItems.indexWhere((element)=>element.id == event.cartItem.id);
//      if (index != -1) {
//      final updatedItem = cartItems[index].copyWith(
//       Amount: (cartItems[index].Amount ?? 0) + (event.cartItem.Amount ?? 0),
//      );
//      cartItems[index]=updatedItem;
//      } else {
//        cartItems.add(event.cartItem);
//      }
//      await saveCartToStorage();
//      emit(AddedToCart());
//     }
//     );
//    on<DeleteFromCart>((event, emit) async {
//     cartItems.removeWhere((element)=> element.id == event.cartItemDeleted);
//     await saveCartToStorage();
//      emit(DeletedFromCart());
//    });

//    on<ClearCart>((event, emit) async{
//     cartItems.clear();
//     await saveCartToStorage();
//      emit(ClearedCart());
//    });
//   }
//  List<CartItemModel> getList(){
//  return List.unmodifiable(cartItems);
//   }

//   int get(){
//  return cartItems.fold(0, (sum, item) => sum + (item.Amount ?? 0));
//   }

// // Future<void> saveCartToStorage() async{
// //   final prefs = serviceLocater<SharedPreferences>();
// //    final token = await SharedPrefs.getToken() ?? '';
// //     if (token == null || token.isEmpty) {
    
// //      return;
// //     }
// //     else{
// // final  jsonList = 
// //  cartItems.map((item) => item.toJson()).toList();
// //     await prefs.setStringList('cart_items', jsonList);
// //     }
  
// //   }
// //   Future<void> loadCartFromStorage() async{
// //   final prefs = serviceLocater<SharedPreferences>();
// //   final token = await SharedPrefs.getToken() ?? '';
// //     if (token == null || token.isEmpty) {
// //      cartItems.clear();
// //      await prefs.remove('cart_items');
// //      emit(ClearedCart());
// //      return;
// //     }
// //     else{
// // final List<String>? jsonList = prefs.getStringList('cart_items');
// //   if (jsonList != null) {
// //   cartItems.clear();
// //   cartItems.addAll(jsonList.map((itemJson) => CartItemModel.fromJson(itemJson)));
// //   emit(AddedToCart());
// //   }
// //     }
  
// //   }

// Future<void> saveCartToStorage() async {
//   final prefs = serviceLocater<SharedPreferences>();
//   final token = await SharedPrefs.getToken();

//   if (token == null || token.isEmpty) {
//     // إذا زائر، ما نخزن
//     return;
//   }

//   // أنشئ مفتاح خاص بالمستخدم
//   final key = 'cart_items_user_$token';
//   final jsonList = cartItems.map((item) => item.toJson()).toList();
//   await prefs.setStringList(key, jsonList);
// }

// Future<void> loadCartFromStorage() async {
//   final prefs = serviceLocater<SharedPreferences>();
//   final token = await SharedPrefs.getToken();

//   if (token == null || token.isEmpty) {
//     // إذا زائر، نخلي السلة فاضية لكن ما نمسح من التخزين
//     cartItems.clear();
//     emit(ClearedCart());
//     return;
//   }

//   final key = 'cart_items_user_$token';
//   final List<String>? jsonList = prefs.getStringList(key);
  
//   cartItems.clear();
//   if (jsonList != null) {
//     cartItems.addAll(jsonList.map((itemJson) => CartItemModel.fromJson(itemJson)));
//   }

//   emit(AddedToCart());
// }

// }

class BlocCartBloc extends Bloc<BlocCartEvent, BlocCartState> {
  final List<CartItemModel> cartItems = [];

  BlocCartBloc() : super(BlocCartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<DeleteFromCart>(_onDeleteFromCart);
    on<ClearCart>(_onClearCart);
    on<LoadCart>(_onLoadCart);
    on<SaveCart>(_onSaveCart);
    on<LoggedOut>(_onUserLoggedOut);
  }

  String _getCartKey(String userId) => 'cart_items_user_$userId';

  Future<void> _onAddToCart(AddToCart event, Emitter<BlocCartState> emit) async {
    final index = cartItems.indexWhere((element) => element.id == event.cartItem.id);
    if (index != -1) {
      final updatedItem = cartItems[index].copyWith(
        Amount: (cartItems[index].Amount ?? 0) + (event.cartItem.Amount ?? 0),
      );
      cartItems[index] = updatedItem;
    } else {
      cartItems.add(event.cartItem);
    }
    emit(AddedToCart());
  }

  // Future<void> _onDeleteFromCart(DeleteFromCart event, Emitter<BlocCartState> emit) async {
  //   cartItems.removeWhere((element) => element.id == event.cartItemDeleted);
  //   emit(DeletedFromCart());
  // }
  Future<void> _onDeleteFromCart(DeleteFromCart event, Emitter<BlocCartState> emit) async {
  // احذف العنصر المطلوب من المصفوفة
  cartItems.removeWhere((element) => element.id == event.cartItemDeleted);

  // احفظ التغييرات مباشرة في SharedPreferences
  final prefs = serviceLocater<SharedPreferences>();

  // لازم يكون عندك userId حالي (من السيشن أو من bloc)
  final key = _getCartKey(event.userId ?? "");  

  // حول العناصر المتبقية إلى JSON وخزنها
  final jsonList = cartItems.map((item) => item.toJson()).toList();
  await prefs.setStringList(key, jsonList);

  // Emit حالة نجاح الحذف
  emit(DeletedFromCart());
}

  Future<void> _onClearCart(ClearCart event, Emitter<BlocCartState> emit) async {
    cartItems.clear();
    emit(ClearedCart());
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<BlocCartState> emit) async {
    emit(CartLoading());
    final prefs = serviceLocater<SharedPreferences>();

    if (event.userId == null || event.userId!.isEmpty) {
      // زائر → سلة فاضية
      cartItems.clear();
      emit(ClearedCart());
      return;
    }
   else{
final key = _getCartKey(event.userId!);
    final jsonList = prefs.getStringList(key);
    cartItems.clear();
    if (jsonList != null) {
      cartItems.addAll(jsonList.map((itemJson) => CartItemModel.fromJson(itemJson)));
    }
    emit(CartLoaded(List.unmodifiable(cartItems)));
   }
    
  }

  Future<void> _onSaveCart(SaveCart event, Emitter<BlocCartState> emit) async {
    if (event.userId == null || event.userId!.isEmpty) {
      return; // ما نخزن للزائر
    }
    final prefs = serviceLocater<SharedPreferences>();
    final key = _getCartKey(event.userId!);
    final jsonList = cartItems.map((item) => item.toJson()).toList();
    await prefs.setStringList(key, jsonList);
  }
  int get(){
 return cartItems.fold(0, (sum, item) => sum + (item.Amount ?? 0));
  }
  Future<void> _onUserLoggedOut(LoggedOut event, Emitter<BlocCartState> emit) async {
    cartItems.clear();
    emit(ClearedCart());
  }
}
