import 'package:bloc/bloc.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:charity_project/model/OncePaymentModel.dart';
import 'package:charity_project/service/oncePaymentService.dart';
import 'package:meta/meta.dart';

part 'once_payment_event.dart';
part 'once_payment_state.dart';

class OncePaymentBloc extends Bloc<OncePaymentEvent, OncePaymentState> {
  Oncepaymentservice oncepaymentservice = Oncepaymentservice();
  OncePaymentBloc() : super(OncePaymentInitial()) {
    on<OncePayment>((event, emit) async{
     emit(OncePaymentProcess()) ;
     try {
  final body = {
          "donations": event.payedItems.map((e) => e.toMap()).toList()
        };
   
   
          bool result = await oncepaymentservice.oncepaymentmethod(body);
          if (result) {
            emit(OncePaymentSuccess("Success"));
            print("Success");
          } else {
            emit(OncePaymentFailure("Failed"));
          }
} on Exception catch (e) {
   emit(OncePaymentFailure(e.toString()));
}
    });
  }
}
