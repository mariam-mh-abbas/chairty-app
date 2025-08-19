import 'package:bloc/bloc.dart';
import 'package:charity_project/models/reports_model.dart';
import 'package:charity_project/services/reports_service.dart';
import 'package:meta/meta.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final ReportService reportService;
  ReportsBloc(this.reportService) : super(ReportsInitial()) {
    on<GetReportsEvent>((event, emit) async {
      try {
        final reports = await reportService.GetReports();
        if (reports == null || reports.isEmpty) {
          emit(ReportsEmpty());
        } else
          emit(ReportsSuccess(reports));
      } catch (e) {
        emit(ReportsError(e.toString()));
      }
    });
  }
}
