import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  final List<double> chartData;

  const LineChartWidget(this.chartData);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        height: 500,
        child: SfCartesianChart(
          primaryXAxis: NumericAxis(),
          primaryYAxis: NumericAxis(),
          series: <ChartSeries>[
            LineSeries<double, double>(
              dataSource: chartData,
              xValueMapper: (double value, _) => chartData.indexOf(value).toDouble(),
              yValueMapper: (value, _) => value,
            ),
          ],
        ),
      ),
    );
  }
}


class ChartData {
  final double x;
  final double y;

  ChartData(this.x, this.y);
}