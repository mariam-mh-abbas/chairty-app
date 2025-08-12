import 'package:bloc/bloc.dart';
import 'package:charity_project/models/recharge_model.dart';
import 'package:charity_project/services/get_my_recharges_service.dart';
import 'package:meta/meta.dart';

part 'recharge_event.dart';
part 'recharge_state.dart';

class RechargeBloc extends Bloc<RechargeEvent, RechargeState> {
  final RechargeService rechargeService;
  RechargeBloc(this.rechargeService) : super(RechargeInitial()) {
    on<GetRechargeEvent>((event, emit) async {
      emit(RechargeLoading());
      try {
        final recharges = await rechargeService.getMyRecharge();
        if (recharges == null || recharges.isEmpty) {
          emit(RechargeEmpty());
        } else
          emit(RechargeSuccess(recharges));
      } catch (e) {
        emit(RechargetError(e.toString()));
      }
    });
  }
}
