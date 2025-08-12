import 'package:bloc/bloc.dart';
import 'package:charity_project/models/in_kind_model.dart';
import 'package:charity_project/models/periodically_model.dart';
import 'package:charity_project/services/donation_service.dart';
import 'package:meta/meta.dart';

part 'donation_event.dart';
part 'donation_state.dart';

class DonationBloc extends Bloc<DonationEvent, DonationState> {
  final DonationService donationService;
  DonationBloc(this.donationService) : super(DonationInitial()) {
    on<DonationInKindEvent>((event, emit) async {
      try {
        final inkinds = await donationService.GetInKindsDonations();
        if (inkinds == null || inkinds.isEmpty) {
          emit(DonationEmpty());
        } else
          emit(DonationInKindSuccess(inkinds));
      } catch (e) {
        emit(DonationError(e.toString()));
      }
    });
    on<DonationPeriodicallyEvent>((event, emit) async {
      try {
        final plans = await donationService.GetPeriodacllyDonations();
        if (plans == null || plans.isEmpty) {
          emit(DonationEmpty());
        } else {
          emit(DonationPeriodicallySuccess(plans));
        }
      } catch (e) {
        emit(DonationError(e.toString()));
      }
    });
    on<DeactivatePlanEvent>((event, emit) async {
      emit(DonationLoading());
      try {
        final updated = await donationService.deactivatePlan(event.planId);
        emit(PlanActionSuccess(updated));

        final plans = await donationService.GetPeriodacllyDonations();
        emit(DonationPeriodicallySuccess(plans ?? []));
      } catch (e) {
        emit(DonationError(e.toString()));
      }
    });

    on<ReactivatePlanEvent>((event, emit) async {
      emit(DonationLoading());
      try {
        final updated = await donationService.reactivatePlan(event.planId);
        emit(PlanActionSuccess(updated));
        final plans = await donationService.GetPeriodacllyDonations();
        emit(DonationPeriodicallySuccess(plans ?? []));
      } catch (e) {
        emit(DonationError(e.toString()));
      }
    });
  }
}
