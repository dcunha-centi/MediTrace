import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditrace/core/cubits/application_state.dart';
import 'package:meditrace/core/cubits/cubit_factory.dart';
import 'package:meditrace/features/dashboard/presentation/business_components/dashboard_cubit.dart';
import 'package:meditrace/features/dashboard/presentation/components/line_chart_widget.dart';
import 'package:meditrace/features/home/presentation/user_interfaces/home_ui.dart';
import 'package:meditrace/core/cubits/cubit_factory.dart';

class ImpactsScreen extends StatefulWidget {
  const ImpactsScreen({Key? key}) : super(key: key);

  @override
  State<ImpactsScreen> createState() => _ImpactsScreenState();
}

class _ImpactsScreenState extends State<ImpactsScreen> {
  final _dashboardCubit = CubitFactory.measurementCubit;

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
              onTap: () {
                Navigator.pushNamed(context, 'humidity_screen',
                    arguments: _selectedDropdownValue);
              },
            ),
            ListTile(
              leading: const Icon(Icons.thermostat, color: Colors.blueGrey),
              title: const Text('Temperature'),
              onTap: () {
                Navigator.pushNamed(context, 'temperature_screen',
                    arguments: _selectedDropdownValue);
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning, color: Colors.blueGrey),
              title: const Text('Impacts'),
              onTap: () {
                Navigator.pushNamed(context, 'impacts_screen',
                    arguments: _selectedDropdownValue);
              },
            ),
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardWidget(
              title: 'Numero de Quedas',
              subtitle: '5',
            ),
            SizedBox(height: 20), // Adiciona um espaço entre os cards
            CardWidget(
              title: 'Numero de Aberturas',
              subtitle: '2',
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const CardWidget({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Elevação do card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10), // Adiciona um espaço entre o título e o subtítulo
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}