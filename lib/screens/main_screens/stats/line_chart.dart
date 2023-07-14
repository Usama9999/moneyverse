import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class LineChartCustom extends StatelessWidget {
  LineChartCustom();

  // final controller = Get.put(MoodScoreController());
  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = "0";
        break;
      case 1:
        text = "500";
        break;
      case 2:
        text = "1.5K";
        break;
      case 3:
        text = "7K";
        break;
      case 4:
        text = "20K";
        break;
      default:
        return Container();
    }

    return Text(text);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = normalText(size: 10);
    Widget text;
    switch (value.toInt()) {
      case 1:
        // text = Text(
        //     controller.scoreStats!.graphData[value.toInt() - 1].getDate(),
        //     style: style);
        break;
      case 2:
        // text = Text(
        //     controller.scoreStats!.graphData[value.toInt() - 1].getDate(),
        //     style: style);
        break;
      case 3:
        // text = Text(
        //     controller.scoreStats!.graphData[value.toInt() - 1].getDate(),
        //     style: style);
        break;
      case 4:
        // text = Text(
        //     controller.scoreStats!.graphData[value.toInt() - 1].getDate(),
        //     style: style);
        break;
      case 5:
        // text = Text(
        //     controller.scoreStats!.graphData[value.toInt() - 1].getDate(),
        //     style: style);
        break;
      case 6:
        // text = Text(
        //     controller.scoreStats!.graphData[value.toInt() - 1].getDate(),
        //     style: style);
        break;
      case 7:
        // text = Text(
        //     controller.scoreStats!.graphData[value.toInt() - 1].getDate(),
        //     style: style);
        break;

      default:
        text = const Text('');
        break;
    }

    text = const Text('');

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 6,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
      showTitles: true,
      reservedSize: 50,
      interval: 1,
      getTitlesWidget: bottomTitleWidgets);

  FlGridData get gridData => FlGridData(show: true, drawVerticalLine: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: AppColors.textGrey, width: 1),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: BorderSide(color: AppColors.textGrey, width: 1),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: AppColors.colorAccent,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        // spots: List.generate(
        //     controller.scoreStats!.graphData.length,
        //     (index) => FlSpot(
        //         index + 1, controller.scoreStats!.graphData[index].avgScore))
        spots: const [
          FlSpot(0, 1),
          FlSpot(1, 3),
          FlSpot(3, 3),
          FlSpot(5, 4),
          FlSpot(7, 1),
        ],
      );
}
