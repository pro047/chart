import 'package:chart/ui/provider/tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget bottomNavbar(int currentIndex, WidgetRef ref) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index) {
      ref.read(currentTabProvider.notifier).state = index;
    },
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'home'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'patient'),
      BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'more'),
    ],
  );
}
