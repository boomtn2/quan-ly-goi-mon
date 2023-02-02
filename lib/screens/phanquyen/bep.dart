import 'package:flutter/material.dart';
import 'package:quan_ly_goi_mon/screens/screen_taikhoan/screen_taikhoan.dart';

import '../screen_bep/screen_bep.dart';
import '../screen_qly_trangthia/screen_qlymon.dart';

List<Widget> screens = [
  ScreenBep(),
  ScreenQlyMon(),
  ScreenTaiKhoan(),
];

class BepPQ extends StatefulWidget {
  const BepPQ({super.key});

  @override
  State<BepPQ> createState() => _HomeState();
}

class _HomeState extends State<BepPQ> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_bottomNavIndex],
      bottomNavigationBar: botom(),
    );
  }

  Widget botom() {
    return NavigationBarTheme(
      data: const NavigationBarThemeData(
        indicatorColor: Colors.orange,
      ),
      child: NavigationBar(
        selectedIndex: _bottomNavIndex,
        onDestinationSelected: (value) => setState(() {
          _bottomNavIndex = value;
        }),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.food_bank), label: "Gọi Đồ"),
          NavigationDestination(icon: Icon(Icons.star), label: "Trạng Thái"),
          NavigationDestination(icon: Icon(Icons.person), label: "Tài khoản"),
        ],
      ),
    );
  }
}
