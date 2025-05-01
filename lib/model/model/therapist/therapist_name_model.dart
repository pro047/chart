class TherapistNameModel {
  final String name;

  TherapistNameModel({required this.name});

  factory TherapistNameModel.fromMap(Map<String, dynamic> map) =>
      TherapistNameModel(name: map['name'] as String);
}
