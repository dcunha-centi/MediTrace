import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_project/core/cubits/application_state.dart';
import 'package:generic_project/core/cubits/cubit_factory.dart';
import 'package:generic_project/features/dashboard/presentation/business_components/dashboard_cubit.dart';
import 'package:generic_project/features/dashboard/presentation/components/line_chart_widget.dart';
import 'package:date_picker_plus/date_picker_plus.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dashboardCubit = CubitFactory.dashboardCubit;

  late DateTime _selectedDate;
  String _selectedDropdownBox = 'Option 1';
  String _selectedDropdownMeasurement = 'Tempratura';

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dashboardCubit.getMedications();
    //_dashboardCubit.getChartData(_selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dashboardCubit.getChartData(_selectedDate);
      });
    }
  }

  @override
Widget build(BuildContext context) {
  final Size screenSize = MediaQuery.of(context).size;

  final double containerWidth = (screenSize.width - 60) / 3;

  return Scaffold(
    appBar: AppBar(
      title: const Text('Meditrace Dashboard'),
      centerTitle: true,
    ),
    body: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 15),
                  Container(
                    width: containerWidth,
                    height: 56,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 14,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: Color(0xFFC4CFEE)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedDropdownBox,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedDropdownBox = newValue;
                          });
                        }
                      },
                      items: <String>[
                        'Option 1',
                        'Option 2',
                        'Option 3',
                        'Option 4'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      style: TextStyle(
                        color: Color(0xFF202447),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                      dropdownColor: Colors.white,
                      elevation: 4,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF202447),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      width: containerWidth,
                      height: 56,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 14,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Color(0xFFC4CFEE)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Selected Date: ${_selectedDate.toString().substring(0, 10)}',
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.calendar_today,
                                color: Colors.blueGrey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: containerWidth,
                    height: 56,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 14,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: Color(0xFFC4CFEE)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedDropdownMeasurement,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedDropdownMeasurement = newValue;
                          });
                        }
                      },
                      items: <String>[
                        'Tempratura',
                        'Humidity',
                        'Impacts'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      style: TextStyle(
                        color: Color(0xFF202447),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                      elevation: 4,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF202447),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: BlocConsumer<DashboardCubit, ApplicationState>(
                  bloc: _dashboardCubit,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case DashboardChartDataLoadedState:
                        final chartData =
                            (state as DashboardChartDataLoadedState)
                                .chartData;
                        return LineChartWidget(chartData.cast<double>());
                      case ApplicationLoadingState:
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueGrey,
                          ),
                        );
                      default:
                        return const LineChartWidget([]);
                    }
                  },
                  listener: (context, state) {},
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

}
