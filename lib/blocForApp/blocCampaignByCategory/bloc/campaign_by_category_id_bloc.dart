import 'package:bloc/bloc.dart';
import 'package:charity_project/model/AllCampaignModel.dart';
import 'package:charity_project/service/CampaignsByCategoryIdService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../service/HelpRequestService.dart';

part 'campaign_by_category_id_event.dart';
part 'campaign_by_category_id_state.dart';

class CampaignByCategoryIdBloc extends Bloc<CampaignByCategoryIdEvent, CampaignByCategoryIdState> {
  Campaignsbycategoryidservice campaignsbycategoryidservice = Campaignsbycategoryidservice();
  CampaignByCategoryIdBloc() : super(CampaignByCategoryIdInitial()) {
    on<FetchCampaignByCategoryId>((event, emit) async{


try {
       emit(CampaignByCategoryIdLoading());
       var result = await campaignsbycategoryidservice.Getcampaignsbycategoryid(event.categoryId);
        if (result != null) {
        List<Allcampaignmodel> campaigns = [];
        for (var i = 0; i < result.length; i++) {
          Allcampaignmodel campaignsdata = Allcampaignmodel.fromMap(result[i]);
          campaigns.add(campaignsdata);
          emit(CampaignByCategoryIdLoaded(campaigns));
          print(" Campaigns by category Fetched Successfully !!!!!!!!");
        }
        }
        else{
          emit(CampaignByCategoryIdError("unable to fetcch campaigns by id"));
        }
      } 

 catch (e) {
        print("${e}");
      }
    });
  }
}
