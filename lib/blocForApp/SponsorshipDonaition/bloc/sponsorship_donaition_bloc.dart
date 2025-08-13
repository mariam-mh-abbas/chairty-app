import 'package:bloc/bloc.dart';
import 'package:charity_project/service/SponsorshipPlanService.dart';

import 'package:meta/meta.dart';

part 'sponsorship_donaition_event.dart';
part 'sponsorship_donaition_state.dart';

class SponsorshipDonaitionBloc extends Bloc<SponsorshipDonaitionEvent, SponsorshipDonaitionState> {
  Sponsorshipplanservice sponsorshipplanservice =Sponsorshipplanservice();
  SponsorshipDonaitionBloc() : super(SponsorshipDonaitionInitial()) {
    on<DonateToSponsorship>((event, emit) async {
      try {
  emit(SponsorshipDonaitionProcess());
  bool isSuccess= await sponsorshipplanservice.sponsorshipdonate(event.SponsorshipId, event.amount);
  if (isSuccess) {
    emit(SponsorshipDonaitionSuccess());
  }
  else{
    emit(SponsorshipDonaitionError("you don't have enouph money in your account"));
  }
} on Exception catch (e) {
  emit(SponsorshipDonaitionError(e.toString()));
}
      
    });
  }
}
