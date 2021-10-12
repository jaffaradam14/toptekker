import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/data/register_data.dart';
import 'package:toptekker/retrofit/data/user.dart';
import 'package:toptekker/retrofit/model/register_response_model.dart';
import '../AppColors.dart';
import 'package:http/http.dart' as http;

import 'bottom_screen.dart';
import 'home_screen.dart';

class VerificationScreen extends StatelessWidget {
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

class VerificationPage extends StatefulWidget {
  final User value;

  VerificationPage({Key? key, required this.value}) : super(key: key);

  @override
  VerificationPageState createState() {
    return new VerificationPageState(value);
  }
}

class VerificationPageState extends State {
  TextEditingController otpController = TextEditingController();

  final timeOutInSeconds = 29;
  final stepInSeconds = 1;
  int currentNumber = 1;
  final User value;

  String random_otp = Random().nextInt(999999).toString().padLeft(6, '');

  VerificationPageState(this.value) {
    print("random_otp---> "+random_otp);
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
    // Make it start from the timeout value
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
                'Enter OTP',
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
                          verifyOTP(value.username, value.phone, value.email,
                              value.password);
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
                '$number',
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

  Future<void> verifyOTP(
      username, String phone, String email, String password) async {
    var register_url = Apis.register;
    Map data = {
      'user_fullname': username,
      'user_phone': phone,
      'user_email': email,
      'user_password': password
    };

    var body = json.encode(data);
    print("body" + body);
    var register_response = await http.post(Uri.parse(register_url),
        headers: <String, String>{}, body: data);
    print("jsondata" + register_url + data.toString());

    if (register_response.statusCode == 200) {
      var registerData = register_response.body;
      print("registerData" + registerData);

      Map<String, dynamic> parsed = jsonDecode(register_response.body);
      RegisterResponseModel registerResponseModel =
          RegisterResponseModel.fromJson(parsed);

      if (registerResponseModel.responce.toString() == "true") {
        RegisterData registerData = new RegisterData(
          user_id: registerResponseModel.data.user_id,
          user_fullname: registerResponseModel.data.user_fullname,
          user_email: registerResponseModel.data.user_email,
          user_phone: registerResponseModel.data.user_phone,
        );

        showSuccessAlert("",context);

      }
    }
  }

  void showSuccessAlert(String message, BuildContext context){
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
              children:[
                Image(
                    height: 30.0, image: new AssetImage("assets/icons/icon.png")),
                Text('  Logout ')
              ]
          ),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                //Put your code here which you want to execute on Cancel button click.
                Navigator.of(context).pop();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => BottomScreen()));
              },
            ),
          ],
        );
      },
    );
  }
}
