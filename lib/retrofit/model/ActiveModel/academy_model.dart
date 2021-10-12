import 'package:flutter/cupertino.dart';

class AcademyModel {

  final String bus_id;
  final String user_id;
  final String bus_title;
  final String razorpay_acc;
  final String bus_slug;
  final String bus_email;
  final String bus_description;
  final String bus_google_street;
  final String bus_latitude;
  final String bus_longitude;
  final String bus_contact;
  final String bus_logo;
  final String bus_status;
  final String start_time;
  final String end_time;
  final String city_id;
  final String country_id;
  final String locality_id;
  final String is_trusted;
  final String facilities;
  final String pay_advance;
  final String advance_amount;
  final String currency;
  final String user_fullname;
  final String avg_rating;
  final String total_rating;
  final String review_count;
  final String fcm_topic;


  AcademyModel(this.bus_id,
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
}
