import 'package:bloc/bloc.dart';
import 'package:charity_project/model/InKindCategoryModel.dart';
import 'package:charity_project/service/InKindDonaitionService.dart';
import 'package:meta/meta.dart';

part 'in_kind_donaition_event.dart';
part 'in_kind_donaition_state.dart';

class InKindDonaitionBloc extends Bloc<InKindDonaitionEvent, InKindDonaitionState> {
  Inkinddonaitionservice inkinddonaitionservice = Inkinddonaitionservice();
  InKindDonaitionBloc() : super(InKindDonaitionInitial())  {
    on<donateInKind>((event, emit) async {
      try {
        emit(InKindDonaitionProcess());
        bool result = await inkinddonaitionservice.InKindDonaition(event.inkindItem);
        if (result) {
          emit(InKindDonaitionSuccess("Success"));
        }
        else{emit(InKindDonaitionError("Failed"));}
          
        
      } catch (e) {
        emit(InKindDonaitionError(e.toString()));
      }
    });
  }
}
