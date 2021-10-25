import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TurfResponseModel{
  @JsonKey(name:"id")
  final String id;
  @JsonKey(name:"bus_id")
  final String bus_id;
  @JsonKey(name:"service_title")
  final String service_title;
  @JsonKey(name:"service_price")
  final String service_price;
  @JsonKey(name:"promo_code")
  final String promo_code;
  @JsonKey(name:"convenience_fee")
  final String convenience_fee;
  @JsonKey(name:"service_discount")
  final String service_discount;
  @JsonKey(name:"business_approxtime")
  final String business_approxtime;
  @JsonKey(name:"categories")
  final String categories;
  @JsonKey(name:"image")
  final String image;

  TurfResponseModel(this.id, this.bus_id, this.service_title, this.service_price, this.promo_code, this.convenience_fee, this.service_discount, this.business_approxtime, this.categories, this.image);
}