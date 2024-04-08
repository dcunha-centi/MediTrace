import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_project/core/cubits/application_state.dart';
import 'package:generic_project/features/dashboard/domain/use_cases/temprature_use_case.dart';
part 'temprature_state.dart';

class TempratureCubit extends Cubit<ApplicationState> {
  TempratureCubit({required this.tempratureUseCase}) : super(const TempratureInitialState());
  final TempratureUseCase tempratureUseCase;

  void getMedications()async {
    tempratureUseCase.getMedications();
  }

  void getChartData(DateTime selectedDate)async{
    final List<double>data = [0.2, 0.7, 3.0, 5.0];

    emit(TempratureChartDataLoadedState(chartData: data));
  }
}