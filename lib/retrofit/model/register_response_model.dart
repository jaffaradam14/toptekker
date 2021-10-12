import 'package:json_annotation/json_annotation.dart';
import 'package:toptekker/retrofit/data/register_data.dart';
part 'gdart/register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel{
  @JsonKey(name:"responce")
  final bool responce;

  @JsonKey(name:"data")
  final RegisterData data;

  RegisterResponseModel(this.responce, this.data);

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => _$RegisterResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}