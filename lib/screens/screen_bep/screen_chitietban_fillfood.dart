import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';

import '../../controller/controller_bep.dart';

class ScreenChiTietBanFillFood extends StatefulWidget {
  const ScreenChiTietBanFillFood({super.key, required this.tenMon});
  final String tenMon;

  @override
  State<ScreenChiTietBanFillFood> createState() =>
      _ScreenChiTietBanFillFoodState();
}

class _ScreenChiTietBanFillFoodState extends State<ScreenChiTietBanFillFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.tenMon}"),
        ),
        body: SingleChildScrollView(child: itemCard(widget.tenMon)));
  }

  Widget itemCard(String key) {
    return GetBuilder<ControllerBep>(
      builder: (controller) => Card(
        child: Column(
          children: [
            Text(
              "${key}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
                "Số lượng: ${controller.soLuong(controller.dsFillFood[key]!)}"),
            Divider(
              color: Colors.black,
            ),
            Column(
              children: [
                for (var element in controller.dsFillFood[key]!)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text(
                          "${element.tenBan} - ${element.theLoaiBan}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        trailing: RichText(
                          text: TextSpan(
                            text: 'Số lượng( ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${element.chiTietGoiDo.soLuong}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.red)),
                              TextSpan(text: ' )'),
                            ],
                          ),
                        ),
                        subtitle: Text("${element.chiTietGoiDo.thoiGian}"),
                      ),
                      Divider(),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
