import 'package:bloc/bloc.dart';
import 'package:charity_project/model/AllHumanCaseModel.dart';
import 'package:charity_project/model/HumanCasesModel.dart';
import 'package:charity_project/service/AllHumanCasesServices.dart';
import 'package:meta/meta.dart';

part 'all_human_cases_event.dart';
part 'all_human_cases_state.dart';

class AllHumanCasesBloc extends Bloc<AllHumanCasesEvent, AllHumanCasesState> {
  Allhumancasesservices allhumancasesservices = Allhumancasesservices();
  AllHumanCasesBloc() : super(AllHumanCasesInitial()) {
    on<FetchAllHumanCases>((event, emit)async {
      try {
       emit(AllHumanCasesLoading()) ;
       var result = await allhumancasesservices.getAllHumanCases();
        if (result != null) {
        List<AllHumancasesmodel> humancases = [];
        for (var i = 0; i < result.length; i++) {
          AllHumancasesmodel humancase = AllHumancasesmodel.fromMap(result[i]);
          humancases.add(humancase);
         
        }
         emit(AllHumanCasesLoaded(humancases));
        }
        else{
          emit(AllHumanCasesError("unable to fetcch all humanCases"));
        }
      } catch (e) {
          emit(AllHumanCasesError(e.toString()));
      }
    });
  }
}
