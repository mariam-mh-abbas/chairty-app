part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ShowProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final File? image;

  UpdateProfileEvent({required this.name, this.image});
}
