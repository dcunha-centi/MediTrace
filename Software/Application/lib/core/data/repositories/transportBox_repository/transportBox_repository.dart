import 'package:meditrace/core/data/models/response/response_model.dart';

abstract class TransportBoxRepository {
  Future <ResponseModel?> getTransportBox();
  Future <ResponseModel?> getTransportBoxByMacAddress(String macAddress);
  }