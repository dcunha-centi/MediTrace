import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditrace/core/constants/application_assets.dart';
import 'package:meditrace/core/cubits/application_state.dart';
import 'package:meditrace/core/cubits/cubit_factory.dart';
import 'package:meditrace/core/data/models/measurement/measurement_model.dart';
import 'package:meditrace/core/data/models/movement/movement_model.dart';
import 'package:meditrace/core/data/models/transportBox/transport_box_model.dart';
import 'package:meditrace/core/enums/route_measurement_type_enum.dart';
import 'package:meditrace/features/dashboard/presentation/business_components/dashboard_cubit.dart';
import 'package:meditrace/features/dashboard/presentation/components/impacts_chart_widget.dart';
import 'package:meditrace/features/dashboard/presentation/components/line_chart_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dashboardCubit = CubitFactory.measurementCubit;
  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  TransportBoxModel? _selectedDropdownValue;
  List<TransportBoxModel> transportBoxes = [];
  List<MeasurementModel> chartData = [];
  List<MovementModel> movementsIn = [];
  List<MovementModel> movementsOut = [];
  RouteMeasurementTypeEnum filter = RouteMeasurementTypeEnum.temp;
  String _selectedDropdownMeasurement = 'Temperature';
  int measurementResultLength = 0;
  int movementsInLength = 0;
  int movementsOutLength = 0;

  @override
  void initState() {
    super.initState();
    //_dashboardCubit.getChartData(_selectedDate);
    //_dashboardCubit.getMeasurementbyTransportBox('1231134523423');
    //_dashboardCubit.getMeasurement();
    _dashboardCubit.getTransportBox();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        //_dashboardCubit.getChartData(_selectedDate);
      });
      TransportBoxModel? selectedTransportBox = transportBoxes.firstWhere(
        (box) => box.macAddress == _selectedDropdownValue?.macAddress,
      );
      _dashboardCubit.getTransportBoxHistorybyDate(
        selectedTransportBox.macAddress,
        filter,
        picked.toString(),
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditrace Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<DashboardCubit, ApplicationState>(
          bloc: _dashboardCubit,
          builder: (context, state) {
            switch (state.runtimeType) {
               case UpdateDataLoadedState:
                movementsIn = (state as UpdateDataLoadedState).movementsIn;
                movementsOut = (state).movementsOut;
                chartData = (state).chartData;
                movementsInLength = movementsIn.length;
                movementsOutLength = movementsOut.length;
                measurementResultLength = chartData.length;
                print("1");
                print(_selectedDropdownValue!.macAddress);
                print(_selectedDate);
                print(filter);
                break;
                
                case DashboardChartDataLoadedState:
                chartData = (state as DashboardChartDataLoadedState).chartData;
                print("2");
                print(_selectedDropdownValue!.macAddress);
                print(_selectedDate);
                print(filter);
                break;
             
              case DashboardTransportBoxLoadedState:
                transportBoxes =
                    (state as DashboardTransportBoxLoadedState).transportBoxes;
                _selectedDropdownValue = transportBoxes.first;
                _dashboardCubit.getMeasurementbyTransportBoxbyDate(
                    _selectedDropdownValue!.macAddress,
                    filter,
                    _selectedDate.toString());
                _dashboardCubit.getTransportBoxHistorybyDate(
                  _selectedDropdownValue!.macAddress,
                  filter,
                  _selectedDate.toString(),
                );
                print("2");
                print(_selectedDropdownValue!.macAddress);
                print(_selectedDate);
                print(filter);
                break;
              default:
            }
            return _buildSuccessState(context);
          },
          listener: (context, state) {},
        ),
      ),
    );
  }


  Widget _buildSuccessState(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double containerWidth = (screenSize.width - 60) / 3;

    bool showChart = _selectedDropdownMeasurement == 'Temperature' ||
        _selectedDropdownMeasurement == 'Humidity';
    bool showImpactsChart = _selectedDropdownMeasurement == 'Impacts/Interactions';

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: containerWidth,
                    child: const Text('Transport Box'),
                  ),
                  SizedBox(width: containerWidth, child: const Text('Date')),
                  SizedBox(
                    width: containerWidth,
                    child: const Text('Chart Values'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 15),
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
                        side: const BorderSide(
                          width: 2,
                          color: Color(0xFFC4CFEE),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: DropdownButton<TransportBoxModel>(
                      value: _selectedDropdownValue,
                      onChanged: (TransportBoxModel? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedDropdownValue = newValue;
                          });
                          _dashboardCubit.getTransportBoxHistorybyDate(
                            newValue.macAddress,
                            filter,
                            _selectedDate.toString(),
                          );
                        }
                      },
                      hint: const Text(
                        'Select one:',
                      ),
                      items: transportBoxes
                          .map<DropdownMenuItem<TransportBoxModel>>(
                              (TransportBoxModel value) {
                        return DropdownMenuItem<TransportBoxModel>(
                          value: value,
                          child: Text(value.macAddress.toString()),
                        );
                      }).toList(),
                      style: const TextStyle(
                        color: Color(0xFF202447),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      elevation: 4,
                      underline: Container(),
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            ApplicationAssets.arrowdownIcon,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
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
                          side: const BorderSide(
                            width: 2,
                            color: Color(0xFFC4CFEE),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Selected Date: ${_selectedDate.toString().substring(0, 10)}',
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    ApplicationAssets.calendarIcon,
                                    color: const Color(0xFF6672E5),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
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
                        side: const BorderSide(
                          width: 2,
                          color: Color(0xFFC4CFEE),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedDropdownMeasurement,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedDropdownMeasurement = newValue;
                            switch (newValue) {
                              case 'Temperature':
                                filter = RouteMeasurementTypeEnum.temp;
                                break;
                              case 'Humidity':
                                filter = RouteMeasurementTypeEnum.hum;
                                break;
                              case 'Impacts/Interactions':
                                filter = RouteMeasurementTypeEnum.fall;
                                break;
                              default:
                            }
                          });
                          TransportBoxModel? selectedTransportBox =
                              transportBoxes.firstWhere(
                            (box) =>
                                box.macAddress ==
                                _selectedDropdownValue?.macAddress,
                          );
                          _dashboardCubit.getTransportBoxHistorybyDate(
                            selectedTransportBox.macAddress,
                            filter,
                            _selectedDate.toString(),
                          );
                          
                        }
                      },
                      items: <String>['Temperature', 'Humidity', 'Impacts/Interactions']
                          .map<DropdownMenuItem<String>>((String value) {
                        Widget? icon;
                        switch (value) {
                          case 'Temperature':
                            icon = Image.asset(
                              ApplicationAssets.temperatureIcon,
                              color: const Color(0xFF6672E5),
                              width: 30,
                              height: 30,
                            );
                            break;
                          case 'Humidity':
                            icon = Image.asset(
                              ApplicationAssets.humidityIcon,
                              color: const Color(0xFF6672E5),
                              width: 30,
                              height: 30,
                            );
                            break;
                          case 'Impacts/Interactions':
                          icon = Image.asset(
                              ApplicationAssets.impactsIcon,
                              color: const Color(0xFF6672E5),
                              width: 30,
                              height: 30,
                            );
                            break;
                          default:
                        }
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              if (icon != null) icon,
                              Text(value),
                            ],
                          ),
                        );
                      }).toList(),
                      style: const TextStyle(
                        color: Color(0xFF202447),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      isExpanded: true,
                      elevation: 4,
                      underline: Container(),
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            ApplicationAssets.arrowdownIcon,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 15),
              if (showChart)
                LineChartWidget(chartData, _selectedDropdownMeasurement),
              if (showImpactsChart)
                buildImpactsChart(context, measurementResultLength, movementsInLength, movementsOutLength,chartData, movementsIn, movementsOut),
            ],
          ),
        ),
      ],
    );
  }
}
