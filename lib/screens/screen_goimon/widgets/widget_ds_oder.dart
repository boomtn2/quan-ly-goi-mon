
import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../../controller/controller_ban.dart';

class WidgetDSOder extends StatelessWidget {
 const WidgetDSOder({super.key});

  final styTile =const TextStyle(fontWeight: FontWeight.bold);
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
                      DataColumn(label: Text("Đã phục vụ", style: styTile)),
                    ],
                    rows: controller
                        .dsOder.value.hoaDonDo
                        .map((e) => DataRow(
                              
                                cells: [
                                  DataCell(
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Text("${e.doo.ten}"),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child:
                                          Center(child: Text("${e.soLuong}")),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child:
                                          Center(child: Text("${e.soLuongPV}")),
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
