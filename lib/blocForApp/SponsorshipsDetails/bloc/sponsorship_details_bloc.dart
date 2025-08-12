import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:charity_project/model/SponsorshipDetailsModel.dart';
import 'package:charity_project/service/SponsorshipDetailsService.dart';
import 'package:meta/meta.dart';

part 'sponsorship_details_event.dart';
part 'sponsorship_details_state.dart';

class SponsorshipDetailsBloc extends Bloc<SponsorshipDetailsEvent, SponsorshipDetailsState> {
  Sponsorshipdetailsservice sponsorshipdetailsservice = Sponsorshipdetailsservice();
  SponsorshipDetailsBloc() : super(SponsorshipDetailsInitial()) {
    on<FetchSponsorshipDetails>((event, emit) async{
      try {
        emit(SponsorshipDetailsLoading());
        var result = await sponsorshipdetailsservice.getSponsorshipDetails(event.id);
        if (result != null) {
          SponsorshipDetailsmodel sponsorshipDetailsmodel = SponsorshipDetailsmodel.fromMap(result);
          emit(SponsorshipDetailsLoaded(sponsorshipDetailsmodel));
        }
        else{
          emit(SponsorshipDetailsError(e.toString()));
        }
      } catch (e) {
         emit(SponsorshipDetailsError(e.toString()));
      }
    });
  }
}
