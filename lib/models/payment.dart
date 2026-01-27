class Payment {
  final int? id;
  final int appointmentId;
  final int? serviceId;
  final double amount;
  final String paymentMethod;
  final String status;
  final DateTime paymentDate;
  final String? notes;
  final DateTime createdAt;

  Payment({
    this.id,
    required this.appointmentId,
    this.serviceId,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    required this.paymentDate,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appointmentId': appointmentId,
      'serviceId': serviceId,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'status': status,
      'paymentDate': paymentDate.toIso8601String(),
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      appointmentId: map['appointmentId'],
      serviceId: map['serviceId'],
      amount: map['amount'],
      paymentMethod: map['paymentMethod'],
      status: map['status'],
      paymentDate: DateTime.parse(map['paymentDate']),
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Payment copyWith({
    int? id,
    int? appointmentId,
    int? serviceId,
    double? amount,
    String? paymentMethod,
    String? status,
    DateTime? paymentDate,
    String? notes,
    DateTime? createdAt,
  }) {
    return Payment(
      id: id ?? this.id,
      appointmentId: appointmentId ?? this.appointmentId,
      serviceId: serviceId ?? this.serviceId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      paymentDate: paymentDate ?? this.paymentDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
