import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';
import 'package:quan_ly_goi_mon/models/combo.dart';
import 'package:quan_ly_goi_mon/screens/screen_quan_ly_ban/single_choise.dart';

class ScreenThemBan extends StatefulWidget {
  const ScreenThemBan({super.key});

  @override
  State<ScreenThemBan> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenThemBan> {
  final TextEditingController tenController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isCombo = false;
  List<Combo> tenCombo = [];

  final _controller = Get.find<ControllerBan>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      backgroundColor: Colors.grey,
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                          hintText: 'Nhập tên đồ',
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
                  PopupTheLoaiBan(
                      theLoai: _controller.insBan.idTheLoai.tenTheLoai),
                ],
              )),
        ],
      ),
      persistentFooterButtons: [
        Card(
          color: Colors.blue,
          child: TextButton(
              onPressed: () async {
                bool? isValidated = formKey.currentState?.validate();
                String ten = tenController.text;

                if (isValidated == true) {
                  _controller.insBan.soThuTu = ten;
                  String tb = await _controller.themBan();

                  Get.back();
                  Get.snackbar("Thông báo", tb);
                }
              },
              child: Text(
                "Lưu",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }
}
