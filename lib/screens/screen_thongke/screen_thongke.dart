import 'package:flutter/material.dart';
import 'package:quan_ly_goi_mon/screens/screen_thongke/widgets/button_reload_tk.dart';
import 'package:quan_ly_goi_mon/screens/screen_thongke/widgets/view_thongke_ngay.dart';
import 'package:quan_ly_goi_mon/screens/screen_thongke/widgets/view_thongke_thang.dart';



class ScreenThongKe extends StatelessWidget {
  const ScreenThongKe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
  home: DefaultTabController(
    length: 2,
    child: Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Thống kê"),
        bottom:  const TabBar(
          labelColor: Colors.black,
         indicatorColor: Colors.black,
          tabs: [
            Tab(text: "Ngày"),
            Tab(text: "Tháng"),

          ],
        ),
        actions: [
          ButtonReloadTK()
        ],
       
      ),
      body: const TabBarView(
  children: [
 ViewThongKeNgay(),
ViewThongKeThang()
  ],
),
    ),
  )
  );
  
  
  }




}
