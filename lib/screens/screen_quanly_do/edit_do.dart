import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_mon.dart';
import 'package:quan_ly_goi_mon/models/combo.dart';
import 'package:quan_ly_goi_mon/models/do.dart';
import 'item_combo.dart';
import 'single_chosse.dart';

class EditDo extends StatefulWidget {
  const EditDo({super.key, required this.insDo, required this.isEdit});
  final Do insDo;
  final bool isEdit;
  @override
  State<EditDo> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<EditDo> {
  final TextEditingController tenController = TextEditingController();
  final TextEditingController giaController = TextEditingController();
  final TextEditingController comboController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isCombo = false;
  List<Combo> tenCombo = [];

  final _controller = Get.find<ControllerMon>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tenController.text = widget.insDo.ten;
    giaController.text = widget.insDo.gia;
    if (widget.insDo.combo != null) {
      isCombo = true;
      widget.insDo.combo?.forEach((element) {
        tenCombo.add(element);
      });
    }
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
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Card(
                      color: const Color.fromARGB(131, 158, 158, 158),
                      child: TextFormField(
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
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
                            hintText: 'Nhập Giá',
                            labelText: 'Giá',
                          ),
                          controller: giaController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Chưa nhập giá';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number),
                    ),
                  ),
                  FeaturesSinglePopup(
                      danhMuc: widget.insDo.idDanhMuc,
                      theLoai: widget.insDo.idTheLoai),
                  ItemCombo(stateCombo: widget.insDo.combo != null),
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
                String gia = giaController.text;

                if (isValidated == true) {
                  _controller.insDo.ten = ten;
                  _controller.insDo.gia = gia;
                  widget.isEdit ? _controller.suaDo() : _controller.themDo();
                  Future.delayed(Duration(seconds: 2)).then((value) {
                    Get.snackbar("Thông báo:", _controller.thongBao);
                  });
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
