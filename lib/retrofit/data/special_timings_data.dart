import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SpecialTimingsData{
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "bus_id")
  final String bus_id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "categories")
  final String categories;
  @JsonKey(name: "categories_title")
  final String categories_title;
  @JsonKey(name: "working_days")
  final String working_days;
  @JsonKey(name: "morning_enabled")
  final String morning_enabled;
  @JsonKey(name: "afternoon_enabled")
  final String afternoon_enabled;
  @JsonKey(name: "evening_enabled")
  final String evening_enabled;
  @JsonKey(name: "morning_time_start")
  final String morning_time_start;
  @JsonKey(name: "morning_time_end")
  final String morning_time_end;
  @JsonKey(name: "afternoon_time_start")
  final String afternoon_time_start;
  @JsonKey(name: "afternoon_time_end")
  final String afternoon_time_end;
  @JsonKey(name: "evening_time_start")
  final String evening_time_start;
  @JsonKey(name: "evening_time_end")
  final String evening_time_end;
  @JsonKey(name: "morning_price")
  final String morning_price;
  @JsonKey(name: "afternoon_price")
  final String afternoon_price;
  @JsonKey(name: "evening_price")
  final String evening_price;
  @JsonKey(name: "created_at")
  final String created_at;

  SpecialTimingsData(this.id, this.bus_id, this.title, this.categories, this.categories_title, this.working_days, this.morning_enabled, this.afternoon_enabled, this.evening_enabled, this.morning_time_start, this.morning_time_end, this.afternoon_time_start, this.afternoon_time_end, this.evening_time_start, this.evening_time_end, this.morning_price, this.afternoon_price, this.evening_price, this.created_at);
}