import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_project/core/cubits/application_state.dart';
import 'package:generic_project/core/cubits/cubit_factory.dart';
import 'package:generic_project/features/home/presentation/business_components/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeCubit = CubitFactory.homeCubit;
  int number = 0;

  @override
  void initState() {
    super.initState();
    _homeCubit.getMedications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, ApplicationState>(
        bloc: _homeCubit,
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeNumberUpdatedState:
                 number = (state as HomeNumberUpdatedState).newNumber;         
              break;
            default:
          }
          return _buildSuccessState(state );
        },
        listener: (context, state) {},
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _homeCubit.updateNumber(number);
      },),
    );
  }

  Widget _buildSuccessState(ApplicationState state) {
    return Center(child: state is ApplicationLoadingState? const CircularProgressIndicator() : Text(number.toString()),);
  }
}
