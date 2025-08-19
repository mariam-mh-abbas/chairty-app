class TransactionModel {
  final int id;
  final double? amount;
  final String? type;
  final String? direction;
  final String? pdfUrl;
  final DateTime? date;

  TransactionModel({
    required this.id,
    this.amount,
    this.type,
    this.direction,
    this.pdfUrl,
    this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: json.containsKey('amount')
          ? ((json['amount'] is int)
              ? (json['amount'] as int).toDouble()
              : (json['amount'] as num).toDouble())
          : null,
      type: json['type'],
      direction: json['direction'],
      pdfUrl: json['pdf_url'],
      date: json.containsKey('date') ? DateTime.parse(json['date']) : null,
    );
  }

  TransactionModel copyWith({
    double? amount,
    String? type,
    String? direction,
    String? pdfUrl,
    DateTime? date,
  }) {
    return TransactionModel(
      id: id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      direction: direction ?? this.direction,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      date: date ?? this.date,
    );
  }
}

class PeriodicallyModel {
  final int id;
  final double? amount;
  final String? recurrence;
  final String? recurrenceLabel;
  final String? status;
  final bool isActivated;
  final DateTime startDate;
  final DateTime endDate;
  final List<TransactionModel> transactions;

  PeriodicallyModel({
    required this.id,
    this.amount,
    this.recurrence,
    this.recurrenceLabel,
    required this.status,
    required this.isActivated,
    required this.startDate,
    required this.endDate,
    required this.transactions,
  });

  factory PeriodicallyModel.fromJson(Map<String, dynamic> json) {
    return PeriodicallyModel(
      id: json['id'],
      amount: json.containsKey('amount')
          ? ((json['amount'] is int)
              ? (json['amount'] as int).toDouble()
              : (json['amount'] as num).toDouble())
          : null,
      recurrence: json['recurrence'],
      recurrenceLabel: json['recurrence_label'],
      status: (json['status']),
      isActivated: json['is_activated'] ?? false,
      startDate: DateTime.tryParse(json["start_date"] ?? '') ?? DateTime.now(),
      //  json.containsKey('start_date') && json['start_date'] != null
      //     ? DateTime.parse(json['start_date'])
      //     : null,
      endDate: DateTime.tryParse(json["end_date"] ?? '') ?? DateTime.now(),
      //  DateTime.parse(json['end_date']),
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  PeriodicallyModel copyWith({
    double? amount,
    String? recurrence,
    String? recurrenceLabel,
    String? status,
    bool? isActivated,
    DateTime? startDate,
    DateTime? endDate,
    List<TransactionModel>? transactions,
  }) {
    return PeriodicallyModel(
      id: id,
      amount: amount ?? this.amount,
      recurrence: recurrence ?? this.recurrence,
      recurrenceLabel: recurrenceLabel ?? this.recurrenceLabel,
      status: status ?? this.status,
      isActivated: isActivated ?? this.isActivated,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      transactions: transactions ?? this.transactions,
    );
  }
}
