import 'package:flutter/material.dart';
import 'package:meditrace/core/constants/application_assets.dart';
import 'package:meditrace/core/data/models/measurement/measurement_model.dart';
import 'package:meditrace/core/data/models/movement/movement_model.dart';

Widget buildImpactsChart(
  BuildContext context,
  int measurementResultLength,
  int movementsInLength,
  int movementsOutLength,
  List<MeasurementModel> chartData,
  List<MovementModel> movementsIn,
  List<MovementModel> movementsOut,
) {
  final Size screenSize = MediaQuery.of(context).size;
  final double containerWidth = (screenSize.width - 60) / 3;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildContainerFall(containerWidth, 'Falls',
          measurementResultLength, chartData, ApplicationAssets.impactsIcon,const Color(0xFF6672E5)),
      _buildContainerFallMovements(containerWidth, 'Opened',
          movementsInLength, movementsIn, ApplicationAssets.arrowIcon,Colors.green),
      _buildContainerFallMovements(containerWidth, 'Closed', movementsOutLength,
          movementsOut, ApplicationAssets.arrowBackIcon,Colors.red),
    ],
  );
}

Widget _buildContainerFallMovements(double width, String title, int value,
    List<MovementModel> chartData, String icon, Color iconColor) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 1, 41, 73),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        value.toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 2, 2, 2),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(icon, color: iconColor,),
                ],
              ),
            ],
          ),
        ),
      ),
      Column(
        children: chartData.map((measurement) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text(
              measurement.dateTime.toString().substring(0, 19),
              style: const TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          );
        }).toList(),
      ),
    ],
  );
}

Widget _buildContainerFall(double width, String title, int value,
    List<MeasurementModel> chartData, String icon, Color iconColor) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 1, 41, 73),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        value.toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 2, 2, 2),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(icon,
                  color: iconColor,),
                ],
              ),
            ],
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: chartData.map((measurement) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text(
              measurement.createdAt.toString().substring(0, 19),
              style: const TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          );
        }).toList(),
      ),
    ],
  );
}
