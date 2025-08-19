part of 'benefits_bloc.dart';

@immutable
sealed class BenefitsState {
  @override
  List<Object?> get props => [];
}

final class BenefitsInitial extends BenefitsState {}

class BenefitsLoading extends BenefitsState {}

class BenefitsSuccess extends BenefitsState {
  final List<BenefitsModel> benefits;

  BenefitsSuccess(this.benefits);
  @override
  List<Object?> get props => [benefits];
}

class BenefitsError extends BenefitsState {
  final String message;

  BenefitsError(this.message);

  @override
  List<Object?> get props => [message];
}

class BenefitsEmpty extends BenefitsState {}
