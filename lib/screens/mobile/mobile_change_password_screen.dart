import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/model/change_password_response_model.dart';
import 'package:toptekker/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import '../../AppColors.dart';
import '../../Util.dart';

class ChangePasswordScreen extends StatelessWidget {
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

class ChangePasswordPage extends StatefulWidget {
  final String mobile;
  final String from;

  ChangePasswordPage({Key? key, required this.from, required this.mobile})
      : super(key: key);

  @override
  ChangePasswordPageState createState() {
    return new ChangePasswordPageState(from, mobile);
  }
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late Util util;
  final String from;
  final String mobile;
  bool _isObscureCurrentPwd = true;
  bool _isObscureNewPwd = true;
  bool _isObscureConfirmPwd = true;

  ChangePasswordPageState(this.from, this.mobile) {
    print("details----> " + from + " ---->" + mobile);
  }

  @override
  void initState() {
    super.initState();
    util = new Util(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: AppColors.PRIMARY_COLOR,
          centerTitle: false,
          title: Text('TopTekker'),
        ),
        body: new Container(
            child: new Column(children: [
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  obscureText: _isObscureCurrentPwd,
                  keyboardType: TextInputType.text,
                  controller: currentPasswordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscureCurrentPwd = !_isObscureCurrentPwd;
                        });
                      },
                      color: AppColors.PRIMARY_COLOR,
                      icon: Icon(_isObscureCurrentPwd
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    border: UnderlineInputBorder(),
                    labelText: 'Current Password',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  obscureText: _isObscureNewPwd,
                  keyboardType: TextInputType.text,
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscureNewPwd = !_isObscureNewPwd;
                        });
                      },
                      color: AppColors.PRIMARY_COLOR,
                      icon: Icon(_isObscureNewPwd
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    border: UnderlineInputBorder(),
                    labelText: 'New Password',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  obscureText: _isObscureConfirmPwd,
                  keyboardType: TextInputType.text,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscureConfirmPwd = !_isObscureConfirmPwd;
                        });
                      },
                      color: AppColors.PRIMARY_COLOR,
                      icon: Icon(_isObscureConfirmPwd
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    border: UnderlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: AppColors.PRIMARY_COLOR,
                  child: Text('Change Password'),
                  onPressed: () {
                    validatePassword(currentPasswordController.text,
                        newPasswordController.text, confirmPasswordController.text);
                  },
                ),
              ),
            ])));
  }

  Future<void> validatePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    bool cancel = true;
    if (from != "otp_login") {
      if (currentPassword.isEmpty) {
        util.showFlutterToast("Please enter current password");
        cancel = false;
      } else if (currentPassword.length != 6) {
        util.showFlutterToast("Please enter valid OTP");
        cancel = false;
      }
    }

    if (newPassword.isEmpty) {
      util.showFlutterToast("Please enter new password");
      cancel = false;
    } else if (newPassword.length != 6) {
      util.showFlutterToast("Please enter current password");
      cancel = false;
    } else if (confirmPassword != newPassword) {
      util.showFlutterToast("Confirm password does not match");
      cancel = false;
    }

    if (cancel) {
      print("match");
      var urls = Apis.modify_password;
      Map data = {'phone': mobile, 'password': newPassword};
      var body = json.encode(data);
      print("body" + body);
      var responses = await http.post(Uri.parse(urls),
          headers: <String, String>{}, body: data);
      print("jsondata" + urls + data.toString());

      if (responses.statusCode == 200) {
        Map<String, dynamic> parsed = jsonDecode(responses.body);
        ChangePasswordResponseModel user =
        ChangePasswordResponseModel.fromJson(parsed);
        if (user.responce.toString() == "true") {
          util.showFlutterToast(user.data);

          var route = new MaterialPageRoute(
              builder: (BuildContext context) => new LoginScreenSize());
          Navigator.of(context).push(route);
        }
      }
    }
  }
}
