import 'package:chart/view_model/therapist/therapist_name_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistView extends ConsumerStatefulWidget {
  const TherapistView({super.key});

  @override
  ConsumerState<TherapistView> createState() => _TherapistViewState();
}

class _TherapistViewState extends ConsumerState<TherapistView> {
  @override
  Widget build(BuildContext context) {
    final therapistName = ref.read(therapistNameViewModelProvider);

    // ignore: avoid_unnecessary_containers
    return Scaffold(
      appBar: AppBar(title: Text('therapist')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Text('${therapistName.value} 치료사님 안녕하세요'),
      ),
    );
  }
}
