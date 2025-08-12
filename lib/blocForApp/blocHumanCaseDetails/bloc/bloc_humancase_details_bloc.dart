import 'package:bloc/bloc.dart';
import 'package:charity_project/model/DetailsHumannCasesModel.dart';
import 'package:charity_project/service/GetCampaignDetailsService.dart';
import 'package:charity_project/service/GetHumanCaseDetailsService.dart';
import 'package:meta/meta.dart';

part 'bloc_humancase_details_event.dart';
part 'bloc_humancase_details_state.dart';

class BlocHumancaseDetailsBloc extends Bloc<BlocHumancaseDetailsEvent, BlocHumancaseDetailsState> {
  Gethumancasedetailsservice gethumancasedetailsservice = Gethumancasedetailsservice();
  BlocHumancaseDetailsBloc() : super(HumancaseDetailsInitial()) {
    on<FetchHumancaseDetailsEvent>((event, emit)async {
      try {
        emit(HumancaseDetailsLoading());
        var result = await gethumancasedetailsservice.gethumancasedetailsservice(id: event.id);
        if (result != null) {
          Detailshumanncasesmodel detailshumanncases = Detailshumanncasesmodel.fromMap(result);
          emit(HumancaseDetailsLoaded(detailshumanncases));
        } else {
          emit(HumancaseDetailsError("unable to fetch humanCase details"));
        }
      } catch (e) {
        emit(HumancaseDetailsError(e.toString()));
        
      }
    }
    );
  }
}
