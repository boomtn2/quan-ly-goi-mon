import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';
import 'package:quan_ly_goi_mon/screens/screen_food/screen_combo/item_combo.dart';
import 'package:quan_ly_goi_mon/screens/screen_food/item_drink.dart';
import 'package:quan_ly_goi_mon/screens/screen_food/item_food.dart';

import 'screen_combo/screen_combo.dart';

class ScreenFood extends StatefulWidget {
  const ScreenFood({super.key, required this.initPage});
  final int initPage;
  @override
  State<ScreenFood> createState() => _ScreenFoodState();
}

class _ScreenFoodState extends State<ScreenFood> {
  final _controller = Get.find<ControllerMon>();
  late Timer timeCaner;
  @override
  void initState() {
    _controller.fetchMonAn();
    timeCaner = Timer.periodic(const Duration(seconds: 20), (timer) async {
      _controller.fetchMonAn();
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
    return PageView(
      controller: PageController(initialPage: widget.initPage),
      children: [
        ItemCombo(),
        ItemFood(),
        ItemDrink(),
      ],
    );
  }
}
