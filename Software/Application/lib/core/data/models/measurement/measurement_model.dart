import 'package:json_annotation/json_annotation.dart';

part 'measurement_model.g.dart';

@JsonSerializable()
class MeasurementModel {
  final String id;
  final double unit;
  final double value;
  final double createdAt;

  MeasurementModel({
      required this.id,
      required this.unit,
      required this.value,
      required this.createdAt,
  });

  factory MeasurementModel.fromJson(Map<String, dynamic> json) =>
      _$MeasurementModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeasurementModelToJson(this);
}