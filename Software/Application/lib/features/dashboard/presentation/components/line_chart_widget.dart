import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  final List<double> chartData;

  const LineChartWidget(this.chartData);

  @override
  Widget build(BuildContext context) {
  final Size screenSize = MediaQuery.of(context).size;

  final double containerWidth = (screenSize.width - 60);
    return Center(
      child: SizedBox(
        width: containerWidth,
        height: 500,
        child: SfCartesianChart(
          primaryXAxis: NumericAxis(),
          primaryYAxis: NumericAxis(),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            format: 'point.y%',
            ),
          zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming : true
                  //enableSelectionZooming: true, -----------CropZoom
                  //selectionRectBorderColor: Colors.red,
                  //selectionRectBorderWidth: 1,
                  //selectionRectColor: Colors.grey
          ),
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