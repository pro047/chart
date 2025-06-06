import 'package:intl/intl.dart';

enum Gender { male, female }

class PatientModel {
  final int? id;
  final String name;
  final int age;
  final Gender gender;
  final DateTime firstVisit;
  final String occupation;

  PatientModel({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.firstVisit,
    required this.occupation,
  });

  PatientModel copyWith({
    int? id,
    String? name,
    int? age,
    Gender? gender,
    DateTime? firstVisit,
    String? occupation,
  }) {
    return PatientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      firstVisit: firstVisit ?? this.firstVisit,
      occupation: occupation ?? this.occupation,
    );
  }

  Map<String, dynamic> toMap() {
    final formatter = DateFormat('yyyyMMdd');
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender.name,
      'first_visit': formatter.format(firstVisit),
      'occupation': occupation,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    final rawGender = map['gender'];
    final gender = Gender.values.firstWhere(
      (g) => g.name == rawGender,
      orElse: () {
        print('gender check: $rawGender');
        return Gender.male;
      },
    );

    return PatientModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      gender: gender,
      firstVisit: DateTime.parse(map['first_visit']),
      occupation: map['occupation'],
    );
  }
}
