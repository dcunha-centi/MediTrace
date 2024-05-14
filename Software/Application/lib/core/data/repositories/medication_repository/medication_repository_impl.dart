import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meditrace/core/data/repositories/medication_repository/medication_repository.dart';

class MedicationRepositoryImpl implements MedicationRepository{
  
  @override
  Future <void> getMedication () async{
    var dio = Dio();
var response = await dio.request(
  'https://api.meditrace.ss-centi.com/medicationpackage',
  options: Options(
    method: 'GET',
  ),
);

if (response.statusCode == 200) {
  print(json.encode(response.data));
}
else {
  print(response.statusMessage);
}
  }
}