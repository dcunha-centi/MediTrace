
import 'package:dio/dio.dart';
import 'package:meditrace/core/constants/application_constants.dart';
import 'package:meditrace/core/data/models/response/response_model.dart';
import 'package:meditrace/core/data/repositories/transportBox_repository/transportBox_repository.dart';

class TransportBoxRepositoryImpl implements TransportBoxRepository {
  @override
// Modify the getTransportBox function to return a Future<List<String>>
  Future<ResponseModel?> getTransportBox() async {
    var dio = Dio();
    var response = await dio.request(
      '${ApplicationRequestPaths.dbUrl}/transportbox'
      //'http://localhost/transportbox'
      ,
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = response.data['results'];
      print("teste localhost");
      print(response);
      return ResponseModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load transport box data');
    }
  }

  @override
  Future<ResponseModel?> getTransportBoxByMacAddress(String macAddress) async {
    var dio = Dio();
    var response = await dio.request(
      '${ApplicationRequestPaths.dbUrl}/transportBox/?macAddress=$macAddress',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = response.data['results'];
      //print(response);
      //print(jsonData);
      return ResponseModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load transport box data');
    }
  }
}
