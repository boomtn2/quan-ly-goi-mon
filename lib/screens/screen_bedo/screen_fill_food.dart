import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_bep.dart';
import 'package:quan_ly_goi_mon/screens/screen_bedo/screen_chitiet.dart';

class ScreenFillFood extends StatefulWidget {
  const ScreenFillFood({super.key});

  @override
  State<ScreenFillFood> createState() => _ScreenFillFoodState();
}

class _ScreenFillFoodState extends State<ScreenFillFood> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerBep>(
      builder: (controller) => ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Wrap(runSpacing: 10, spacing: 10, children: [
                for (String element in controller.dsFillFood.keys)
                  GestureDetector(
                      onTap: () {
                        Get.to(() => ScreenChiTietBanFillFood(tenMon: element));
                      },
                      child: itemCardFood(context, element))
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemCardFood(BuildContext context, String tenMon) {
    return GetBuilder<ControllerBep>(
      builder: (controller) => Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1)),
            width: MediaQuery.of(context).size.width / 2.2,
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              children: [
                Expanded(
                    child: Center(
                        child: Text(
                  "${tenMon}",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ))),
                Card(
                  color: Colors.blue,
                  child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: Text(
                        " ${controller.soLuong(controller.dsFillFood[tenMon]!)}",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
