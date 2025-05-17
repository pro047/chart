import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChartView extends ConsumerWidget {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientId = ref.watch(patientIdProvider);

    if (patientId == null) {
      return Center(child: Text('해당하는 환자가 없습니다'));
    }

    final eval = ref.watch(evaluationViewModelProvider(patientId));

    return eval.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(child: Text('평가 데이터가 없습니다'));
        }

        final spots = _generateSpot(data);

        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: false,
                  dotData: FlDotData(show: true),
                  barWidth: 2,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stackTrace) => Center(child: Text('$error')),
    );
  }
}

List<FlSpot> _generateSpot(List<EvaluationModel> data) {
  final startDate = data.first.createdAt!;
  return data.map((e) {
    final x = e.createdAt!.difference(startDate).inDays.toDouble();
    final y = (e.rom ?? 0).toDouble();
    return FlSpot(x, y);
  }).toList();
}
