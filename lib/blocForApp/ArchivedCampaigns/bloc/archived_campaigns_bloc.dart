import 'package:bloc/bloc.dart';
import 'package:charity_project/model/ArchivedCampaignsModel.dart';
import 'package:charity_project/service/ArchivedCampaignsService.dart';
import 'package:meta/meta.dart';

part 'archived_campaigns_event.dart';
part 'archived_campaigns_state.dart';

class ArchivedCampaignsBloc extends Bloc<ArchivedCampaignsEvent, ArchivedCampaignsState> {
  Archivedcampaignsservice archivedcampaignsservice =Archivedcampaignsservice();
  ArchivedCampaignsBloc() : super(ArchivedCampaignsInitial()) {
    on<FetchArchivedCampaigns>((event, emit) async {
      try {
         emit(ArchivedCampaignsLoading());
         var result = await archivedcampaignsservice.getArchivedCampaigns();
        if (result != null) {
        List<ArchivedCampaignsModel> campaigns = [];
        for (var i = 0; i < result.length; i++) {
          ArchivedCampaignsModel campaign = ArchivedCampaignsModel.fromMap(result[i]);
          campaigns.add(campaign);
          
        }
        emit(ArchivedCampaignsLoaded(campaigns));
        }
        else{
          emit(ArchivedCampaignsError("unable to fetcch archived campaigns"));
        }
      } catch (e) {
        print("${e}");
      }
    });
  }
}
