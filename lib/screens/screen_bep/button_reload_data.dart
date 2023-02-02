import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_bep.dart';

class ButtonReloadBep extends StatelessWidget {
  const ButtonReloadBep({super.key});

  @override
  Widget build(BuildContext context) {
 final controller = Get.find<ControllerBep>();
    return IconButton(onPressed: () {
      controller.fetchData();
    }, icon: Icon(Icons.replay_outlined));
  }
}