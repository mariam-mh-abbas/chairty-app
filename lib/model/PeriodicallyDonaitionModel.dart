// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Periodicallydonaitionmodel {
    final String recurrence;
    final int amount;
  Periodicallydonaitionmodel({
    required this.recurrence,
    required this.amount,
  });

  Periodicallydonaitionmodel copyWith({
    String? recurrence,
    int? amount,
  }) {
    return Periodicallydonaitionmodel(
      recurrence: recurrence ?? this.recurrence,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recurrence': recurrence,
      'amount': amount,
    };
  }

  factory Periodicallydonaitionmodel.fromMap(Map<String, dynamic> map) {
    return Periodicallydonaitionmodel(
      recurrence: map['recurrence'] as String,
      amount: map['amount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Periodicallydonaitionmodel.fromJson(String source) => Periodicallydonaitionmodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Periodicallydonaitionmodel(recurrence: $recurrence, amount: $amount)';

  @override
  bool operator ==(covariant Periodicallydonaitionmodel other) {
    if (identical(this, other)) return true;
  
    return 
      other.recurrence == recurrence &&
      other.amount == amount;
  }

  @override
  int get hashCode => recurrence.hashCode ^ amount.hashCode;
}
