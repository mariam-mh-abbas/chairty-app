part of 'archived_humancases_bloc.dart';

@immutable
sealed class ArchivedHumancasesState {}

final class ArchivedHumancasesInitial extends ArchivedHumancasesState {}
final class ArchivedHumancasesLoading extends ArchivedHumancasesState {}
final class ArchivedHumancasesLoaded extends ArchivedHumancasesState {
    final List <ArchivedHumanCasesModel> ArchivedHumanCases ;
ArchivedHumancasesLoaded(this.ArchivedHumanCases);
}
final class ArchivedHumancasesError extends ArchivedHumancasesState {
    final  String ErrorMsg;
  ArchivedHumancasesError(this.ErrorMsg);
}
