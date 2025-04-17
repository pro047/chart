import 'package:chart/widget/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PatientDetail extends StatefulWidget {
  const PatientDetail({super.key});

  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: CupertinoNavigationBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, size: 20),
            ),
            middle: Text('환자 이름'),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          ),
          body: SafeArea(
            child: SizedBox(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        renderTextFormField(
                          label: '이름',
                          onSaved: (val) {},
                          validator: (val) {
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        renderTextFormField(
                          label: '나이',
                          onSaved: (val) {},
                          validator: (val) {
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        renderTextFormField(
                          label: '성별',
                          onSaved: (val) {},
                          validator: (val) {
                            return null;
                          },
                        ),
                        renderTextFormField(
                          label: '첫 내원 날짜',
                          onSaved: (val) {},
                          validator: (val) {
                            return null;
                          },
                        ),
                        renderTextFormField(
                          label: '직업',
                          onSaved: (val) {},
                          validator: (val) {
                            return null;
                          },
                        ),
                        Builder(
                          builder: (context) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () async {
                                print(_formKey.currentState!.validate());
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '저장완료!',
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.white,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                '저장',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
