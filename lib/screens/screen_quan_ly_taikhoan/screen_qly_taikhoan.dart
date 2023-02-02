import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_taikhoan.dart';
import 'package:quan_ly_goi_mon/screens/screen_quan_ly_taikhoan/screen_sua.dart';

class ScreenQuanLyTaiKhoan extends StatefulWidget {
  const ScreenQuanLyTaiKhoan({super.key});

  @override
  State<ScreenQuanLyTaiKhoan> createState() => _ScreenQuanLyTaiKhoanState();
}

class _ScreenQuanLyTaiKhoanState extends State<ScreenQuanLyTaiKhoan> {
  final styTile = const TextStyle(fontWeight: FontWeight.bold);
  final _controllerTK = Get.find<ControllerTaiKhoan>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerTK.getDSTaiKhoan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          GetX<ControllerTaiKhoan>(
              builder: (controller) => Container(
                    width: MediaQuery.of(context).size.width,
                    child: DataTable(
                      border: TableBorder.all(width: 1, color: Colors.black45),
                      columnSpacing: 0,
                      columns: [
                        DataColumn(
                            label: Text(
                          "ID",
                          style: styTile,
                        )),
                        DataColumn(
                            label: Text("Tên Tài Khoản", style: styTile)),
                        DataColumn(label: Text("Thể Loại", style: styTile)),
                      ],
                      rows: controller.danhSachTaiKhoan
                          .map((e) => DataRow(
                                  onLongPress: () {
                                    Get.to(() => ScreenSuaTaiKhoan());
                                  },
                                  cells: [
                                    DataCell(
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Text("${e.id}"),
                                      ),
                                    ),
                                    DataCell(
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        child: Center(
                                            child: Text("${e.taiKhoan}")),
                                      ),
                                    ),
                                    DataCell(
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        child: Center(
                                            child: Text(
                                                "${e.theLoaiTaiKhoan.tenTheLoai}")),
                                      ),
                                    ),
                                  ]))
                          .toList(),
                    ),
                  )),
        ],
      ),
    );
  }
}
