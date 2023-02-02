import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_taikhoan.dart';

List<S2Choice<String>> theLoaiTaiKhoan = [
  S2Choice(value: '1', title: 'nhân viên'),
  S2Choice(value: '2', title: 'quản lý'),
  S2Choice(value: '3', title: 'bếp'),
];

class WidgetFormInPutAccount extends StatefulWidget {
  const WidgetFormInPutAccount({super.key, required this.function});

  final Function function;
  @override
  State<WidgetFormInPutAccount> createState() => _WidgetFormInPutAccountState();
}

class _WidgetFormInPutAccountState extends State<WidgetFormInPutAccount> {
  final TextEditingController taiKhoanController = TextEditingController();
  final TextEditingController matKhauController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _theLoai = '';
  final _controllerTaiKhoan = Get.find<ControllerTaiKhoan>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taiKhoanController.text = _controllerTaiKhoan.tempTaiKhoan.taiKhoan;
    matKhauController.text = _controllerTaiKhoan.tempTaiKhoan.matKhau;
    _theLoai = _controllerTaiKhoan.tempTaiKhoan.theLoaiTaiKhoan.tenTheLoai;
  }

  @override
  Widget build(BuildContext context) {
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
                    hintText: 'Nhập tài khoản',
                    labelText: 'Tài Khoản',
                  ),
                  controller: taiKhoanController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Chưa nhập tên';
                    }
                    return null;
                  },
                ),
              ),
            ),
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
                    hintText: 'Nhập mật khẩu',
                    labelText: 'mật khẩu',
                  ),
                  controller: matKhauController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Chưa nhập tên';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: SmartSelect<String?>.single(
                  title: _theLoai,
                  selectedValue: _theLoai,
                  choiceItems: theLoaiTaiKhoan,
                  onChange: (selected) => setState(() {
                    _theLoai = selected.value;
                    _controllerTaiKhoan.tempTaiKhoan.theLoaiTaiKhoan.id =
                        _theLoai ?? '';
                  }),
                  modalType: S2ModalType.popupDialog,
                  tileBuilder: (context, state) {
                    return S2Tile.fromState(
                      state,
                      leading: const Icon(Icons.category_outlined),
                    );
                  },
                ),
              ),
            ),
            Card(
              color: Colors.blue,
              child: TextButton(
                  onPressed: () async {
                    bool? isValidated = formKey.currentState?.validate();

                    if (isValidated == true) {
                      _controllerTaiKhoan.tempTaiKhoan.taiKhoan =
                          taiKhoanController.text;
                      _controllerTaiKhoan.tempTaiKhoan.taiKhoan =
                          taiKhoanController.text;
                      widget.function();
                    }
                  },
                  child: Text(
                    "Lưu",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ));
  }
}
