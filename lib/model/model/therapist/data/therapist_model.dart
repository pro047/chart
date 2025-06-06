class TherapistModel {
  final int? id;
  final String name;
  final String hospital;
  final String email;

  TherapistModel({
    this.id,
    required this.name,
    required this.hospital,
    required this.email,
  });

  TherapistModel copyWith({
    int? id,
    String? name,
    String? hospital,
    String? email,
  }) {
    return TherapistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      hospital: hospital ?? this.hospital,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'hospital': hospital, 'email': email};
  }

  factory TherapistModel.fromMap(Map<String, dynamic> map) => TherapistModel(
    id: map['id'],
    name: map['name'],
    hospital: map['hospital'] is String ? map['hospital'] : '',
    email: map['email'],
  );
}
