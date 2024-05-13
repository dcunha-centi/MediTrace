import 'package:json_annotation/json_annotation.dart';

part 'movement_model.g.dart';

@JsonSerializable()
class MovementModel {
  @JsonKey(name: '_id')
  final String? idTransportBox;
  final Map<String, dynamic> idPackage;
  final String movementType;
  final DateTime dateTime;

  MovementModel({
    this.idTransportBox,
    required this.idPackage,
    required this.movementType,
    required this.dateTime,
  });

  factory MovementModel.fromJson(Map<String, dynamic> json) =>
      _$MovementModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovementModelToJson(this);
}