import 'package:meditrace/core/data/models/response/response_model.dart';
import 'package:meditrace/core/enums/route_measurement_type_enum.dart';

abstract class DashboardUseCase {
  //Future <void> getMeasurement();
  //Future <ResponseModel?> getMeasurementbyTransportBox(String macAddress);
  Future <ResponseModel?> getTransportBox();
  Future <ResponseModel?> getTransportBoxByMacAddress(String macAddress);

  Future<ResponseModel?> getMeasurementbyTransportBoxbyDate(String macAddress, RouteMeasurementTypeEnum? filter, String createdAt);
  
  Future<ResponseModel?> getTransportBoxHistorybyDate(String macAddress, String createdAt);
}