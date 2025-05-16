import 'package:intl/intl.dart';

class EvaluationModel {
  final int? id;
  final int? patientId;
  final int? round;
  final int? rom;
  final int? vas;
  final String? region;
  final String? action;
  final String? hx;
  final String? sx;
  final DateTime? createdAt;

  EvaluationModel({
    this.id,
    required this.patientId,
    this.round,
    this.region,
    this.rom,
    this.vas,
    this.action,
    this.hx,
    this.sx,
    this.createdAt,
  });

  EvaluationModel copyWith({
    int? id,
    int? patientId,
    int? round,
    int? rom,
    int? vas,
    String? region,
    String? action,
    String? hx,
    String? sx,
    DateTime? createdAt,
  }) {
    return EvaluationModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      round: round ?? this.round,
      rom: rom ?? this.rom,
      vas: vas ?? this.vas,
      region: region ?? this.region,
      action: action ?? this.action,
      hx: hx ?? this.hx,
      sx: sx ?? this.sx,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory EvaluationModel.fromMap(Map<String, dynamic> map) {
    return EvaluationModel(
      id: map['id'],
      patientId: map['patientId'],
      round: map['round'],
      region: map['region'],
      rom: map['rom'],
      vas: map['vas'],
      action: map['action'],
      hx: map['hx'],
      sx: map['sx'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap({bool includeId = true}) {
    final formatter = DateFormat('yyyyMMdd');
    final map = {
      'patientId': patientId,
      'round': round,
      'region': region,
      'rom': rom,
      'vas': vas,
      'action': action,
      'hx': hx,
      'sx': sx,
      'createdAt': createdAt != null ? formatter.format(createdAt!) : null,
    };

    if (includeId && id != null) {
      map['id'] = id;
    }
    return map;
  }
}
