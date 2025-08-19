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
      type: json['type'] ?? '',
      direction: json['direction'] ?? '',
      pdfUrl: json['pdf_url'],
      date: json.containsKey('date') && json['date'] != null
          ? DateTime.parse(json['date'])
          : null,
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

class SponsorshipModel {
  final int id;
  final String title;
  final String? image;

  SponsorshipModel({
    required this.id,
    required this.title,
    this.image,
  });

  factory SponsorshipModel.fromJson(Map<String, dynamic> json) {
    return SponsorshipModel(
      id: json['id'],
      title: json['title'] ?? '',
      image: json['image'],
    );
  }

  SponsorshipModel copyWith({
    String? title,
    String? image,
  }) {
    return SponsorshipModel(
      id: id,
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }
}

class PlanModel {
  final int id;
  final double? amount;
  final String? recurrence;
  final String? status;
  final bool isActivated;
  final DateTime startDate;
  final DateTime endDate;
  final SponsorshipModel sponsorship;
  final List<TransactionModel> transactions;

  PlanModel({
    required this.id,
    this.amount,
    this.recurrence,
    required this.status,
    required this.isActivated,
    required this.startDate,
    required this.endDate,
    required this.sponsorship,
    required this.transactions,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'],
      amount: json.containsKey('amount')
          ? ((json['amount'] is int)
              ? (json['amount'] as int).toDouble()
              : (json['amount'] as num).toDouble())
          : null,
      recurrence: json['recurrence'] ?? '',
      status: (json['status']) ?? '',
      isActivated: json['is_activated'] ?? false,
      startDate: DateTime.tryParse(json["start_date"] ?? '') ?? DateTime.now(),
      // json.containsKey('start_date') && json['start_date'] != null
      //     ? DateTime.parse(json['start_date'])
      //     : null,
      endDate: DateTime.tryParse(json["end_date"] ?? '') ?? DateTime.now(),
      //  json.containsKey('end_date') && json['end_date'] != null
      //     ? DateTime.parse(json['end_date'])
      //     : null,
      sponsorship: SponsorshipModel.fromJson(json['sponsorship']),
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  PlanModel copyWith({
    double? amount,
    String? recurrence,
    String? status,
    bool? isActivated,
    DateTime? startDate,
    DateTime? endDate,
    SponsorshipModel? sponsorship,
    List<TransactionModel>? transactions,
  }) {
    return PlanModel(
      id: id,
      amount: amount ?? this.amount,
      recurrence: recurrence ?? this.recurrence,
      status: status ?? this.status,
      isActivated: isActivated ?? this.isActivated,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      sponsorship: sponsorship ?? this.sponsorship,
      transactions: transactions ?? this.transactions,
    );
  }
}
