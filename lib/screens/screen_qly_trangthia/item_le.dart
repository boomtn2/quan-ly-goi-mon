import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';
import 'package:quan_ly_goi_mon/models/class_default/default.dart';

class ItemLe extends StatelessWidget {
  const ItemLe({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ControllerMon>(
      builder: (controller) => GridView.count(crossAxisCount: 3, children: [
        for (var element in controller.dsMon)
          InkWell(
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.info,
                animType: AnimType.rightSlide,
                title: element.trangThai.compareTo('0') == 0
                    ? 'Xác nhận hết món'
                    : "Xác nhận còn món",
                desc: element.ten,
                btnCancelOnPress: () {},
                btnOkOnPress: () async {
                  controller.insDo = element;
                  String tb = "";
                  if (element.trangThai.compareTo('0') == 0) {
                    tb = await controller.thongBaoHetMon();
                  } else {
                    tb = await controller.thongBaoConMon();
                  }
                  controller.fetchMonAn();
                  Get.snackbar("Thông báo:", tb);
                },
              ).show();
            },
            child: Card(
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 70,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            element.ten,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                  Divider(
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Card(
                        color: element.trangThai.compareTo('0') == 0
                            ? Colors.green
                            : Colors.red,
                        child: Center(
                            child: Text("${trangThaiMon[element.trangThai]}"))),
                  )
                ],
              ),
            ),
          )
      ]),
    );
  }
}
