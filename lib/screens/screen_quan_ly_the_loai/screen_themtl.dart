import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';
import 'package:quan_ly_goi_mon/models/the_loai_ban.dart';

class ScreenThemTheLoai extends StatefulWidget {
  const ScreenThemTheLoai({super.key});

  @override
  State<ScreenThemTheLoai> createState() => _ScreenThemTheLoaiState();
}

class _ScreenThemTheLoaiState extends State<ScreenThemTheLoai> {
  final TextEditingController tenController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final controllerBan = Get.find<ControllerBan>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm thể loại"),
      ),
      body: ListView(
        children: [
          Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Card(
                      color: const Color.fromARGB(131, 158, 158, 158),
                      child: TextFormField(
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              fontSize: 17.0, color: Colors.white),
                          labelStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.white),
                          errorStyle: const TextStyle(fontSize: 20.0),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          hintText: 'Nhập tên thể loại',
                          labelText: 'Tên',
                        ),
                        controller: tenController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Chưa nhập tên';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              )),
          ElevatedButton(
              onPressed: () async {
                bool? isValidated = formKey.currentState?.validate();
                String ten = tenController.text;

                if (isValidated == true) {
                  TheLoaiBan tlb =
                      TheLoaiBan(id: '', tenTheLoai: ten, moTa: "Chua them");
                  String tb =
                      await controllerBan.themTheLoaiBan(theLoaiBan: tlb);
                  controllerBan.fetchBanTLB();
                  Get.back();
                  Get.snackbar("Thông báo", tb);
                }
              },
              child: Text("Lưu"))
        ],
      ),
    );
  }
}
