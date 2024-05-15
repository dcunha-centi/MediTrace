import 'package:flutter/material.dart';
import 'package:meditrace/core/data/models/measurement/measurement_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  final List<MeasurementModel> chartData;
  final String selectedDropdownValue;

  const LineChartWidget(this.chartData, this.selectedDropdownValue);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double containerWidth = (screenSize.width - 60);

    String tooltipFormat;
    switch (selectedDropdownValue) {
      case 'Temperature':
        tooltipFormat = 'Temperature: point.y°C \nHour: point.xH';
        break;
      case 'Humidity':
        tooltipFormat = 'Humidity: point.y% \nHour: point.xH';
        break;
      case 'Impacts':
        tooltipFormat = 'Impacts: point.y \nHour: point.xH';
        break;
      default:
        tooltipFormat = 'Default format';
    }

    return Center(
      child: Container(
        width: containerWidth,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(),
          primaryYAxis: NumericAxis(),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            header: "",
            format:tooltipFormat, 
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
            color: const Color.fromARGB(255, 234, 233, 233),
          ),
          zoomPanBehavior: ZoomPanBehavior(
            enableMouseWheelZooming: true,
          ),
          series: <ChartSeries>[
            LineSeries<MeasurementModel, DateTime>(
              dataSource: chartData,
              xValueMapper: (MeasurementModel measurement, _) =>
                  measurement.createdAt,
              yValueMapper: (MeasurementModel measurement, _) =>
                  double.parse(measurement.value),
              markerSettings: const MarkerSettings(
                isVisible: true,
                color: Colors.blue,
                borderColor: Colors.white,
                borderWidth: 2,
              ),
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
                textStyle:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
