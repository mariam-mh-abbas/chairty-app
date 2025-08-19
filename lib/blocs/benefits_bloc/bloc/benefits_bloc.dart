import 'package:bloc/bloc.dart';
import 'package:charity_project/models/benefits_model.dart';
import 'package:charity_project/services/benefits_service.dart';
import 'package:meta/meta.dart';

part 'benefits_event.dart';
part 'benefits_state.dart';

class BenefitsBloc extends Bloc<BenefitsEvent, BenefitsState> {
  final BenefitsService benefitsService;
  BenefitsBloc(this.benefitsService) : super(BenefitsInitial()) {
    on<GetBenefitsEvent>((event, emit) async {
      try {
        final benefits = await benefitsService.GetBenefits();
        if (benefits == null || benefits.isEmpty) {
          emit(BenefitsEmpty());
        } else
          emit(BenefitsSuccess(benefits));
      } catch (e) {
        emit(BenefitsError(e.toString()));
      }
    });
  }
}
