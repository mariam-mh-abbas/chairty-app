part of 'benefits_bloc.dart';

@immutable
sealed class BenefitsEvent {
  @override
  List<Object?> get props => [];
}

class GetBenefitsEvent extends BenefitsEvent {}
