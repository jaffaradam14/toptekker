import 'package:json_annotation/json_annotation.dart';
part 'gdart/change_password_response_model.g.dart';

@JsonSerializable()
class ChangePasswordResponseModel{
  @JsonKey(name:"responce")
  final bool? responce;
  @JsonKey(name:"data")
  final String data;

  ChangePasswordResponseModel(this.responce, this.data);

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) => _$ChangePasswordResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordResponseModelToJson(this);
}