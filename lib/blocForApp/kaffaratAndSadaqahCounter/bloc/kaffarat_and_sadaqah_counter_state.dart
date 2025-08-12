

part of 'kaffarat_and_sadaqah_counter_bloc.dart';

@immutable
class KaffaratAndSadaqahCounterState {
  final int count;
  final int totalAmount;

  const KaffaratAndSadaqahCounterState({
    required this.count,
    required this.totalAmount,
  });
}
