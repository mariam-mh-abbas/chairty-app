import 'package:bloc/bloc.dart';
import 'package:charity_project/model/CampaignHomeModel.dart';

import 'package:charity_project/service/HelpRequestService.dart';
import 'package:charity_project/service/HomeCampaignsService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../model/CampaignHomeModel.dart';

part 'campaign_home_event.dart';
part 'campaign_home_state.dart';

class CampaignHomeBloc extends Bloc<CampaignHomeEvent, CampaignHomeState> {
  Homecampaignsservice homecampaignsservice = Homecampaignsservice();
  CampaignHomeBloc() : super(CampaignHomeInitial()) {
    on<FetchedCampaign>((event, emit) async{
      try {
         emit(CampaignHomeLoading());
  var result = await homecampaignsservice.getHomeCampaigns();
  if (result != null) {
     List <CampaignHomeModel> campaignhome = [];
    for (var i = 0; i < result.length; i++) {
      CampaignHomeModel campaignHomedata = CampaignHomeModel.fromMap(result[i]);
      campaignhome.add(campaignHomedata);
     emit(CampaignHomeLoaded(campaignhome));
    }
  }
 else {
       emit(CampaignHomeError("Failed"));
      }
}  catch (e) {
  print("Campaign Fetch Error: $e"); 
  emit(CampaignHomeError("حدث خطأ أثناء جلب الحملات: $e"));
}

    }
    );
  }
}
