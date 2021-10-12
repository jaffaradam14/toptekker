import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../AppColors.dart';
import '../Util.dart';

class RazorpayScreen extends StatelessWidget{
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

class RazorpayScreenPage extends StatefulWidget{
  @override
  RazorpayScreenPageState createState(){
    return new RazorpayScreenPageState();
  }
}

class RazorpayScreenPageState extends State{
  static const platform = const MethodChannel("razorpay_flutter");
  late Razorpay _razorpay;
  late Util util;

  @override
  void initState() {
    super.initState();
    util = new Util(context);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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

}