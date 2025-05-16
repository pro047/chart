import 'package:chart/ui/provider/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const bottomNavPages = [Pages.therapist, Pages.patient, Pages.plan];

Widget bottomNavbar(Pages currentPage, WidgetRef ref) {
  final currentIndex =
      bottomNavPages.contains(currentPage)
          ? bottomNavPages.indexOf(currentPage)
          : 0;

  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index) {
      ref.read(currentPageProvider.notifier).state = bottomNavPages[index];
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.local_hospital),
        label: 'therapist',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'patient'),
      BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'plan'),
    ],
  );
}
