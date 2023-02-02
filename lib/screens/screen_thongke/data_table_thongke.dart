import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_thongke.dart';


class DataTableThongKe extends StatelessWidget {
   DataTableThongKe({super.key});
  final styTile = TextStyle(fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerThongKe>(
      builder:(controller) =>  DataTable(
                      border: TableBorder.all(width: 1, color: Colors.black45),
                      columnSpacing: 0,
                      columns: [
                        DataColumn(label: Text("Tên", style: styTile)),
                        DataColumn(label: Text("Số Lượng", style: styTile)),
                        DataColumn(label: Text("Doanh thu", style: styTile)),
                      ],
                      rows: controller
                          .thongKe.doanhThuDo
                          .map((e) => DataRow(
                                  cells: [
                                    DataCell(
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width / 3,
                                        child: Text("${e.ten}"),
                                      ),
                                    ),
                                    DataCell(
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width / 7,
                                        child:
                                            Center(child: Text("${e.soLuong}")),
                                      ),
                                    ),
                                   DataCell(
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width / 7,
                                        child:
                                            Center(child: Text("${e.getDoanhThu()}")),
                                      ),
                                    ),
                                  ]))
                          .toList(),
                    ),
    );
  }
}