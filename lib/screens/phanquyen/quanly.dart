import 'package:flutter/material.dart';
import 'package:quan_ly_goi_mon/screens/screen_taikhoan/screen_taikhoan.dart';
import '../screen_thongke/screen_thongke.dart';
import '../screens_room/screen_room.dart';

List<Widget> screens = [ScreenRoom(), ScreenThongKe(), ScreenTaiKhoan()];

class QuanLy extends StatefulWidget {
  const QuanLy({super.key});

  @override
  State<QuanLy> createState() => _HomeState();
}

class _HomeState extends State<QuanLy> {
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
          NavigationDestination(icon: Icon(Icons.table_bar), label: "Bàn"),
          NavigationDestination(icon: Icon(Icons.room), label: "Thống kê"),
          NavigationDestination(icon: Icon(Icons.av_timer), label: "Tài khoản"),
        ],
      ),
    );
  }
}
