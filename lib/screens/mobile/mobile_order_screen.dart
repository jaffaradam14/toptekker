import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../AppColors.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(OrderScreen());
}

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Tekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OrderScreenPage extends StatefulWidget {
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

  const OrderScreenPage(
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
  OrderScreenPageState createState() {
    return OrderScreenPageState(
        this.payment_by,
        this.transaction_id,
        this.date,
        this.timeslot,
        this.mem_slots,
        this.interval,
        this.fullname,
        this.email,
        this.phone,
        this.turf_fee,
        this.advance,
        this.convenience_fee,
        this.promo_code,
        this.promo_discount,
        this.type,
        this.pay_for,
        this.plan_id);
  }
}

class OrderScreenPageState extends State {
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

  OrderScreenPageState(
      this.payment_by,
      this.transaction_id,
      this.date,
      this.timeslot,
      this.mem_slots,
      this.interval,
      this.fullname,
      this.email,
      this.phone,
      this.turf_fee,
      this.advance,
      this.convenience_fee,
      this.promo_code,
      this.promo_discount,
      this.type,
      this.pay_for,
      this.plan_id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: false,
        title: Text('Order Page'),
      ),
    );
  }
}