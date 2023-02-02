import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';
import 'package:quan_ly_goi_mon/screens/screem_hoadon/widgets/button_thanhtoan.dart';

class ScreenHoaDon extends StatelessWidget {
  ScreenHoaDon({super.key});
  final styTile = TextStyle(fontWeight: FontWeight.bold);
  final TextEditingController soLuongController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [ButtonThanhToan()],
      bottomSheet: GetX<ControllerBan>(
        builder: (controller) => Container(
            height: 70,
            color: Colors.cyan[50],
            child: Column(
              children: [
                ListTile(
                  leading: Text("Tổng tiền:"),
                  title: Text(
                    "${controller.hoaDon.value.tongTien.getGia()}",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text("VNĐ"),
                )
              ],
            )),
      ),
      appBar: AppBar(
        title: Text("Hóa đơn"),
        centerTitle: true,
      ),
      body: GetX<ControllerBan>(
        builder: (controller) => DataTable(
          border: TableBorder.all(width: 1, color: Colors.black45),
          columnSpacing: 0,
          columns: [
            DataColumn(label: Text("Tên", style: styTile)),
            DataColumn(label: Text("Giá", style: styTile)),
            DataColumn(label: Text("Số Lượng", style: styTile)),
            DataColumn(label: Text("Thành Tiền", style: styTile)),
          ],
          rows: controller.hoaDon.value.hoaDonDo
              .map((e) => DataRow(
                      onLongPress: () {
                        soLuongController.text = e.soLuongPV;
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.rightSlide,
                          title: 'Sửa số lượng',
                          body: widgetSoLuong(),
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async {
                            bool? isValidated =
                                formKey.currentState?.validate();

                            try {
                              int.parse(soLuongController.text);

                              if (isValidated == true) {
                                String tb = await controller.suaHoaDon(
                                    idDo: e.doo.id,
                                    soLuong: soLuongController.text);
                                Get.snackbar("Thông báo", tb);
                              }
                            } catch (e) {
                              Get.snackbar("Lỗi", "Sai định dạng");
                            }
                          },
                        ).show();
                      },
                      cells: [
                        DataCell(
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Center(child: Text("${e.doo.ten}")),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Center(child: Text("${e.getGia()}")),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Center(child: Text("${e.soLuong}")),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Center(child: Text("${e.getThanhTien()}")),
                          ),
                        ),
                      ]))
              .toList(),
        ),
      ),
    );
  }

  Widget widgetSoLuong() {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Card(
                color: const Color.fromARGB(131, 158, 158, 158),
                child: TextFormField(
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle:
                        const TextStyle(fontSize: 17.0, color: Colors.white),
                    labelStyle:
                        const TextStyle(fontSize: 20.0, color: Colors.white),
                    errorStyle: const TextStyle(fontSize: 20.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintText: 'Số lượng',
                    labelText: 'Số lượng',
                  ),
                  controller: soLuongController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Chưa nhập tên';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ],
        ));
  }
}
