import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toptekker/retrofit/Apis.dart';
import 'dart:async';
import 'package:quiver/async.dart';
import 'package:toptekker/screens/change_password_screen.dart';
import '../AppColors.dart';

class OTPVerificationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OTPVerificationPage extends StatefulWidget{
  final String value;
  OTPVerificationPage({Key? key,required this.value}):super(key: key);

  @override
  OTPVerificationPageState createState() {
    return new OTPVerificationPageState(value);
  }
}

class OTPVerificationPageState extends State{
  TextEditingController otpController = TextEditingController();
  final timeOutInSeconds = 59;
  final stepInSeconds = 1;
  int currentNumber = 1;
  final String value;

  String random_otp = Random().nextInt(999999).toString().padLeft(4, '');

  OTPVerificationPageState(this.value) {
    print("phone_number"+value);
    print("random_otp"+random_otp);
    //sendOTP(random_otp);
    startTimer();
  }

  Future<void> sendOTP(String otp) async {
    String message = otp +
        " is OTP for Top Tekker registration. Please do not share with anyone.";
    String URL = "http://acc.mydreamstechnology.in/vb/apikey.php?apikey=" +
        Apis.API_KEY +
        "&%20senderid=TOPTEK&number=" +
        "8148970894" +
        "&templateid=1207161725450952458&message=" +
        message;
    print("message_url" + URL);

    var register_response =
    await http.post(Uri.parse(URL), headers: <String, String>{}, body: "");
    print("jsondata" + register_response.toString());
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
        new Duration(seconds: timeOutInSeconds),
        new Duration(seconds: stepInSeconds));

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      currentNumber += stepInSeconds;
      this.onTimerTick(currentNumber);
      print('Your message here: $currentNumber');
    });

    sub.onDone(() {
      print("I'm done");

      sub.cancel();
    });
  }

  void onTimerTick(int currentNumber) {
    setState(() {
      currentNumber = currentNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    int number = timeOutInSeconds - currentNumber;
    number += stepInSeconds;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: AppColors.PRIMARY_COLOR,
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10.0),
          children: [
            Container(
              child: Text(
                'An OTP has been sent to your mobile number. Please enter it',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.all(6),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: otpController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter OTP',
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(130, 10, 130, 0),
                child: ButtonTheme(
                  minWidth: 20.0,
                  height: 50.0,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Color(0XFF2E7D32),
                    child: Text('Verify'),
                    onPressed: () {
                      if (otpController.text.isNotEmpty) {
                        if (otpController.text == random_otp) {
                          var route = new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new ChangePasswordPage(from: "otp_login",mobile: value,));
                          Navigator.of(context).push(route);
                        } else {
                          showFlutterToast("Please enter valid OTP");
                        }
                      } else {
                        showFlutterToast("Please enter OTP");
                      }
                    },
                  ),
                )),
            Container(
              height: 20.0,
            ),
            Container(
              child: Text(
                "00 : "+'$number',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }


  void showFlutterToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$message'),
      ),
    );
  }

}