import 'package:faith_assessment/pages/setting_page/setting_page.dart';
import 'package:flutter/material.dart';

import 'home_page/home_page.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
              icon: Image.asset(
                'assets/icons/Home.png',
                height: 25,
              ),
              label: 'صفحه اصلی'),
          NavigationDestination(
              icon: Image.asset(
                'assets/icons/Setting.png',
                height: 25,
              ),
              label: 'تنظیمات')
        ],
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: [HomePage(), SettingPage()][currentIndex],
    );
  }
}
