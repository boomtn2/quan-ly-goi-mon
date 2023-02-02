import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masked_text_field/masked_text_field.dart';
import 'package:quan_ly_goi_mon/controller/controller_taikhoan.dart';
import 'package:quan_ly_goi_mon/screens/phanquyen/bep.dart';
import 'package:quan_ly_goi_mon/screens/phanquyen/nhanvien.dart';
import 'package:quan_ly_goi_mon/screens/phanquyen/quanly.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController taiKhoanController = TextEditingController();
  final ipController = TextEditingController();
  final TextEditingController matKhauController = TextEditingController();
  final controllerTaiKhoan = Get.find<ControllerTaiKhoan>();
  final formKey = GlobalKey<FormState>();
  bool ipHide = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bgr_login.jpg"),
                fit: BoxFit.fill)),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: ipHide,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Card(
                      color: const Color.fromARGB(131, 158, 158, 158),
                      child: MaskedTextField(
                        textFieldController: ipController,
                        inputDecoration: InputDecoration(
                            hintText: '192.192.192.192',
                            counterText: "",
                            prefixIcon: const Icon(Icons.connected_tv),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.replay_outlined),
                              onPressed: () {
                                print(ipController.text);
                              },
                            )),
                        autofocus: true,
                        mask: 'xxx.xxx.xxx.xxx.xxx',
                        maxLength: 15,
                        keyboardType: TextInputType.number,
                        onChange: (String value) {},
                      ),
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
                        hintStyle: const TextStyle(
                            fontSize: 17.0, color: Colors.white),
                        labelStyle: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                        errorStyle: const TextStyle(fontSize: 20.0),
                        prefixIcon: Image.asset("assets/images/user.png"),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        hintText: 'Nhập tài khoản',
                        labelText: 'Tài khoản',
                      ),
                      controller: taiKhoanController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Chưa nhập tài khoản';
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
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            fontSize: 17.0, color: Colors.white),
                        labelStyle: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                        errorStyle: const TextStyle(fontSize: 20.0),
                        prefixIcon: Image.asset("assets/images/pass.png"),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        hintText: 'Nhập mật khẩu',
                        labelText: 'Mật khẩu',
                      ),
                      controller: matKhauController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Chưa nhập mật khẩu';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        bool? isValidated = formKey.currentState?.validate();
                        String taiKhoan = taiKhoanController.text;
                        String matKhau = matKhauController.text;

                        if (isValidated == true) {
                          bool loginState = await controllerTaiKhoan.login(
                              taiKhoan: taiKhoan, matKhau: matKhau);

                          if (loginState) {
                            switch (controllerTaiKhoan.thongTinTaiKhoan.id) {
                              case '1':
                                Get.to(() => const NhanVien());
                                break;
                              case '2':
                                Get.to(() => const QuanLy());
                                break;
                              case '3':
                                Get.to(() => const BepPQ());
                                break;
                            }
                          }
                          Get.snackbar(
                              "Đăng nhập", controllerTaiKhoan.thongBao);
                        }
                      },
                      icon: const Icon(Icons.login),
                      label: const Text("Đăng nhập"),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          ipHide = !ipHide;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/images/login.png"),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "IP",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
