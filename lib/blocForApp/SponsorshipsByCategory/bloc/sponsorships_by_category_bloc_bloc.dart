import 'dart:math';

import 'package:bloc/bloc.dart';

import 'package:charity_project/model/SponsorshipModel.dart';
import 'package:charity_project/service/SponsorshipsByCategoryService.dart';
import 'package:meta/meta.dart';

part 'sponsorships_by_category_bloc_event.dart';
part 'sponsorships_by_category_bloc_state.dart';

class SponsorshipsByCategoryBlocBloc extends Bloc<SponsorshipsByCategoryBlocEvent, SponsorshipsByCategoryBlocState> {
  Sponsorshipsbycategoryservice  sponsorshipsbycategoryservice =Sponsorshipsbycategoryservice();
  SponsorshipsByCategoryBlocBloc() : super(SponsorshipsByCategoryBlocInitial()) {

    on<FetchSponsorshipsByCategory>((event, emit)async {
       try {
        emit(SponsorshipsByCategoryBlocLoading());
        var result = await sponsorshipsbycategoryservice.GetSponsorshipsbycategory(event.id);
        if (result !=null) {
          List <SponsorshipModel> sponsorshipsbycategory = [];
          for (var i = 0; i < result.length; i++) {
            SponsorshipModel sponsorshipsbycategorydata = SponsorshipModel.fromMap(result[i]);
            sponsorshipsbycategory.add(sponsorshipsbycategorydata);
            emit(SponsorshipsByCategoryBlocLoaded(sponsorshipsbycategory));
          }
        }
        else {
          emit (SponsorshipsByCategoryBlocError(e.toString()));
        }
      } catch (e) {
          emit (SponsorshipsByCategoryBlocError(e.toString()));
      }
    });
  }
}
