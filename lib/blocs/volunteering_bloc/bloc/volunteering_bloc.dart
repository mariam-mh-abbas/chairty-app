import 'package:bloc/bloc.dart';
import 'package:charity_project/models/volunteering_model.dart';
import 'package:charity_project/services/volunteering_service.dart';
import 'package:meta/meta.dart';

part 'volunteering_event.dart';
part 'volunteering_state.dart';

class VolunteeringBloc extends Bloc<VolunteeringEvent, VolunteeringState> {
  final VolunteeringService volunteeringService;
  VolunteeringBloc(this.volunteeringService) : super(VolunteeringInitial()) {
    on<GetVolunteeringEvent>((event, emit) async {
      try {
        final volunteerings = await volunteeringService.GetVolunteering();
        if (volunteerings == null || volunteerings.isEmpty) {
          emit(VolunteeringEmpty());
        } else
          emit(VolunteeringSuccess(volunteerings));
      } catch (e) {
        emit(VolunteeringError(e.toString()));
      }
    });
  }
}
