import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CompletedResponseDataModel {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "user_id")
  final String user_id;
  @JsonKey(name: "bus_id")
  final String bus_id;
  @JsonKey(name: "doct_id")
  final String doct_id;
  @JsonKey(name: "service_id")
  final String service_id;
  @JsonKey(name: "appointment_date")
  final String appointment_date;
  @JsonKey(name: "booking_date_and_start_time")
  final String booking_date_and_start_time;
  @JsonKey(name: "start_time")
  final String start_time;
  @JsonKey(name: "slot_interval")
  final String slot_interval;
  @JsonKey(name: "cat_id")
  final String cat_id;
  @JsonKey(name: "cat_title")
  final String cat_title;
  @JsonKey(name: "cat_image")
  final String cat_image;
  @JsonKey(name: "service_title")
  final String service_title;
  @JsonKey(name: "time_token")
  final String time_token;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "app_name")
  final String app_name;
  @JsonKey(name: "app_email")
  final String app_email;
  @JsonKey(name: "app_phone")
  final String app_phone;
  @JsonKey(name: "created_at")
  final String created_at;
  @JsonKey(name: "payment_type")
  final String payment_type;
  @JsonKey(name: "payment_ref")
  final String payment_ref;
  @JsonKey(name: "payment_mode")
  final String payment_mode;
  @JsonKey(name: "payment_amount")
  final String payment_amount;
  @JsonKey(name: "advance_paid")
  final String advance_paid;
  @JsonKey(name: "convenience_fee")
  final String convenience_fee;
  @JsonKey(name: "promo_code")
  final String promo_code;
  @JsonKey(name: "promo_discount")
  final String promo_discount;
  @JsonKey(name: "promo_description")
  final String promo_description;
  @JsonKey(name: "bus_title")
  final String bus_title;
  @JsonKey(name: "country_name")
  final String country_name;
  @JsonKey(name: "currency")
  final String currency;
  @JsonKey(name: "cancelled_by")
  final String cancelled_by;
  @JsonKey(name: "is_cancelled")
  final String is_cancelled;
  @JsonKey(name: "cancel_reason")
  final String cancel_reason;
  @JsonKey(name: "type")
  final String type;
  @JsonKey(name: "plan_id")
  final String plan_id;
  @JsonKey(name: "mem_plan_id")
  final String mem_plan_id;
  @JsonKey(name: "discount")
  final String discount;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "cancellation_policy")
  final String cancellation_policy;
  @JsonKey(name: "cancellation_hour")
  final String cancellation_hour;
  @JsonKey(name: "bus_contact")
  final String bus_contact;

  CompletedResponseDataModel(
      this.id,
      this.user_id,
      this.bus_id,
      this.doct_id,
      this.service_id,
      this.appointment_date,
      this.booking_date_and_start_time,
      this.start_time,
      this.slot_interval,
      this.cat_id,
      this.cat_title,
      this.cat_image,
      this.service_title,
      this.time_token,
      this.status,
      this.app_name,
      this.app_email,
      this.app_phone,
      this.created_at,
      this.payment_type,
      this.payment_ref,
      this.payment_mode,
      this.payment_amount,
      this.advance_paid,
      this.convenience_fee,
      this.promo_code,
      this.promo_discount,
      this.promo_description,
      this.bus_title,
      this.country_name,
      this.currency,
      this.cancelled_by,
      this.is_cancelled,
      this.cancel_reason,
      this.type,
      this.plan_id,
      this.mem_plan_id,
      this.discount,
      this.description,
      this.cancellation_policy,
      this.cancellation_hour,
      this.bus_contact);
}
