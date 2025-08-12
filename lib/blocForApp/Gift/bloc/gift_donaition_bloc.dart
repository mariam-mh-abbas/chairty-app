import 'package:bloc/bloc.dart';
import 'package:charity_project/model/GiftModel.dart';
import 'package:charity_project/service/GiftDonaitionService.dart';
import 'package:flutter/physics.dart';
import 'package:meta/meta.dart';

part 'gift_donaition_event.dart';
part 'gift_donaition_state.dart';

class GiftDonaitionBloc extends Bloc<GiftDonaitionEvent, GiftDonaitionState> {
Giftdonaitionservice giftdonaitionservice = Giftdonaitionservice();
  GiftDonaitionBloc() : super(GiftDonaitionInitial()) {
  
    on<DonateAsGift>((event, emit) async{
        emit(GiftDonaitionProcess());
      try {
        bool IsDonated = await giftdonaitionservice.GiftDonaition(event.gift);
        if (IsDonated) {
          emit(GiftDonaitionSuccess("Thank you for your donaition!"));
          print("Success");
        }
        else{
          emit(GiftDonaitionError("You Dont Have enough money in your account"));
        }
      } catch (e) {
        emit(GiftDonaitionError("Something went wrong: $e"));
      }
    });
  }
}

