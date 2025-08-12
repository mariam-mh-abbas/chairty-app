import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'kaffarat_and_sadaqah_counter_event.dart';
part 'kaffarat_and_sadaqah_counter_state.dart';

class KaffaratAndSadaqahCounterBloc extends Bloc<KaffaratAndSadaqahCounterEvent, KaffaratAndSadaqahCounterState> {
  KaffaratAndSadaqahCounterBloc() 
 : super(const KaffaratAndSadaqahCounterState(count: 0, totalAmount: 0))
   {
    
    on<IncrementCounter>((event, emit) {
      final int newCounter = state.count +1;
      final int newtotalAmount = newCounter * event.unitPrice;
      emit(KaffaratAndSadaqahCounterState(count: newCounter, totalAmount: newtotalAmount));
      
    });

    on<DecrementCounter>((event, emit) {
      final int newCounter = state.count >0 ? state.count -1 : 0;
      final int newtotalAmount = newCounter * event.unitPrice;
emit(KaffaratAndSadaqahCounterState(count: newCounter, totalAmount: newtotalAmount));
    });

    on<ResetCounter>((event, emit) {
     emit(KaffaratAndSadaqahCounterState(count: 0, totalAmount: 0));
      
    });
  }
}
