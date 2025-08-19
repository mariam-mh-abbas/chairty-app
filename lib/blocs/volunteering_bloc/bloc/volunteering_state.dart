part of 'volunteering_bloc.dart';

@immutable
sealed class VolunteeringState {}

final class VolunteeringInitial extends VolunteeringState {}

class VolunteeringLoading extends VolunteeringState {}

class VolunteeringSuccess extends VolunteeringState {
  final List<VolunteeringModel> volunteerings;

  VolunteeringSuccess(this.volunteerings);
}

class VolunteeringError extends VolunteeringState {
  final String message;

  VolunteeringError(this.message);
}

class VolunteeringEmpty extends VolunteeringState {}
