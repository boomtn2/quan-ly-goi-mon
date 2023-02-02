import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/screens/screen_thongke/chart_thang.dart';
import 'package:quan_ly_goi_mon/screens/screen_thongke/data_table_thongke_thang.dart';

import '../../../controller/controller_thongke.dart';
import '../chart.dart';
import '../data_table_thongke.dart';


class ViewThongKeThang extends StatelessWidget {
  const ViewThongKeThang({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            
                    Card(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height/7,
                      width: MediaQuery.of(context).size.width/2,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Doanh Thu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            SizedBox(height: 20,),
                           GetBuilder<ControllerThongKe>(builder:(controller) =>  Text("${controller.thongKeThang.doanhThu.getDoanhThu()}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                
              ],
            ),
            Divider(),
            Text(
              "Biểu đồ doanh thu các tháng (%)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            BarChartSampleThang(),
              Divider(),
            Text(
              "Danh sách đồ gọi",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
            ),
            DataTableThongKeThang()
          ],
        ),
    );
  }
}