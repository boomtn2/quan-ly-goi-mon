import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_thongke.dart';

class ButtonReloadTK extends StatelessWidget {
  const ButtonReloadTK({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ControllerThongKe>();
    return IconButton(onPressed: () {
      controller.getData();
    }, icon: Icon(Icons.replay_outlined));
  }
}