import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../AppColors.dart';
import 'desktop/desktop_order_screen.dart';
import 'mobile/mobile_order_screen.dart';

class OrderScreenSize extends StatelessWidget {
  final String payment_by;
  final String transaction_id;
  final String date;
  final String timeslot;
  final String mem_slots;
  final String interval;
  final String fullname;
  final String email;
  final String phone;
  final String turf_fee;
  final String advance;
  final String convenience_fee;
  final String promo_code;
  final String promo_discount;
  final String type;
  final String pay_for;
  final String plan_id;

  const OrderScreenSize(
      {Key? key,
      required this.payment_by,
      required this.transaction_id,
      required this.date,
      required this.timeslot,
      required this.mem_slots,
      required this.interval,
      required this.fullname,
      required this.email,
      required this.phone,
      required this.turf_fee,
      required this.advance,
      required this.convenience_fee,
      required this.promo_code,
      required this.promo_discount,
      required this.type,
      required this.pay_for,
      required this.plan_id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return DesktopOrderScreenPage(
          width: constraints.maxWidth,
          payment_by: payment_by,
          transaction_id: transaction_id,
          date: date,
          timeslot: timeslot,
          mem_slots: mem_slots,
          interval: interval,
          fullname: fullname,
          email: email,
          phone: phone,
          turf_fee: turf_fee.toString(),
          advance: advance.toString(),
          convenience_fee: convenience_fee.toString(),
          promo_code: promo_code,
          promo_discount: promo_discount,
          type: type,
          pay_for: pay_for,
          plan_id: plan_id,
        );
      } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
        return DesktopOrderScreenPage(
          width: constraints.maxWidth,
          payment_by: payment_by,
          transaction_id: transaction_id,
          date: date,
          timeslot: timeslot,
          mem_slots: mem_slots,
          interval: interval,
          fullname: fullname,
          email: email,
          phone: phone,
          turf_fee: turf_fee.toString(),
          advance: advance.toString(),
          convenience_fee: convenience_fee.toString(),
          promo_code: promo_code,
          promo_discount: promo_discount,
          type: type,
          pay_for: pay_for,
          plan_id: plan_id,
        );
      } else {
        return OrderScreenPage(
          payment_by: payment_by,
          transaction_id: transaction_id,
          date: date,
          timeslot: timeslot,
          mem_slots: mem_slots,
          interval: interval,
          fullname: fullname,
          email: email,
          phone: phone,
          turf_fee: turf_fee.toString(),
          advance: advance.toString(),
          convenience_fee: convenience_fee.toString(),
          promo_code: promo_code,
          promo_discount: promo_discount,
          type: type,
          pay_for: pay_for,
          plan_id: plan_id,
        );
      }
    });
  }
}
