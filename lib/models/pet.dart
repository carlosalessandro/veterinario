class Pet {
  final int? id;
  final String name;
  final String species;
  final String breed;
  final DateTime birthDate;
  final String gender;
  final double weight;
  final String color;
  final int ownerId;
  final String? photoPath;
  final DateTime createdAt;

  Pet({
    this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.birthDate,
    required this.gender,
    required this.weight,
    required this.color,
    required this.ownerId,
    this.photoPath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'breed': breed,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender,
      'weight': weight,
      'color': color,
      'ownerId': ownerId,
      'photoPath': photoPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'],
      name: map['name'],
      species: map['species'],
      breed: map['breed'],
      birthDate: DateTime.parse(map['birthDate']),
      gender: map['gender'],
      weight: map['weight'],
      color: map['color'],
      ownerId: map['ownerId'],
      photoPath: map['photoPath'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Pet copyWith({
    int? id,
    String? name,
    String? species,
    String? breed,
    DateTime? birthDate,
    String? gender,
    double? weight,
    String? color,
    int? ownerId,
    String? photoPath,
    DateTime? createdAt,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      color: color ?? this.color,
      ownerId: ownerId ?? this.ownerId,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
