import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_taikhoan.dart';
import 'package:quan_ly_goi_mon/screens/screen_quan_ly_taikhoan/screen_sua.dart';
import 'package:quan_ly_goi_mon/screens/screen_quan_ly_taikhoan/screen_them.dart';

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
                                    controller.tempTaiKhoan = e;
                                    _showMyDialog();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controllerTK.tempTaiKhoan = _controllerTK.defaultTaiKhoan();
          Get.to(() => ScreenThemTaiKhoan());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,

      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: SizedBox(
            height: MediaQuery.of(context).size.width / 1.3,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(() => ScreenSuaTaiKhoan());
                    },
                    child: _tileButton('Sửa tài khoản')),
                GestureDetector(
                    onTap: () async {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.rightSlide,
                        title: 'Xác nhận xóa',
                        desc: '',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          String tb = await _controllerTK.xoaTaiKhoan();
                          Get.snackbar('Thông báo', tb);
                        },
                      ).show();
                    },
                    child: _tileButton("Xóa tài khoản")),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _tileButton(String ten) {
    return Card(
      color: Colors.grey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Card(child: Icon(Icons.touch_app)),
          title: Text(ten),
          trailing: Icon(Icons.arrow_right),
        ),
      ),
    );
  }
}
