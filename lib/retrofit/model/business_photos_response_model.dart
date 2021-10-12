import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BusinessPhotosResponseModel{
  @JsonKey(name:"id")
  final String id;
  @JsonKey(name:"bus_id")
  final String bus_id;
  @JsonKey(name:"photo_title")
  final String photo_title;
  @JsonKey(name:"photo_image")
  final String photo_image;

  BusinessPhotosResponseModel(this.id, this.bus_id, this.photo_title, this.photo_image);
}