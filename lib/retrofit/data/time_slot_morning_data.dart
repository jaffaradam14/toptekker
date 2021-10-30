import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TimeSlotMorningData {
  @JsonKey(name: "slot")
  final String slot;
  @JsonKey(name: "slot_label")
  final String slot_label;
  @JsonKey(name: "interval")
  final String interval;
  @JsonKey(name: "booking_id")
  String booking_id;
  @JsonKey(name: "is_booked")
  bool is_booked;
  @JsonKey(name: "price")
  final String price;
  @JsonKey(name: "time_token")
  final int time_token;
  @JsonKey(name: "type")
  final String type;

  bool isSelected;


  TimeSlotMorningData(this.slot, this.slot_label, this.interval,
      this.booking_id, this.is_booked, this.price, this.time_token, this.type, this.isSelected);
}