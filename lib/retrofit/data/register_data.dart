import 'package:json_annotation/json_annotation.dart';

part 'gdart/register_data.g.dart';

@JsonSerializable()
class RegisterData {
  @JsonKey(name: "user_id")
  final int user_id;
  @JsonKey(name: "user_fullname")
  final String user_fullname;
  @JsonKey(name: "user_email")
  final String user_email;
  @JsonKey(name: "user_phone")
  final String user_phone;

  RegisterData({required this.user_id, required this.user_fullname, required this.user_email,
    required this.user_phone});

  factory RegisterData.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDataToJson(this);
}
