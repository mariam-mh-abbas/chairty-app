import 'package:bloc/bloc.dart';
import 'package:charity_project/model/PeriodicallyDonaitionModel.dart';
import 'package:charity_project/service/PeriodicallyDonaitionService.dart';
import 'package:meta/meta.dart';

part 'periodically_donaition_event.dart';
part 'periodically_donaition_state.dart';

class PeriodicallyDonaitionBloc extends Bloc<PeriodicallyDonaitionEvent, PeriodicallyDonaitionState> {
 Periodicallydonaitionservice periodicallydonaitionservice =  Periodicallydonaitionservice();
  PeriodicallyDonaitionBloc() : super(PeriodicallyDonaitionInitial()) {
    on<DonaitePeriodically>((event, emit) async {
      try {
        emit(PeriodicallyDonaitionProcess());
       bool isSuccess = await periodicallydonaitionservice.periodicallydonaition(event.periodicallydonaitionitem);
       if (isSuccess) {
         emit(PeriodicallyDonaitionSuccess());
         print("Success");
       } else {
        emit(PeriodicallyDonaitionError("Failed")) ;
        
       }
      } catch (e) {
        emit(PeriodicallyDonaitionError(e.toString())) ;
      }
    });
  }
}
