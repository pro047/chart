class PlanModel {
  final int? id;
  final int? patientid;
  final int? round;
  final String? stg;
  final String? ltg;
  final String? treatmentPlan;
  final String? exercisePlan;
  final String? homework;
  final DateTime? createdAt;

  PlanModel({
    this.id,
    required this.patientid,
    this.round,
    this.stg,
    this.ltg,
    this.treatmentPlan,
    this.exercisePlan,
    this.homework,
    this.createdAt,
  });

  PlanModel copyWith({
    int? id,
    int? patientId,
    int? round,
    String? stg,
    String? ltg,
    String? treatmentPlan,
    String? exercisePlan,
    String? homeWork,
    DateTime? createdAt,
  }) {
    return PlanModel(
      id: id,
      patientid: patientId,
      round: round,
      stg: stg,
      ltg: ltg,
      treatmentPlan: treatmentPlan,
      exercisePlan: exercisePlan,
      homework: homeWork,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap({bool includeId = true}) {
    final map = {
      'patient_id': patientid,
      'round': round,
      'stg': stg,
      'ltg': ltg,
      'treatment_plan': treatmentPlan,
      'exercise_plan': exercisePlan,
      'homework': homework,
    };

    if (includeId && id != null) {
      map['id'] = id;
    }

    if (createdAt != null) {
      map['created_at'] = createdAt!.toIso8601String();
    }

    if (round != null) {
      map['round'] = round;
    }
    return map;
  }

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    print('planmodel fromap : $map');
    final rawCreateAt = map['created_at'];
    DateTime? createdAt;
    if (rawCreateAt != null &&
        rawCreateAt is String &&
        rawCreateAt.isNotEmpty) {
      createdAt = DateTime.tryParse(rawCreateAt.replaceFirst(' ', 'T'));
    }

    return PlanModel(
      id: map['id'],
      patientid: map['patient_id'],
      round: map['round'],
      stg: map['stg'],
      ltg: map['ltg'],
      treatmentPlan: map['treatment_plan'],
      exercisePlan: map['exercise_plan'],
      homework: map['homework'],
      createdAt: createdAt,
      // DateTime.parse(map['created_at']),
    );
  }
}
