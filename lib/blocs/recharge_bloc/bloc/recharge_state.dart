part of 'recharge_bloc.dart';

@immutable
sealed class RechargeState {}

final class RechargeInitial extends RechargeState {}

class RechargeLoading extends RechargeState {}

class RechargeSuccess extends RechargeState {
  final List<RechargeModel> recharges;

  RechargeSuccess(this.recharges);
}

class RechargetError extends RechargeState {
  final String message;

  RechargetError(this.message);
}

class RechargeEmpty extends RechargeState {}
