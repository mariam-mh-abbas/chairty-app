part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

class ShowProfileLoaded extends ProfileState {
  final ProfileModel profile;

  ShowProfileLoaded(this.profile);
}

class ShowProfileError extends ProfileState {
  final String message;

  ShowProfileError(this.message);
}

class ProfileUpdateSuccess extends ProfileState {
  final ProfileModel profile;

  ProfileUpdateSuccess(this.profile);
}

class ProfileUpdateFailure extends ProfileState {
  final String error;

  ProfileUpdateFailure(this.error);
}
