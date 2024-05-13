import 'package:json_annotation/json_annotation.dart';

part 'transport_box_model.g.dart';

@JsonSerializable()
class TransportBoxModel {
  @JsonKey(name: '_id')
  final String id;
  final String macAddress;

  TransportBoxModel({
    required this.id,
    required this.macAddress,
  });

  factory TransportBoxModel.fromJson(Map<String, dynamic> json) =>
      _$TransportBoxModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransportBoxModelToJson(this);
}