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
      child: Container(
        width: containerWidth,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.hide,
            majorGridLines: MajorGridLines(width: 0.2),
            labelStyle: TextStyle(color: Colors.grey[700]),
          ),
          primaryYAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.hide,
            majorGridLines: MajorGridLines(width: 0.2),
            labelStyle: TextStyle(color: Colors.grey[700]),
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            header: "",
            format: 'Temperatura: point.y°C \nHora: point.xH',
            textStyle: TextStyle(color: Colors.black,  fontSize: 12,),
            color: const Color.fromARGB(255, 234, 233, 233),
          ),
          zoomPanBehavior: ZoomPanBehavior(
            enableMouseWheelZooming: true,
          ),
          series: <ChartSeries>[
            LineSeries<double, double>(
              dataSource: chartData,
              xValueMapper: (double value, _) => chartData.indexOf(value).toDouble(),
              yValueMapper: (value, _) => value,
              markerSettings: MarkerSettings(
                isVisible: true,
                color: Colors.blue,
                borderColor: Colors.white,
                borderWidth: 2,
              ),
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
                textStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
