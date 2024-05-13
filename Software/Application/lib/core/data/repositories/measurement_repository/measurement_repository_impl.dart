import 'package:dio/dio.dart';
import 'package:meditrace/core/data/models/response/response_model.dart';
import 'package:meditrace/core/data/repositories/measurement_repository/measurement_repository.dart';
import 'package:meditrace/core/constants/application_constants.dart';

class MeasurementRepositoryImpl implements MeasurementRepository {
  @override
  Future<ResponseModel?> getMeasurement() async {
    var dio = Dio();
    var response = await dio.request(
      '${ApplicationRequestPaths.dbUrl}/measurement',
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
  Future<ResponseModel?> getMeasurementbyTransportBox(String macAddress, String measurementString, String createdAt) async {
    var dio = Dio();
    var response = await dio.request(
     '${ApplicationRequestPaths.dbUrl}/measurement/transportBox?macAddress=$macAddress$measurementString'
     //'http://localhost/measurement/transportBox?macAddress=$macAddress$measurementString'
      ,
      options: Options(
        method: 'GET',
      ),
    );
    print("-----------------------------------------------");
    print(response.realUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = response.data['results'];
      return ResponseModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load measurement data');
    }
  }

}
