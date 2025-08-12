import 'package:bloc/bloc.dart';
import 'package:charity_project/model/DetailsCampaignModel.dart';
import 'package:charity_project/service/GetCampaignDetailsService.dart';
import 'package:meta/meta.dart';

part 'bloc_details_campaign_event.dart';
part 'bloc_details_campaign_state.dart';

class BlocDetailsCampaignBloc extends Bloc<BlocDetailsCampaignEvent, BlocDetailsCampaignState> {
  Getcampaigndetailsservice campaignDetails = Getcampaigndetailsservice();
  BlocDetailsCampaignBloc() : super(BlocDetailsCampaignInitial()) {
    on<FetchDetailsCampaignEvent>((event, emit) async {
     try {
       emit(BlocDetailsCampaignLoading());
     var  result = await campaignDetails.Getcampaigndetails(id: event.id);
     if (result !=null) {
       DetailsCampaignModel detailsCampaignModel = DetailsCampaignModel.fromMap(result);
       emit(BlocDetailsCampaignLoaded(detailsCampaignModel));
     } else {
         emit(BlocDetailsCampaignError("error"));
     }
     
     } catch (e) {
       emit(BlocDetailsCampaignError("error"));
     }

    });
  }
}
