// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovementModel _$MovementModelFromJson(Map<String, dynamic> json) =>
    MovementModel(
      idTransportBox: json['_id'] as String?,
      idPackage: json['idPackage'] as Map<String, dynamic>,
      movementType: json['movementType'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$MovementModelToJson(MovementModel instance) =>
    <String, dynamic>{
      '_id': instance.idTransportBox,
      'idPackage': instance.idPackage,
      'movementType': instance.movementType,
      'dateTime': instance.dateTime.toIso8601String(),
    };
