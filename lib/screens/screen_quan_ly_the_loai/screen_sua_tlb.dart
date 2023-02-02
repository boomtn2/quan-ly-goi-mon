import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';
import 'package:quan_ly_goi_mon/models/the_loai_ban.dart';

class ScreenSuaTheLoai extends StatefulWidget {
  const ScreenSuaTheLoai({super.key, required this.theLoaiBan});
  final TheLoaiBan theLoaiBan;
  @override
  State<ScreenSuaTheLoai> createState() => _ScreenSuaTheLoaiState();
}

class _ScreenSuaTheLoaiState extends State<ScreenSuaTheLoai> {
  final TextEditingController tenController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final controllerBan = Get.find<ControllerBan>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tenController.text = widget.theLoaiBan.tenTheLoai;
  }

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
                  TheLoaiBan tlb = TheLoaiBan(
                      id: widget.theLoaiBan.id,
                      tenTheLoai: ten,
                      moTa: "Chua them");
                  String tb =
                      await controllerBan.suaTheLoaiBan(theLoaiBan: tlb);
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
