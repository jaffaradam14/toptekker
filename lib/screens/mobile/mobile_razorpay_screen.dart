import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/model/ActiveModel/academy_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/active_model.dart';
import 'package:http/http.dart' as http;
import '../../AppColors.dart';
import '../../Util.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(RazorpayScreen());
}

class RazorpayScreen extends StatelessWidget {
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

class RazorpayScreenPage extends StatefulWidget {
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

  const RazorpayScreenPage(
      {Key? key,
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
  RazorpayScreenPageState createState() {
    return new RazorpayScreenPageState(
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

class RazorpayScreenPageState extends State {
  static const platform = const MethodChannel("razorpay_flutter");
  late Razorpay _razorpay;
  late Util util;
  final sharedData = GetStorage();
  var userTypeId;
  var userId;
  double amount_to_pay = 0.0;

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

  RazorpayScreenPageState(
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
  void initState() {
    super.initState();
    util = new Util(context);

    userTypeId = sharedData.read("user_type_id");
    userId = sharedData.read("user_id");

    amount_to_pay = double.parse(convenience_fee) + double.parse(advance);

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    createOrder();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: false,
        title: Text('Payment'),
      ),
      body: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(onPressed: openCheckout, child: Text('Open'))
              ])),
    );
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_2YaqequAOR5hd7',
      'amount': 100,
      'name': 'Top Tekker',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    util.showFlutterToast("SUCCESS: " + response.paymentId!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    util.showFlutterToast("ERROR: " + response.code.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    util.showFlutterToast("EXTERNAL_WALLET: " + response.walletName!);
  }

  Future<void> createOrder() async {
    BusinessModel businessModel = ActiveModels.businessModel!;

    var urls = Apis.create_order;
    Map data = {
      'total_amount': "100",
      'transfer_amount': "1",
      'bus_id': businessModel.bus_id,
      'user_id': userId,
      'pay_for': "cash"
    };

    var body = json.encode(data);
    print("body" + body);
    var responses = await http.post(Uri.parse(urls),
        headers: <String, String>{}, body: data);

    print("jsondata" + urls + data.toString());

    if (responses.statusCode == 200) {
      openCheckout();
    }
  }
}