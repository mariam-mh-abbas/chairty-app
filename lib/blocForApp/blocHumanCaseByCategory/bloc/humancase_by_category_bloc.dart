import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:charity_project/blocForApp/blocCampaignByCategory/bloc/campaign_by_category_id_bloc.dart';
import 'package:charity_project/model/HumanCaseByCategoryModel.dart';
import 'package:charity_project/model/HumanCasesModel.dart';
import 'package:charity_project/service/HumanCasesByCategoryService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'humancase_by_category_event.dart';
part 'humancase_by_category_state.dart';

class HumancaseByCategoryBloc extends Bloc<HumancaseByCategoryEvent, HumancaseByCategoryState> {
  Humancasesbycategoryservice humancasesbycategoryservice = Humancasesbycategoryservice();
  HumancaseByCategoryBloc() : super(HumancaseByCategoryInitial()) {
    on<FetchHumancaseByCategoryEvent>((event, emit)async {
       emit(HumancaseByCategoryLoading());
    
      try {
  emit(HumancaseByCategoryLoading());
  var result = await humancasesbycategoryservice.getHumanCaseByCategory(event.id);
  if (result != null) {
    List <Humancasebycategorymodel> humancasebycategory = [];
    for (var i = 0; i < result.length; i++) {
      Humancasebycategorymodel humancasebycategorymodeldata = Humancasebycategorymodel.fromMap(result[i]);
      humancasebycategory.add(humancasebycategorymodeldata);
    
    }
     emit(HumancaseByCategoryLoaded(humancasebycategory));
  } else {
    
    emit(HumancaseByCategoryError(e.toString()));
  }
}  catch (e) {
  emit(HumancaseByCategoryError(e.toString()));
}
      
    });
  }
}
