import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/services/web_service.dart';

@JsonSerializable()
class AcademyData {
  @JsonKey(name: "bus_id")
  final String bus_id;
  @JsonKey(name: "user_id")
  final String user_id;
  @JsonKey(name: "bus_title")
  final String bus_title;
  @JsonKey(name: "razorpay_acc")
  final String razorpay_acc;
  @JsonKey(name: "bus_slug")
  final String bus_slug;
  @JsonKey(name: "bus_email")
  final String bus_email;
  @JsonKey(name: "bus_description")
  final String bus_description;
  @JsonKey(name: "bus_google_street")
  final String bus_google_street;
  @JsonKey(name: "bus_latitude")
  final String bus_latitude;
  @JsonKey(name: "bus_longitude")
  final String bus_longitude;
  @JsonKey(name: "bus_contact")
  final String bus_contact;
  @JsonKey(name: "bus_logo")
  final String bus_logo;
  @JsonKey(name: "bus_status")
  final String bus_status;
  @JsonKey(name: "start_time")
  final String start_time;
  @JsonKey(name: "end_time")
  final String end_time;
  @JsonKey(name: "city_id")
  final String city_id;
  @JsonKey(name: "country_id")
  final String country_id;
  @JsonKey(name: "locality_id")
  final String locality_id;
  @JsonKey(name: "is_trusted")
  final String is_trusted;
  @JsonKey(name: "facilities")
  final String facilities;
  @JsonKey(name: "pay_advance")
  final String pay_advance;
  @JsonKey(name: "advance_amount")
  final String advance_amount;
  @JsonKey(name: "currency")
  final String currency;
  @JsonKey(name: "user_fullname")
  final String user_fullname;
  @JsonKey(name: "avg_rating")
  final String avg_rating;
  @JsonKey(name: "total_rating")
  final String total_rating;
  @JsonKey(name: "review_count")
  final String review_count;
  @JsonKey(name: "fcm_topic")
  final String fcm_topic;

  AcademyData(this.bus_id,
      this.user_id,
      this.bus_title,
      this.razorpay_acc,
      this.bus_slug,
      this.bus_email,
      this.bus_description,
      this.bus_google_street,
      this.bus_latitude,
      this.bus_longitude,
      this.bus_contact,
      this.bus_logo,
      this.bus_status,
      this.start_time,
      this.end_time,
      this.city_id,
      this.country_id,
      this.locality_id,
      this.is_trusted,
      this.facilities,
      this.pay_advance,
      this.advance_amount,
      this.currency,
      this.user_fullname,
      this.avg_rating,
      this.total_rating,
      this.review_count,
      this.fcm_topic);

  factory AcademyData.fromJson(Map<String, dynamic> academyDetail) {
    return AcademyData(
      academyDetail['bus_id'],
      academyDetail['user_id'],
      academyDetail['bus_title'],
      academyDetail['razorpay_acc'],
      academyDetail['bus_slug'],
      academyDetail['bus_email'],
      academyDetail['bus_description'],
      academyDetail['bus_google_street'],
      academyDetail['bus_latitude'],
      academyDetail['bus_longitude'],
      academyDetail['bus_contact'],
      academyDetail['bus_logo'],
      academyDetail['bus_status'],
      academyDetail['start_time'],
      academyDetail['end_time'],
      academyDetail['city_id'],
      academyDetail['country_id'],
      academyDetail['locality_id'],
      academyDetail['is_trusted'],
      academyDetail['facilities'],
      academyDetail['pay_advance'],
      academyDetail['advance_amount'],
      academyDetail['currency'],
      academyDetail['user_fullname'],
      academyDetail['avg_rating'],
      academyDetail['total_rating'],
      academyDetail['review_count'],
      academyDetail['fcm_topic'],
    );
  }

  static Resource<List<AcademyData>> get all {
    return Resource(
        url: Apis.get_categories,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['data'];
          return list.map((model) => AcademyData.fromJson(model)).toList();
        }
    );
  }

}
