import 'package:meditrace/core/data/models/response/response_model.dart';

abstract class MovementRepository {
  Future <void> getMovement();
  Future <ResponseModel?> getMovementbyTransportBox(String macAddress, String movementString, String createdAt);
    
}