import 'package:meditrace/core/data/models/response/response_model.dart';

abstract class MeasurementRepository {
  Future <void> getMeasurement();
  Future <ResponseModel?> getMeasurementbyTransportBox(String macAddress, String measurementString, String createdAt);
    
}