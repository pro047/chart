import 'package:chart/view/patient/patient_info/patient_introduce_view.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/view_model/patient/patient_view_model.dart';

class PatientSearch extends ConsumerStatefulWidget {
  const PatientSearch({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PatientSearchViewState();
}

class _PatientSearchViewState extends ConsumerState<PatientSearch> {
  String query = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allPatient = ref.watch(patientViewModelProvider);
    return allPatient.when(
      data: (data) {
        final filterdList = data.where((e) => e.name.contains(query)).toList();
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '환자 이름 검색',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
              ),
            ),

            if (query.isNotEmpty)
              Container(
                constraints: BoxConstraints(maxHeight: 300),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filterdList.length,
                  itemBuilder: (context, index) {
                    final patient = filterdList[index];
                    return ListTile(
                      title: Text(patient.name),
                      onTap: () {
                        ref.read(patientProvider.notifier).state = patient;
                        ref.read(patientIdProvider.notifier).state = patient.id;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PatientIntroduceView(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        );
      },
      error: (e, _) => Center(child: Text('해당 하는 환자가 없습니다')),
      loading: () => CircularProgressIndicator(),
    );
  }
}
