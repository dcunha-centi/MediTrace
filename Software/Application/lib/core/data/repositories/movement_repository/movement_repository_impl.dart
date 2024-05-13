import 'package:dio/dio.dart';
import 'package:meditrace/core/data/models/response/response_model.dart';
import 'package:meditrace/core/constants/application_constants.dart';
import 'package:meditrace/core/data/repositories/movement_repository/movement_repository.dart';

class MovementRepositoryImpl implements MovementRepository {
  @override
  Future<ResponseModel?> getMovement() async {
    var dio = Dio();
    var response = await dio.request(
      '${ApplicationRequestPaths.dbUrl}/movement',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = response.data['results'];
      //print(response);
      return ResponseModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load transport box data');
    }
  }

  @override
  Future<ResponseModel?> getMovementbyTransportBox(String macAddress, String movementString, String createdAt) async {
    var dio = Dio();
    var response = await dio.request(
     '${ApplicationRequestPaths.dbUrl}/movement/transportBox?macAddress=$macAddress$movementString'
     //'http://localhost/movement/transportBox?macAddress=$macAddress$movementString'
      ,
      options: Options(
        method: 'GET',
      ),
    );
    print("-----------------------------------------------Movement");
    print(response.realUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = response.data['results'];
      print(response);
      return ResponseModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load movement data');
    }
  }

}
