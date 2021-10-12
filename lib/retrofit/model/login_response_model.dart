import 'package:toptekker/retrofit/data/login_data_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'gdart/login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {

  @JsonKey(name:"responce")
  final bool? responce;

  @JsonKey(name:"data")
  final LoginData data;

  LoginResponseModel({required this.responce, required this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  @override
  String toString() {
    return 'LoginResponseModel: {response = $responce, data = $data}';
  }
}
