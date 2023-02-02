import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controller_thongke.dart';
import '../chart.dart';
import '../data_table_thongke.dart';


class ViewThongKeNgay extends StatelessWidget {
  const ViewThongKeNgay({super.key});

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
                           GetBuilder<ControllerThongKe>(builder:(controller) =>  Text("${controller.thongKe.doanhThu.getDoanhThu()}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                
              ],
            ),
          const  Divider(),
          const  Text(
              "Biểu đồ doanh thu theo thứ (%)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
         const   BarChartSample3(),
        const  Divider(),
           const Text(
              "Danh sách đồ gọi",
              style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 17),
            ),
            DataTableThongKe()
          ],
        ),
    );
  }
}