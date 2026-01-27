class Appointment {
  final int? id;
  final int petId;
  final DateTime dateTime;
  final String type;
  final String status;
  final String? notes;
  final String? diagnosis;
  final String? treatment;
  final DateTime createdAt;

  Appointment({
    this.id,
    required this.petId,
    required this.dateTime,
    required this.type,
    required this.status,
    this.notes,
    this.diagnosis,
    this.treatment,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petId': petId,
      'dateTime': dateTime.toIso8601String(),
      'type': type,
      'status': status,
      'notes': notes,
      'diagnosis': diagnosis,
      'treatment': treatment,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      petId: map['petId'],
      dateTime: DateTime.parse(map['dateTime']),
      type: map['type'],
      status: map['status'],
      notes: map['notes'],
      diagnosis: map['diagnosis'],
      treatment: map['treatment'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Appointment copyWith({
    int? id,
    int? petId,
    DateTime? dateTime,
    String? type,
    String? status,
    String? notes,
    String? diagnosis,
    String? treatment,
    DateTime? createdAt,
  }) {
    return Appointment(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      diagnosis: diagnosis ?? this.diagnosis,
      treatment: treatment ?? this.treatment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
