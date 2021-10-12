import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BookingData {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "bus_id")
  final String bus_id;
  @JsonKey(name: "trainer_id")
  final String trainer_id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "validity")
  final String validity;
  @JsonKey(name: "no_of_hours")
  final String no_of_hours;
  @JsonKey(name: "start_time")
  final String start_time;
  @JsonKey(name: "end_time")
  final String end_time;
  @JsonKey(name: "days")
  final String days;
  @JsonKey(name: "fee")
  final String fee;
  @JsonKey(name: "category")
  final String category;
  @JsonKey(name: "created_at")
  final String created_at;
  @JsonKey(name: "end_at")
  final String end_at;
  @JsonKey(name: "hours_played")
  final String hours_played;
  @JsonKey(name: "total_members")
  final String total_members;
  @JsonKey(name: "Status")
  final String Status;
  @JsonKey(name: "category_name")
  final String category_name;
  @JsonKey(name: "acadamy_name")
  final String acadamy_name;
  @JsonKey(name: "acadamy_logo")
  final String acadamy_logo;

  BookingData(this.id, this.bus_id, this.trainer_id, this.name, this.description, this.validity, this.no_of_hours, this.start_time, this.end_time, this.days, this.fee, this.category, this.created_at, this.end_at, this.hours_played, this.total_members, this.Status, this.category_name, this.acadamy_name, this.acadamy_logo);
}