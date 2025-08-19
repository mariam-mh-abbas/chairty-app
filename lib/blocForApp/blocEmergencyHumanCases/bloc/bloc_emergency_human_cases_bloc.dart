import 'package:bloc/bloc.dart';
import 'package:charity_project/model/EmergencyHumanCasesModel.dart';
import 'package:charity_project/service/EmergencyCasesService.dart';
import 'package:charity_project/service/HelpRequestService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'bloc_emergency_human_cases_event.dart';
part 'bloc_emergency_human_cases_state.dart';

class BlocEmergencyHumanCasesBloc extends Bloc<BlocEmergencyHumanCasesEvent, BlocEmergencyHumanCasesState> {
  Emergencycasesservice emergencycasesservice =Emergencycasesservice();
  BlocEmergencyHumanCasesBloc() : super(BlocEmergencyHumanCasesInitial()) {
    on<FetchEmergencyHumanCases>((event, emit) async{
     

      try {
         emit(BlocEmergencyHumanCasesLoading());
 
  var result = await emergencycasesservice.getemergencycases();
  if (result != null) {
      List <Emergencyhumancasesmodel> emergencyCases = [];
    for (var i = 0; i < result.length; i++) {
      Emergencyhumancasesmodel emergencyCasesdata = Emergencyhumancasesmodel.fromMap(result[i]);
      emergencyCases.add(emergencyCasesdata);
    
    }
     emit(BlocEmergencyHumanCasesLoaded(emergencyCases));
  }
   else {
        emit(BlocEmergencyHumanCasesError("Failed to fetch emergencyCases"));
      }
}  catch (e) {
  print("emergency cases Fetch Error: $e"); 
  emit(BlocEmergencyHumanCasesError("حدث خطأ أثناء جلب الحملات: $e"));
}

    }
    
    
    
    );
  }
}
