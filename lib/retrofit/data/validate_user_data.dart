import 'package:json_annotation/json_annotation.dart';
part 'gdart/validate_user_data.g.dart';

@JsonSerializable()
class ValidateUserData{
  @JsonKey(name:"user_id")
  final String user_id;
  @JsonKey(name:"user_fullname")
  final String user_fullname;
  @JsonKey(name:"user_phone")
  final String user_phone;
  @JsonKey(name:"user_image")
  final String user_image;

  ValidateUserData(this.user_id, this.user_fullname, this.user_phone, this.user_image);

  factory ValidateUserData.fromJson(Map<String, dynamic> json) =>
      _$ValidateUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateUserDataToJson(this);
}