import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_project/core/cubits/application_state.dart';
import 'package:generic_project/features/dashboard/domain/use_cases/dashboard_use_case.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<ApplicationState> {
  DashboardCubit({required this.dashboardUseCase})
      : super(const DashboardInitialState());
  final DashboardUseCase dashboardUseCase;

  void getMedications() async {
    try {
      dashboardUseCase.getMedications();
    } catch (e) {
      emit(ApplicationApiError(message: e.toString()));
    }
    
  }

  void getChartData(DateTime selectedDate) async {
    final List<double> data = [0.1, 0.5, 2.0, 4.0];

    emit(DashboardChartDataLoadedState(chartData: data));
  }
}
