import 'package:flutter/material.dart';

class PatientDrawer extends StatefulWidget {
  const PatientDrawer({super.key});

  @override
  State<PatientDrawer> createState() => _PatientDrawerState();
}

class _PatientDrawerState extends State<PatientDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: Text('Patient')),
          ListTile(
            title: Text('ㄱ'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('ㄴ'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('ㄷ'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('ㄹ'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('ㅁ'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
