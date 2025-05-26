import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:chart/view/patient/lib/fade_in.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChartView extends ConsumerStatefulWidget {
  const ChartView({super.key});

  @override
  ConsumerState<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends ConsumerState<ChartView> {
  @override
  Widget build(BuildContext context) {
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
        final startDate = data.first.createdAt!;
        final spots = _generateSpot(data);
        final xLabels = <double, String>{};

        for (var e in data) {
          final x = e.createdAt!.difference(startDate).inDays.toDouble();
          final y = (e.rom ?? 0).toDouble();
          spots.add(FlSpot(x, y));
          xLabels[x] = '${e.createdAt!.month}/${e.createdAt!.day}';
        }

        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FadeIn(
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBorderRadius: BorderRadius.circular(10),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final date = startDate.add(
                          Duration(days: spot.x.toInt()),
                        );
                        return LineTooltipItem(
                          '${date.month}/${date.day} : ${spot.y.toInt()}',
                          TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.blueAccent,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (xLabels.containsKey(value)) {
                          return Text(
                            xLabels[value]!,
                            style: TextStyle(fontSize: 10),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}',
                          style: TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: data.length.toDouble() - 1,
                minY: 0,
                maxY: 180,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.blue,
                    dotData: FlDotData(show: true),
                    barWidth: 3,
                  ),
                ],
              ),
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
