import 'package:bloc/bloc.dart';
import 'package:charity_project/models/sponsorships_model.dart';
import 'package:charity_project/services/sponsorships_service.dart';
import 'package:meta/meta.dart';

part 'sponsorships_event.dart';
part 'sponsorships_state.dart';

class SponsorshipsBloc extends Bloc<SponsorshipsEvent, SponsorshipsState> {
  final SponsorshipsService sponsorshipsService;
  SponsorshipsBloc(this.sponsorshipsService) : super(SponsorshipsInitial()) {
    on<GetSponsorshipEvent>((event, emit) async {
      try {
        final sponsorships = await sponsorshipsService.GetSponsorships();
        if (sponsorships == null || sponsorships.isEmpty) {
          emit(SponsorshipEmpty());
        } else
          emit(SponsorshipSuccess(sponsorships));
      } catch (e) {
        emit(SponsorshipError(e.toString()));
      }
    });
    on<DeactivateSponsorshipEvent>((event, emit) async {
      emit(SponsorshipLoading());
      try {
        final success = await sponsorshipsService.deactivatePlan(event.planId);
        if (success) {
          final plans = await sponsorshipsService.GetSponsorships();
          if (plans == null || plans.isEmpty) {
            emit(SponsorshipEmpty());
          } else {
            emit(SponsorshipActionSuccess());
            emit(SponsorshipSuccess(plans));
          }
        } else {
          emit(SponsorshipError('Failed to deactivate plan'));
        }
      } catch (e) {
        emit(SponsorshipError(e.toString()));
      }
    });

    on<ReactivateSponsorshipEvent>((event, emit) async {
      emit(SponsorshipLoading());
      try {
        final success = await sponsorshipsService.reactivatePlan(event.planId);
        if (success) {
          final plans = await sponsorshipsService.GetSponsorships();
          if (plans == null || plans.isEmpty) {
            emit(SponsorshipEmpty());
          } else {
            emit(SponsorshipActionSuccess());
            emit(SponsorshipSuccess(plans));
          }
        } else {
          emit(SponsorshipError('Failed to reactivate plan'));
        }
      } catch (e) {
        emit(SponsorshipError(e.toString()));
      }
    });
  }
}
