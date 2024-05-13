import 'package:json_annotation/json_annotation.dart';

part 'measurement_model.g.dart';

@JsonSerializable()
class MeasurementModel {
  @JsonKey(name: '_id')
  final String id;
  final String? idTransportBox;
  final String value;
  final String unit;
  final DateTime createdAt;

  MeasurementModel({
    required this.id,
    this.idTransportBox,
    required this.value,
    required this.unit,
    required this.createdAt,
  });

  factory MeasurementModel.fromJson(Map<String, dynamic> json) =>
      _$MeasurementModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeasurementModelToJson(this);
}