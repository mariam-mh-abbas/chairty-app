part of 'bloc_humancase_details_bloc.dart';

@immutable
sealed class BlocHumancaseDetailsState {}

final class HumancaseDetailsInitial extends BlocHumancaseDetailsState {}
final class HumancaseDetailsLoading extends BlocHumancaseDetailsState {}
final class HumancaseDetailsLoaded extends BlocHumancaseDetailsState {
  final Detailshumanncasesmodel detailshumanncasesmodel ;

  HumancaseDetailsLoaded(this.detailshumanncasesmodel);
}
final class HumancaseDetailsError extends BlocHumancaseDetailsState {
  final String ErrorMsg;

  HumancaseDetailsError(this.ErrorMsg);
}