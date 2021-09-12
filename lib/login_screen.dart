import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toptekker/AppColors.dart';
import 'package:toptekker/Util.dart';
import 'package:toptekker/register.dart';

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

  @override
  void initState() {
    super.initState();
    util = new Util(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child:
                Image(height: 90.0, image: new AssetImage("assets/icon.png")),
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: nameController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(
                    color: myFocusNode.hasFocus
                        ? AppColors.PRIMARY_COLOR
                        : Colors.black),
                labelText: 'User Name',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
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

            },
            textColor: AppColors.PRIMARY_COLOR,
            child: Text('Reset My Password'),
          ),
        ],
      ),
    ));
  }

  void checkValidate(TextEditingController nameController,
      TextEditingController passwordController) {
    bool cancel = true;

    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter username",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
      cancel = false;
    } else if (nameController.text.length < 10) {
      Fluttertoast.showToast(
          msg: "Please enter valid phone number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
      cancel = false;
    } else if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
      cancel = false;
    } else if (passwordController.text.length < 6 ||
        passwordController.text.length > 6) {
      Fluttertoast.showToast(
          msg: "Please enter valid password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
      cancel = false;
    }
    if (cancel) {
      print(nameController.text);
    }
  }

  void showFlutterToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

  void gotoRegister() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Register()));
  }
}
