import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_oder.dart';
import 'package:quan_ly_goi_mon/models/class_default/default.dart';

import '../../../controller/controller_ban.dart';

class WidgetLichSuOder extends StatelessWidget {
  WidgetLichSuOder({super.key});

  final styTile = const TextStyle(fontWeight: FontWeight.bold);
  final controllerOder = Get.find<ControllerOder>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetX<ControllerBan>(
            builder: (controller) => Container(
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                    border: TableBorder.all(width: 1, color: Colors.black45),
                    columnSpacing: 0,
                    columns: [
                      DataColumn(
                          label: Text(
                        "Món",
                        style: styTile,
                      )),
                      DataColumn(label: Text("Số Lượng", style: styTile)),
                      DataColumn(label: Text("Trạng Thái", style: styTile)),
                      DataColumn(label: Text("Thời gian", style: styTile)),
                    ],
                    rows: controller.getBan().goido == null
                        ? []
                        : controller
                            .getBan()
                            .goido!
                            .chitietgoido
                            .map((e) => DataRow(
                                    onLongPress: () {
                                      print(e.id);
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.question,
                                        animType: AnimType.rightSlide,
                                        title: 'Hủy Oder',
                                        desc: '${e.doo.ten}',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () async {
                                          String tb = await controllerOder
                                              .huyOder(id: e.id);
                                          Get.snackbar('Thông báo', tb);
                                        },
                                      ).show();
                                    },
                                    cells: [
                                      DataCell(
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: Text("${e.doo.ten}"),
                                        ),
                                      ),
                                      DataCell(
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          child: Center(
                                              child: Text("${e.soLuong}")),
                                        ),
                                      ),
                                      DataCell(
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          child: Center(
                                              child: Text(
                                                  trangThaiDo[e.trangThai] ??
                                                      'lỗi')),
                                        ),
                                      ),
                                      DataCell(
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          child: Center(
                                              child: Text("${e.thoiGian}")),
                                        ),
                                      ),
                                    ]))
                            .toList(),
                  ),
                )),
      ],
    );
  }
}
