import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_bep.dart';
import 'package:quan_ly_goi_mon/screens/screen_bep/button_reload_data.dart';
import 'package:quan_ly_goi_mon/screens/screen_bep/screen_fill_food.dart';
import 'package:quan_ly_goi_mon/screens/screen_bep/screen_fill_time.dart';

class ScreenBep extends StatefulWidget {
  const ScreenBep({super.key});

  @override
  State<ScreenBep> createState() => _ScreenBepState();
}

class _ScreenBepState extends State<ScreenBep> {
  final _controller = Get.find<ControllerBep>();
  late Timer timeCaner;
  @override
  void initState() {
    _controller.fetchData();
    timeCaner = Timer.periodic(const Duration(seconds: 20), (timer) async {
      _controller.fetchData();
    });

    super.initState();
  }

  @override
  void dispose() {
    timeCaner.cancel();
    super.dispose();
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
              actions: const [ButtonReloadBep()],
              bottom: const TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: "Thời gian"),
                  Tab(text: "Món"),
                ],
              ),
            ),
            body: const TabBarView(
              children: [ScreenFillTime(), ScreenFillFood()],
            ),
          ),
        ));
  }
}
