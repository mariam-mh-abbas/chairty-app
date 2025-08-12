import 'package:bloc/bloc.dart';
import 'package:charity_project/models/help_details_model.dart';
import 'package:charity_project/models/request_model.dart';
import 'package:charity_project/models/volunteer_details_model.dart';
import 'package:charity_project/services/request_service.dart';
import 'package:meta/meta.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final RequestService requestService;

  RequestBloc(this.requestService) : super(RequestInitial()) {
    on<HelpRequestEvent>((event, emit) async {
      emit(RequestLoading());
      try {
        final requests = await requestService.getAllUserHelpRequests();
        if (requests == null || requests.isEmpty) {
          emit(RequestEmpty());
        } else
          emit(RequestSuccess(requests));
      } catch (e) {
        emit(RequestError(e.toString()));
      }
    });
    on<VolunteerRequestEvent>((event, emit) async {
      emit(RequestLoading());
      try {
        final requests = await requestService.getAllUserVolunteerRequests();
        if (requests == null || requests.isEmpty) {
          emit(RequestEmpty());
        } else
          emit(RequestSuccess(requests));
      } catch (e) {
        emit(RequestError(e.toString()));
      }
    });
    on<VolunteerRequestDetailsEvent>((event, emit) async {
      emit(RequestLoading());
      try {
        final detail =
            await requestService.fetchRequestvolunteerDetails(event.requestId);
        if (detail != null) {
          emit(VolunteerRequestDetailSuccess(detail));
        } else {
          emit(RequestError('No data'));
        }
      } catch (e) {
        emit(RequestError(e.toString()));
      }
    });
    on<HelpRequestDetailsEvent>((event, emit) async {
      emit(RequestLoading());
      try {
        final detail =
            await requestService.fetchRequestHelpDetails(event.requestId);
        if (detail != null) {
          emit(HelpRequestDetailSuccess(detail));
        } else {
          emit(RequestError('No data'));
        }
      } catch (e) {
        emit(RequestError(e.toString()));
      }
    });
  }
}
