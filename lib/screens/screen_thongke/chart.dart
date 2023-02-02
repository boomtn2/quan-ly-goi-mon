
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_goi_mon/controller/controller_thongke.dart';

class _BarChart extends StatelessWidget {
   _BarChart();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerThongKe>(
      builder:(controller) =>  BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: [
            for(int i = 0; i < controller.dataFlow.length;++i)
             BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: controller.dataFlow[i],
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
          ],
          gridData: FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: 110,
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
        child: Text('${controller.tiles[value]}', style: style),
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

  // List<BarChartGroupData> get barGroups => [
  //    BarChartGroupData(
  //         x: 0,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 3,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 1,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 23,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 2,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 30,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 3,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 20,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 13,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 5,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 10,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 6,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 0,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //     ];
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child:  _BarChart(),
      ),
    );
  }
}
