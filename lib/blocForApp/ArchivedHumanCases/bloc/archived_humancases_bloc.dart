import 'package:bloc/bloc.dart';
import 'package:charity_project/model/ArchivedHumanCasesModel.dart';
import 'package:charity_project/service/ArchivedHumanCasesService.dart';
import 'package:meta/meta.dart';

part 'archived_humancases_event.dart';
part 'archived_humancases_state.dart';

class ArchivedHumancasesBloc extends Bloc<ArchivedHumancasesEvent, ArchivedHumancasesState> {
    Archivedhumancasesservice archivedhumancasesservice =Archivedhumancasesservice();
  ArchivedHumancasesBloc() : super(ArchivedHumancasesInitial()) {
    on<FetchArchivedHumancases>((event, emit) async {
      try {
         emit(ArchivedHumancasesLoading());
         var result = await archivedhumancasesservice.getArchivedHumanCases();
        if (result != null) {
        List<ArchivedHumanCasesModel> humancases = [];
        for (var i = 0; i < result.length; i++) {
          ArchivedHumanCasesModel humancase = ArchivedHumanCasesModel.fromMap(result[i]);
          humancases.add(humancase);
          
        }
        emit(ArchivedHumancasesLoaded(humancases));
        }
        else{
          emit(ArchivedHumancasesError
          ("unable to fetcch archived campaigns"));
        }
      } catch (e) {
        print("${e}");
      }
    });
  }
}
