class MedicalRecord {
  final int? id;
  final int appointmentId;
  final String chiefComplaint;
  final String anamnesis;
  final String physicalExam;
  final String? temperature;
  final String? heartRate;
  final String? respiratoryRate;
  final String? weight;
  final String diagnosis;
  final String treatment;
  final String? prognosis;
  final String? observations;
  final DateTime createdAt;

  MedicalRecord({
    this.id,
    required this.appointmentId,
    required this.chiefComplaint,
    required this.anamnesis,
    required this.physicalExam,
    this.temperature,
    this.heartRate,
    this.respiratoryRate,
    this.weight,
    required this.diagnosis,
    required this.treatment,
    this.prognosis,
    this.observations,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appointmentId': appointmentId,
      'chiefComplaint': chiefComplaint,
      'anamnesis': anamnesis,
      'physicalExam': physicalExam,
      'temperature': temperature,
      'heartRate': heartRate,
      'respiratoryRate': respiratoryRate,
      'weight': weight,
      'diagnosis': diagnosis,
      'treatment': treatment,
      'prognosis': prognosis,
      'observations': observations,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory MedicalRecord.fromMap(Map<String, dynamic> map) {
    return MedicalRecord(
      id: map['id'],
      appointmentId: map['appointmentId'],
      chiefComplaint: map['chiefComplaint'],
      anamnesis: map['anamnesis'],
      physicalExam: map['physicalExam'],
      temperature: map['temperature'],
      heartRate: map['heartRate'],
      respiratoryRate: map['respiratoryRate'],
      weight: map['weight'],
      diagnosis: map['diagnosis'],
      treatment: map['treatment'],
      prognosis: map['prognosis'],
      observations: map['observations'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
