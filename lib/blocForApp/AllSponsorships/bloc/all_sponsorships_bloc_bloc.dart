import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:charity_project/model/SponsorshipModel.dart';


import 'package:charity_project/service/AllSponsorshipsService.dart';
import 'package:meta/meta.dart';

part 'all_sponsorships_bloc_event.dart';
part 'all_sponsorships_bloc_state.dart';

class AllSponsorshipsBlocBloc extends Bloc<AllSponsorshipsBlocEvent, AllSponsorshipsBlocState> {
  Allsponsorshipsservice allsponsorshipsservice = Allsponsorshipsservice();
  AllSponsorshipsBlocBloc() : super(AllSponsorshipsBlocInitial()) {
    on<FetchAllSponsorships>((event, emit) async{
      try {
        emit(AllSponsorshipsBlocLoading());
        var result = await allsponsorshipsservice.getAllSponsorships();
        if (result !=null) {
          List <SponsorshipModel> allsponsorships = [];
          for (var i = 0; i < result.length; i++) {
            SponsorshipModel allSponsorshipsmodel = SponsorshipModel.fromMap(result[i]);
            allsponsorships.add(allSponsorshipsmodel);
            emit(AllSponsorshipsBlocLoaded(allsponsorships));
          }
        }
        else {
          emit (AllSponsorshipsBlocError(e.toString()));
        }
      } catch (e) {
         emit (AllSponsorshipsBlocError(e.toString()));
      }
    });
  }
}
