import 'package:flutter/material.dart';

class PlanDrawer extends StatefulWidget {
  const PlanDrawer({super.key});

  @override
  State<PlanDrawer> createState() => _PlanDrawerState();
}

class _PlanDrawerState extends State<PlanDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: Text('Plan')),
          ListTile(
            title: Text('치료계획'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('운동계획'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('단기계획'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('장기계획'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
