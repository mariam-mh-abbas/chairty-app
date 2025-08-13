import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:charity_project/model/BoxModel.dart';
import 'package:charity_project/service/BoxService.dart';
import 'package:meta/meta.dart';

part 'box_event.dart';
part 'box_state.dart';

class BoxBloc extends Bloc<BoxEvent, BoxState> {
  Boxservice boxservice = Boxservice();
  BoxBloc() : super(BoxInitial()) {
    on<FetchBoxData>((event, emit) async{
      try {
        emit(BoxLoading());
        var result = await boxservice.GetBox(event.Type );
        if (result!=null) {
          BoxModel boxModel = BoxModel.fromMap(result);
          emit(BoxLoaded(boxModel));
        }
        else{
          emit(BoxError(e.toString()));
        }
      } catch (e) {
         emit(BoxError(e.toString()));
      }
    });
  }
}
