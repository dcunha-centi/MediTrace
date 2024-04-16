// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementModel _$MeasurementModelFromJson(Map<String, dynamic> json) =>
    MeasurementModel(
      id: json['id'] as String,
      unit: (json['unit'] as num).toDouble(),
      value: (json['value'] as num).toDouble(),
      createdAt: (json['createdAt'] as num).toDouble(),
    );

Map<String, dynamic> _$MeasurementModelToJson(MeasurementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unit': instance.unit,
      'value': instance.value,
      'createdAt': instance.createdAt,
    };
