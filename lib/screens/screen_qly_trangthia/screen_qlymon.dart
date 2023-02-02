import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';
import 'package:quan_ly_goi_mon/screens/screen_qly_trangthia/item_douong.dart';
import 'package:quan_ly_goi_mon/screens/screen_qly_trangthia/item_le.dart';

import 'item_combo.dart';

class ScreenQlyMon extends StatefulWidget {
  const ScreenQlyMon({super.key});

  @override
  State<ScreenQlyMon> createState() => _ScreenQlyMonState();
}

class _ScreenQlyMonState extends State<ScreenQlyMon> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Trạng Thái Món"),
            backgroundColor: Colors.orange,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.gif_box), text: "Combo"),
                Tab(
                  icon: Icon(
                    Icons.food_bank,
                  ),
                  text: "Lẻ",
                ),
                Tab(icon: Icon(Icons.no_drinks), text: "Đồ uống"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ItemCombo(),
              ItemLe(),
              ItemDoUong(),
            ],
          ),
        ),
      ),
    );
  }
}
