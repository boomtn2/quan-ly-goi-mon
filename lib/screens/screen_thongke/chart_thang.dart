
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_thongke.dart';

class _BarChartThang extends StatelessWidget {
   _BarChartThang();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerThongKe>(
      builder:(controller) =>  BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: [
            for(int i = 0; i < controller.dataFlowMonth.length;++i)
             BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: controller.dataFlowMonth[i],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
          ],
          gridData: FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );
  


  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    
    return GetBuilder<ControllerThongKe>(
      builder:(controller) =>  SideTitleWidget(
        axisSide: meta.axisSide,
        space: 4,
        child: Text('${controller.tilesMonth[value]}', style: style),
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.lightBlueAccent,
          Colors.greenAccent,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

}

class BarChartSampleThang extends StatefulWidget {
  const BarChartSampleThang({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSampleThang> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child:  _BarChartThang(),
      ),
    );
  }
}
