import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';
import 'package:quan_ly_goi_mon/controller/controller_bep.dart';
import 'package:quan_ly_goi_mon/controller/controller_oder.dart';
import 'package:quan_ly_goi_mon/screens/screen_bedo/screen_fill_food.dart';
import 'package:quan_ly_goi_mon/screens/screen_bedo/screen_fill_time.dart';
import '../screen_bep/button_reload_data.dart';

class ScreenBedo extends StatefulWidget {
  const ScreenBedo({super.key});

  @override
  State<ScreenBedo> createState() => _ScreenBeDoState();
}

class _ScreenBeDoState extends State<ScreenBedo> {
  final _controllerBep = Get.find<ControllerBep>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerBep.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              backgroundColor: Colors.orange,
              actions: [ButtonReloadBep()],
              bottom: const TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: "Thời gian"),
                  Tab(text: "Món"),
                ],
              ),
            ),
            body: TabBarView(
              children: [ScreenFillTime(), ScreenFillFood()],
            ),
          ),
        ));
  }
}
