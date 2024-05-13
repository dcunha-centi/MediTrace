// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementModel _$MeasurementModelFromJson(Map<String, dynamic> json) =>
    MeasurementModel(
      id: json['_id'] as String,
      idTransportBox: json['idTransportBox'] as String?,
      value: json['value'] as String,
      unit: json['unit'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$MeasurementModelToJson(MeasurementModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'idTransportBox': instance.idTransportBox,
      'value': instance.value,
      'unit': instance.unit,
      'createdAt': instance.createdAt.toIso8601String(),
    };
