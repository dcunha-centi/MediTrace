import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_project/core/cubits/application_state.dart';
import 'package:generic_project/core/cubits/cubit_factory.dart';
import 'package:generic_project/features/dashboard/presentation/business_components/dashboard_cubit.dart';
import 'package:generic_project/features/dashboard/presentation/components/line_chart_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dashboardCubit = CubitFactory.dashboardCubit;

  late DateTime _selectedDate;
  String _selectedDropdownValue = 'Option 1';

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
  return Scaffold(
    appBar: AppBar(
      title: const Text('Meditrace Dashboard'),
      centerTitle: true,
    ),
    drawer: Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.water_drop, color: Colors.blueGrey),
            title: const Text('Humidity'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.thermostat, color: Colors.blueGrey),
            title: const Text('Temperature'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.warning, color: Colors.blueGrey),
            title: const Text('Impacts'),
            onTap: () {},
          ),
        ],
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Row(
                  children: [
                    Text(
                      'Selected Date: ${_selectedDate.toString().substring(0, 10)}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              DropdownButton<String>(
                value: _selectedDropdownValue,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedDropdownValue = newValue;
                    });
                  }
                },
                items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Expanded(
            child: BlocConsumer<DashboardCubit, ApplicationState>(
              bloc: _dashboardCubit,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case DashboardChartDataLoadedState:
                    final chartData =
                        (state as DashboardChartDataLoadedState).chartData;
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
  );
}}