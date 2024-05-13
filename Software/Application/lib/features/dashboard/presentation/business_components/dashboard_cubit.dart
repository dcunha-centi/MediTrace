import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditrace/core/cubits/application_state.dart';
import 'package:meditrace/core/data/models/measurement/measurement_model.dart';
import 'package:meditrace/core/data/models/movement/movement_model.dart';
import 'package:meditrace/core/data/models/transportBox/transport_box_model.dart';
import 'package:meditrace/core/enums/route_measurement_type_enum.dart';
import 'package:meditrace/core/enums/route_movement_type_enum.dart';
import 'package:meditrace/features/dashboard/domain/use_cases/dashboard_use_case.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<ApplicationState> {
  DashboardCubit({required this.dashboardUseCase})
      : super(const DashboardInitialState());
  final DashboardUseCase dashboardUseCase;

  /*void getMeasurement() async {
    dashboardUseCase.getMeasurement();
  }*/

  List<Map<String, dynamic>>? transportBoxData;

  /*void getMeasurementbyTransportBox(String macAddress) async {
    await dashboardUseCase.getMeasurementbyTransportBox(macAddress);
  }*/

  /*void getTransportBox() async {
    dashboardUseCase.getTransportBox();
  }*/

  void getTransportBox() async {
    try {
      emit(const ApplicationLoadingState());

      final responseModel = await dashboardUseCase.getTransportBox();

      if (responseModel != null) {
        final transportBoxes = responseModel.data
            .map((e) => TransportBoxModel.fromJson(e))
            .toList();
        emit(DashboardTransportBoxLoadedState(transportBoxes: transportBoxes));
      }
    } on Exception catch (e) {
      emit(ApplicationApiError(message: e.toString()));
    }
  }

  void getTransportBoxByMacAddress(String macAddress) async {
    try {
      emit(const ApplicationLoadingState());
      final responseModel =
          await dashboardUseCase.getTransportBoxByMacAddress(macAddress);

      if (responseModel != null) {
        final transportBoxes = await responseModel.data
            .map((e) => TransportBoxModel.fromJson(e))
            .toList();
        emit(DashboardTransportBoxLoadedState(transportBoxes: transportBoxes));
      }
    } on Exception catch (e) {
      emit(ApplicationApiError(message: e.toString()));
    }
  }

  void getMeasurementbyTransportBoxbyDate(String macAddress,
      RouteMeasurementTypeEnum? filter, String createdAt) async {
    try {
      emit(const ApplicationLoadingState());
      final responseModel = await dashboardUseCase
          .getMeasurementbyTransportBoxbyDate(macAddress, filter, createdAt);
      List<MeasurementModel> measurements = [];
      if (responseModel != null) {
        measurements = responseModel.data
            .map((e) => MeasurementModel.fromJson(e))
            .toList();
      }
      emit(DashboardChartDataLoadedState(chartData: measurements));
    } catch (e) {
      emit(ApplicationApiError(message: e.toString()));
    }
  }

  void getTransportBoxHistorybyDate(String macAddress,
      RouteMeasurementTypeEnum? filter, String createdAt) async {
    try {
      emit(const ApplicationLoadingState());
      final responseModel = await dashboardUseCase.getTransportBoxHistorybyDate(
          macAddress, createdAt);
      List<MovementModel> movements = [];
      List<MovementModel> movementsIn = [];
      List<MovementModel> movementsOut = [];
      List<MeasurementModel> chartData = [];
      if (responseModel != null) {
        movements =
            responseModel.data.map((e) => MovementModel.fromJson(e)).toList();
        movementsIn = movements
            .where(
              (element) =>
                  element.movementType == RouteMovementTypeEnum.inside.name.substring(0,2),
            )
            .toList();
        movementsOut = movements
            .where(
              (element) =>
                  element.movementType == RouteMovementTypeEnum.out.name,
            )
            .toList();
      }
      final responseChartDataModel = await dashboardUseCase
          .getMeasurementbyTransportBoxbyDate(macAddress, filter, createdAt);
      if (responseChartDataModel != null) {
        chartData = responseChartDataModel.data
            .map((e) => MeasurementModel.fromJson(e))
            .toList();
      }

      emit(UpdateDataLoadedState(
          movementsOut: movementsOut,
          movementsIn: movementsIn,
          chartData: chartData));
    } catch (e) {
      emit(ApplicationApiError(message: e.toString()));
      print(e.toString());
    }
  }
}
