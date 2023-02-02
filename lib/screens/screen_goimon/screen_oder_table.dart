import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_ban.dart';
import 'package:quan_ly_goi_mon/screens/screem_hoadon/screen_hoadon.dart';
import 'package:quan_ly_goi_mon/screens/screen_goimon/widgets/widget_ds_oder.dart';

import '../screen_food/screen_food.dart';
import 'widgets/widget_lichsu_oder.dart';

class ScreenOrder extends StatefulWidget {
  const ScreenOrder({super.key});

  @override
  State<ScreenOrder> createState() => _ScreenOrderState();
}

class _ScreenOrderState extends State<ScreenOrder> {
  final controllerTable = Get.find<ControllerBan>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerTable.getOder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
            "Gọi Món -  ${controllerTable.getBan().soThuTu}- ${controllerTable.getBan().idTheLoai.tenTheLoai}"),
      ),
      persistentFooterButtons: [
        ElevatedButton(
            onPressed: controllerTable.getBan().goido == null
                ? null
                : () {
                    controllerTable.taoCTHD();
                    if (controllerTable.flagTB) {
                      Get.snackbar("Lỗi", controllerTable.thongBao);
                    } else {
                      Get.to(() => ScreenHoaDon());
                    }
                  },
            child: Text("Tao hoa don"))
      ],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => ScreenFood(
                          initPage: 0,
                        ));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Center(
                        child: Text("Combo"),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ScreenFood(
                          initPage: 1,
                        ));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Center(
                        child: Text("Món ăn"),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ScreenFood(
                          initPage: 2,
                        ));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Center(
                        child: Text("Đồ uống"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: TableOderView()),
        ],
      ),
    );
  }
}

class TableOderView extends StatefulWidget {
  const TableOderView({super.key});

  @override
  State<TableOderView> createState() => _TableOderViewState();
}

class _TableOderViewState extends State<TableOderView> {
  final controllerTable = Get.find<ControllerBan>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.yellow,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: "Lịch sử"),
                  Tab(text: "Oder"),
                ],
              ),
            ),
            body: TabBarView(
              children: [tableOderHistory(), tableOder()],
            ),
          ),
        ));
  }

  Widget tableOderHistory() {
    if (controllerTable.getBan().goido != null) {
      return SingleChildScrollView(child: WidgetLichSuOder());
    } else {
      return Container();
    }
  }

  Widget tableOder() {
    if (controllerTable.getBan().goido != null) {
      return SingleChildScrollView(child: WidgetDSOder());
    } else {
      return Container();
    }
  }
}
