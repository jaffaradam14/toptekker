import 'package:json_annotation/json_annotation.dart';
import 'package:toptekker/retrofit/data/validate_user_data.dart';
part 'gdart/check_validate_user_model.g.dart';

@JsonSerializable()
class CheckValidUserResponseModel{
  @JsonKey(name:"responce")
  final bool? responce;
  @JsonKey(name:"data")
  final ValidateUserData data;

  CheckValidUserResponseModel(this.responce,this.data);

  factory CheckValidUserResponseModel.fromJson(Map<String, dynamic> json) => _$CheckValidUserResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CheckValidUserResponseModelToJson(this);
}