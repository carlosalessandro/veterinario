class PetPhoto {
  final int? id;
  final int petId;
  final String photoPath;
  final String? description;
  final String category;
  final DateTime photoDate;
  final DateTime createdAt;

  PetPhoto({
    this.id,
    required this.petId,
    required this.photoPath,
    this.description,
    this.category = 'other',
    DateTime? photoDate,
    DateTime? createdAt,
  })  : photoDate = photoDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petId': petId,
      'photoPath': photoPath,
      'description': description,
      'category': category,
      'photoDate': photoDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory PetPhoto.fromMap(Map<String, dynamic> map) {
    return PetPhoto(
      id: map['id'],
      petId: map['petId'],
      photoPath: map['photoPath'],
      description: map['description'],
      category: map['category'],
      photoDate: DateTime.parse(map['photoDate']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
