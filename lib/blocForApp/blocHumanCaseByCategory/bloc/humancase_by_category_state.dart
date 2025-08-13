part of 'humancase_by_category_bloc.dart';

@immutable
sealed class HumancaseByCategoryState {}

final class HumancaseByCategoryInitial extends HumancaseByCategoryState {}
final class HumancaseByCategoryLoading extends HumancaseByCategoryState {}
final class HumancaseByCategoryLoaded extends HumancaseByCategoryState {
 final List<Humancasebycategorymodel> humancasebycategory;

  HumancaseByCategoryLoaded(this.humancasebycategory);
}
final class HumancaseByCategoryError extends HumancaseByCategoryState {
final String ErrorMsg;

  HumancaseByCategoryError(this.ErrorMsg);
}