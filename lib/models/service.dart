class Service {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String category;
  final int duration;
  final bool active;
  final DateTime createdAt;

  Service({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.duration = 30,
    this.active = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'duration': duration,
      'active': active ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      category: map['category'],
      duration: map['duration'],
      active: map['active'] == 1,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Service copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? category,
    int? duration,
    bool? active,
    DateTime? createdAt,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
