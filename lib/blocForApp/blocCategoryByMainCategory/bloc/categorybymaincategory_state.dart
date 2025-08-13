part of 'categorybymaincategory_bloc.dart';

@immutable
sealed class CategorybymaincategoryState {}

final class CategorybymaincategoryInitial extends CategorybymaincategoryState {}
final class CategorybymaincategoryLoading extends CategorybymaincategoryState {}
final class CategorybymaincategoryLoaded extends CategorybymaincategoryState {
  final List <Categorybymaincategorymodel> categorybymaincategory ;
  String mainCategory;
  CategorybymaincategoryLoaded (this.categorybymaincategory,this.mainCategory);
}
final class CategorybymaincategoryError extends CategorybymaincategoryState {
  String ErrorMsg;
CategorybymaincategoryError(this.ErrorMsg);
}
