part of 'all_human_cases_bloc.dart';

@immutable
sealed class AllHumanCasesState {}

final class AllHumanCasesInitial extends AllHumanCasesState {}
final class AllHumanCasesLoading extends AllHumanCasesState {}
final class AllHumanCasesLoaded extends AllHumanCasesState {
  List <AllHumancasesmodel> humanCasemodel;
AllHumanCasesLoaded(this.humanCasemodel);
}
final class AllHumanCasesError extends AllHumanCasesState {
final  String ErrorMsg;

  AllHumanCasesError(this.ErrorMsg);
}