part of 'bloc_emergency_human_cases_bloc.dart';

@immutable
sealed class BlocEmergencyHumanCasesState {}

final class BlocEmergencyHumanCasesInitial extends BlocEmergencyHumanCasesState {}
final class BlocEmergencyHumanCasesLoading extends BlocEmergencyHumanCasesState {}
final class BlocEmergencyHumanCasesLoaded extends BlocEmergencyHumanCasesState {
  final List <Emergencyhumancasesmodel> Emergencyhumancases ;
  BlocEmergencyHumanCasesLoaded(this.Emergencyhumancases);
}
final class BlocEmergencyHumanCasesError extends BlocEmergencyHumanCasesState {
  String ErrorMsg;
  BlocEmergencyHumanCasesError(this.ErrorMsg);
}