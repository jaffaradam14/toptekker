import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/data/login_data_model.dart';
import 'package:toptekker/retrofit/data/validate_user_data.dart';
import 'package:toptekker/retrofit/model/check_validate_user_model.dart';
import 'package:toptekker/retrofit/model/login_response_model.dart';
import 'package:http/http.dart' as http;
import '../../AppColors.dart';
import '../../Util.dart';
import '../bottom_screen.dart';
import '../otp_verification_screen.dart';
import '../register_screen.dart';
import 'mobile_register_screen.dart';


Future<void> main() async {
  await GetStorage.init();
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();
  var util;
  FocusNode myFocusNode = new FocusNode();
  bool _isObscure = true;
  late SharedPreferences logindata;

  final is_user_logged_in = GetStorage();

  @override
  void initState() {
    super.initState();
    shared_preference();
    util = new Util(context);
  }

  Future<void> shared_preference() async {
    logindata = await SharedPreferences.getInstance();
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        //SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        child: Scaffold(
            body: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10.0),
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Image(
                        height: 90.0,
                        image: new AssetImage("assets/icons/icon.png")),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    child: TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      keyboardType: TextInputType.number,
                      controller: nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                        border: UnderlineInputBorder(),
                        labelText: 'Phone number',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          color: AppColors.PRIMARY_COLOR,
                          icon: Icon(
                              _isObscure ? Icons.visibility_off : Icons.visibility),
                        ),
                        border: UnderlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Color(0XFF2E7D32),
                      child: Text('Login Now'),
                      onPressed: () {
                        checkValidate(nameController, passwordController);
                      },
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: AppColors.PRIMARY_COLOR,
                      child: Text('Register New User'),
                      onPressed: () {
                        gotoRegister();
                      },
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      showResetAlertDialog(context);
                    },
                    textColor: AppColors.PRIMARY_COLOR,
                    child: Text('Reset My Password'),
                  ),
                ],
              ),
            )));
  }

  showResetAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reset Password'),
            content: TextField(
              controller: resetPasswordController,
              decoration: InputDecoration(hintText: 'Enter phone number'),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop();
                  validateResetPassword(resetPasswordController);
                },
              )
            ],
          );
        });
  }

  Future<void> validateResetPassword(
      TextEditingController resetPasswordController) async {
    bool cancel = true;
    if (resetPasswordController.text.isEmpty) {
      util.showFlutterToast('Please enter mobile number');
      cancel = false;
    } else if (resetPasswordController.text.length < 6 ||
        resetPasswordController.text.length < 6) {
      util.showFlutterToast('Please enter valid mobile number');
      cancel = false;
    }

    if (cancel) {
      print(resetPasswordController.text);
      var urls = Apis.find_user;
      Map data = {'phone': resetPasswordController.text};
      var body = json.encode(data);
      print("body" + body);
      var responses = await http.post(Uri.parse(urls),
          headers: <String, String>{}, body: data);

      print("jsondata" + urls + data.toString());

      if (responses.statusCode == 200) {
        var userData = responses.body;
        print("userData" + userData);

        Map<String, dynamic> parsed = jsonDecode(responses.body);
        CheckValidUserResponseModel user =
        CheckValidUserResponseModel.fromJson(parsed);

        if (user.responce.toString() == "true") {
          ValidateUserData loginData = new ValidateUserData(
              user.data.user_id,
              user.data.user_fullname,
              user.data.user_phone,
              user.data.user_image);
          print("loginData" + loginData.user_fullname);

          gotoOTPVerificationPage(user.data.user_phone);
        } else {
          util.showFlutterToast("Something went error. Please try again...!");
        }
      }
    }
  }

  void checkValidate(TextEditingController nameController,
      TextEditingController passwordController) {
    bool cancel = true;

    if (nameController.text.isEmpty) {
      util.showFlutterToast("Please enter username");
      cancel = false;
    } else if (nameController.text.length < 10) {
      util.showFlutterToast("Please enter valid phone number");
      cancel = false;
    } else if (passwordController.text.isEmpty) {
      util.showFlutterToast("Please enter password");
      cancel = false;
    } else if (passwordController.text.length < 6 ||
        passwordController.text.length > 6) {
      util.showFlutterToast("Please enter valid password");
      cancel = false;
    }
    if (cancel) {
      print(nameController.text);
      callLogin(nameController.text, passwordController.text);
    }
  }

  void callLogin(String name, String password) async {
    var urls = Apis.login;
    Map data = {'user_phone': name, 'user_password': password};
    var body = json.encode(data);
    print("body" + body);
    var responses = await http.post(Uri.parse(urls),
        headers: <String, String>{}, body: data);

    print("jsondata" + urls + data.toString());

    if (responses.statusCode == 200) {
      var userData = responses.body;
      print("userData" + userData);

      Map<String, dynamic> parsed = jsonDecode(responses.body);
      LoginResponseModel user = LoginResponseModel.fromJson(parsed);

      if (user.responce.toString() == "true") {
        LoginData loginData = new LoginData(
            user.data.user_id,
            user.data.user_fullname,
            user.data.user_email,
            user.data.user_phone,
            user.data.user_type_id,
            user.data.is_phone_verified,
            user.data.bus_id);

        print("loginData" + loginData.user_fullname);

        //logindata.setBool('is_user_logged_in', true);
        is_user_logged_in.write('is_user_logged_in', true);
        is_user_logged_in.write('user_name', user.data.user_fullname);
        is_user_logged_in.write('user_name', user.data.user_fullname);
        is_user_logged_in.write('user_id', user.data.user_id);
        is_user_logged_in.write('user_email', user.data.user_email);
        is_user_logged_in.write('user_phone', user.data.user_phone);
        is_user_logged_in.write('user_type_id', user.data.user_type_id);

        if (user.data.user_type_id == "3") {
          is_user_logged_in.write('bus_id', user.data.bus_id);
        }

        /*Provider.of<UserProvider>(context, listen: false).setUser(loginData);*/
        if (user.data.is_phone_verified == "1") {
          gotoHomePage();
        } else {
          gotoOTPVerificationPage(user.data.user_phone);
        }
      } else if (user.responce.toString() == "false") {
        util.showFlutterToast("Invalid username or password");
      }
    }
  }

  void gotoRegister() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => RegisterScreenSize()));
  }

  void gotoHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => BottomScreenSize()));
  }

  void gotoOTPVerificationPage(String user_phone) {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) =>
        new OTPVerificationScreenSize(value: user_phone));
    Navigator.of(context).push(route);
  }
}