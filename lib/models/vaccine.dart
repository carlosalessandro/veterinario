class Vaccine {
  final int? id;
  final int petId;
  final String name;
  final DateTime applicationDate;
  final DateTime? nextDoseDate;
  final String batch;
  final String veterinarian;
  final String? notes;
  final DateTime createdAt;

  Vaccine({
    this.id,
    required this.petId,
    required this.name,
    required this.applicationDate,
    this.nextDoseDate,
    required this.batch,
    required this.veterinarian,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petId': petId,
      'name': name,
      'applicationDate': applicationDate.toIso8601String(),
      'nextDoseDate': nextDoseDate?.toIso8601String(),
      'batch': batch,
      'veterinarian': veterinarian,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Vaccine.fromMap(Map<String, dynamic> map) {
    return Vaccine(
      id: map['id'],
      petId: map['petId'],
      name: map['name'],
      applicationDate: DateTime.parse(map['applicationDate']),
      nextDoseDate: map['nextDoseDate'] != null 
          ? DateTime.parse(map['nextDoseDate']) 
          : null,
      batch: map['batch'],
      veterinarian: map['veterinarian'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
