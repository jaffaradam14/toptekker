import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class NotificationResponseModelData {
  @JsonKey(name: "noti_id")
  final String noti_id;
  @JsonKey(name: "noti_title")
  final String noti_title;
  @JsonKey(name: "noti_description")
  final String noti_description;
  @JsonKey(name: "type")
  final String type;
  @JsonKey(name: "noti_image")
  final String noti_image;
  @JsonKey(name: "noti_video")
  final String noti_video;
  @JsonKey(name: "date")
  final String date;
  @JsonKey(name: "bus_id")
  final String bus_id;
  @JsonKey(name: "views")
  final String views;
  @JsonKey(name: "bus_title")
  final String bus_title;
  @JsonKey(name: "bus_logo")
  final String bus_logo;

  NotificationResponseModelData(
      this.noti_id,
      this.noti_title,
      this.noti_description,
      this.type,
      this.noti_image,
      this.noti_video,
      this.date,
      this.bus_id,
      this.views,
      this.bus_title,
      this.bus_logo);
}
