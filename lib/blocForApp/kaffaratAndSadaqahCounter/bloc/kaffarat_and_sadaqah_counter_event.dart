part of 'kaffarat_and_sadaqah_counter_bloc.dart';

@immutable
sealed class KaffaratAndSadaqahCounterEvent {}
final class IncrementCounter extends KaffaratAndSadaqahCounterEvent{
  final int unitPrice;

  IncrementCounter(this.unitPrice);
}
final class DecrementCounter extends KaffaratAndSadaqahCounterEvent{
     final int unitPrice;
     
    DecrementCounter(this.unitPrice);
}
final class ResetCounter extends KaffaratAndSadaqahCounterEvent{
  final int unitPrice;
  ResetCounter(this.unitPrice);
}

