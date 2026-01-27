class Owner {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String cpf;
  final DateTime createdAt;

  Owner({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.cpf,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'cpf': cpf,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      cpf: map['cpf'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Owner copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? cpf,
    DateTime? createdAt,
  }) {
    return Owner(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      cpf: cpf ?? this.cpf,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
