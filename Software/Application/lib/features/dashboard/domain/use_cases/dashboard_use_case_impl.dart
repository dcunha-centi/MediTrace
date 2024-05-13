import 'package:meditrace/core/constants/application_request_constants.dart';
import 'package:meditrace/core/data/models/response/response_model.dart';
import 'package:meditrace/core/data/repositories/measurement_repository/measurement_repository.dart';
import 'package:meditrace/core/data/repositories/movement_repository/movement_repository.dart';
import 'package:meditrace/core/data/repositories/transportBox_repository/transportBox_repository.dart';
import 'package:meditrace/core/enums/route_measurement_type_enum.dart';
import 'package:meditrace/features/dashboard/domain/use_cases/dashboard_use_case.dart';

class DashboardUseCaseImpl implements DashboardUseCase {
  final MeasurementRepository measurementRepository;
  final MovementRepository movementRepository;
  final TransportBoxRepository transportBoxRepository;
  const DashboardUseCaseImpl(
      {required this.measurementRepository,
      required this.transportBoxRepository,
      required this.movementRepository});

  /*@override
  Future<void> getMeasurement() async {
    await measurementRepository.getMeasurement();
  }*/

  /*@override
  Future<ResponseModel?> getMeasurementbyTransportBox(String macAddress) async {
    await measurementRepository.getMeasurementbyTransportBox(macAddress);
  }*/

  @override
  Future<ResponseModel?> getMeasurementbyTransportBoxbyDate(String macAddress,
      RouteMeasurementTypeEnum? measurementType, String createdAt) async {
    var measurementString = '';
    if (measurementType != null) {
      measurementString = '&';
      var createdAtDate = DateTime.parse(createdAt);
      var nextCreatedAt = createdAtDate.add(const Duration(days: 1));

      var measurement = measurementType;

      switch (measurement) {
        case RouteMeasurementTypeEnum.hum:
          measurementString +=
              "${ApplicationRequestConstants.measurementUnit}hum&$measurementString${ApplicationRequestConstants.measurementDate}${ApplicationRequestConstants.filterGreaterThanOrEqual}=$createdAt&${ApplicationRequestConstants.measurementDate}${ApplicationRequestConstants.filterLessThan}=$nextCreatedAt";
          break;
        case RouteMeasurementTypeEnum.temp:
          measurementString +=
              "${ApplicationRequestConstants.measurementUnit}temp&$measurementString${ApplicationRequestConstants.measurementDate}${ApplicationRequestConstants.filterGreaterThanOrEqual}=$createdAt&${ApplicationRequestConstants.measurementDate}${ApplicationRequestConstants.filterLessThan}=$nextCreatedAt";
          break;
        case RouteMeasurementTypeEnum.fall:
          measurementString +=
              "${ApplicationRequestConstants.measurementUnit}fall&$measurementString${ApplicationRequestConstants.measurementDate}${ApplicationRequestConstants.filterGreaterThanOrEqual}=$createdAt&${ApplicationRequestConstants.measurementDate}${ApplicationRequestConstants.filterLessThan}=$nextCreatedAt";
          break;
        default:
          break;
      }
    }
    return measurementRepository.getMeasurementbyTransportBox(
        macAddress, measurementString, createdAt);
  }

@override
  Future<ResponseModel?> getTransportBoxHistorybyDate(String macAddress, String createdAt) async {
    var movementString = '';
      var createdAtDate = DateTime.parse(createdAt);
      var nextCreatedAt = createdAtDate.add(const Duration(days: 1));

      movementString =
          "&${ApplicationRequestConstants.movementDate}${ApplicationRequestConstants.filterGreaterThanOrEqual}=$createdAt&${ApplicationRequestConstants.movementDate}${ApplicationRequestConstants.filterLessThan}=$nextCreatedAt";

      /*switch (movement) {
        case RouteMovementTypeEnum.inside:
          movementString +=
              "${ApplicationRequestConstants.movementType}in&$movementString${ApplicationRequestConstants.movementDate}${ApplicationRequestConstants.filterGreaterThanOrEqual}=$createdAt&${ApplicationRequestConstants.movementDate}${ApplicationRequestConstants.filterLessThan}=$nextCreatedAt";
          break;
        case RouteMovementTypeEnum.out:
          movementString +=
              "${ApplicationRequestConstants.movementType}out&$movementString${ApplicationRequestConstants.movementDate}${ApplicationRequestConstants.filterGreaterThanOrEqual}=$createdAt&${ApplicationRequestConstants.movementDate}${ApplicationRequestConstants.filterLessThan}=$nextCreatedAt";
          break;
        default:
          break;
      }*/

    return movementRepository.getMovementbyTransportBox(
        macAddress, movementString, createdAt);
  }
  @override
  Future<ResponseModel?> getTransportBox() async =>
      await transportBoxRepository.getTransportBox();

  @override
  Future<ResponseModel?> getTransportBoxByMacAddress(String macAddress) async =>
      await transportBoxRepository.getTransportBoxByMacAddress(macAddress);
}
