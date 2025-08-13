part of 'humancase_by_category_bloc.dart';

@immutable
sealed class HumancaseByCategoryEvent {}
class FetchHumancaseByCategoryEvent extends HumancaseByCategoryEvent{
  final int id;

  FetchHumancaseByCategoryEvent(this.id);
}