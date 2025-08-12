part of 'categorybymaincategory_bloc.dart';

@immutable
sealed class CategorybymaincategoryEvent {}
 class FetchCategoryByMainCategory extends CategorybymaincategoryEvent{
  final String mainCategory;
  FetchCategoryByMainCategory(this.mainCategory);
 }
