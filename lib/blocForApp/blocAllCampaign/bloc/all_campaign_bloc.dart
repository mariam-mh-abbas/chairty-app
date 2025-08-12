import 'package:bloc/bloc.dart';
import 'package:charity_project/model/AllCampaignModel.dart';
import 'package:charity_project/service/AllCampaignsService.dart';
import 'package:charity_project/service/HelpRequestService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'all_campaign_event.dart';
part 'all_campaign_state.dart';

class AllCampaignBloc extends Bloc<AllCampaignEvent, AllCampaignState> {
  Allcampaignsservice allcampaignsservice =Allcampaignsservice();
  AllCampaignBloc() : super(AllCampaignInitial()) {
    on<FetchAllCampaign>((event, emit) async {
     
      try {
         emit(AllCampaignLoading());
         var result = await allcampaignsservice.getAllCampaigns();
        if (result != null) {
        List<Allcampaignmodel> campaigns = [];
        for (var i = 0; i < result.length; i++) {
          Allcampaignmodel campaign = Allcampaignmodel.fromMap(result[i]);
          campaigns.add(campaign);
          
        }
        emit(AllCampaignLoaded(campaigns));
        }
        else{
          emit(AllCampaignError("unable to fetcch all campaigns"));
        }
      } catch (e) {
        print("${e}");
      }
    });
  }
}
