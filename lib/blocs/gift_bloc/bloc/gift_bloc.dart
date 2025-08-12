import 'package:bloc/bloc.dart';
import 'package:charity_project/models/gift_model.dart';
import 'package:charity_project/services/gift_service.dart';
import 'package:meta/meta.dart';

part 'gift_event.dart';
part 'gift_state.dart';

class GiftBloc extends Bloc<GiftEvent, GiftState> {
  final GiftService giftService;
  GiftBloc(this.giftService) : super(GiftInitial()) {
    on<GetGiftEvent>((event, emit) async {
      emit(GiftLoading());
      try {
        final gifts = await giftService.getAllGifts();

        if (gifts == null || gifts.isEmpty) {
          emit(GiftEmpty());
        } else {
          emit(GiftSuccess(gifts));
        }
      } catch (e) {
        emit(GiftError(e.toString()));
      }
    });
  }
}
