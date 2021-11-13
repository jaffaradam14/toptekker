import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toptekker/retrofit/data/user.dart';

import '../../AppColors.dart';
import '../../Util.dart';
import '../verification_screen.dart';

class DesktopRegisterScreen extends StatelessWidget {
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

class DesktopRegisterPage extends StatefulWidget {
  
  final double width;

  const DesktopRegisterPage({Key? key, required this.width}) : super(key: key);
  
  @override
  DesktopRegisterPageState createState(){
    return DesktopRegisterPageState(width);
  }
}

class DesktopRegisterPageState extends State<DesktopRegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Util util;
  var checkedValue = false;
  FocusNode myFocusNode = new FocusNode();
  
  final double width;
  late double marginSpace;
  
  DesktopRegisterPageState(this.width);
  
  @override
  void initState() {
    super.initState();
    util = new Util(context);

    setState(() {
      marginSpace = width / 3;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: AppColors.PRIMARY_COLOR,
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(marginSpace, 0, marginSpace, 0),
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Image(
                  height: 90.0, image: new AssetImage("assets/icons/icon.png")),
            ),
            Container(
              padding: EdgeInsets.all(6),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: nameController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? AppColors.PRIMARY_COLOR
                          : Colors.black),
                  labelText: 'Full Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? AppColors.PRIMARY_COLOR
                          : Colors.black),
                  labelText: 'Phone',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? AppColors.PRIMARY_COLOR
                          : Colors.black),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? AppColors.PRIMARY_COLOR
                          : Colors.black),
                  labelText: 'Create Password',
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(6),
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('By signing or in, you accept our'),
                  value: checkedValue,
                  onChanged: (bool? value) {
                    setState(() {
                      checkedValue = value!;
                    });
                  },
                )),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0XFF2E7D32),
                child: Text('Register New User'),
                onPressed: () {
                  checkValidate(nameController, phoneController, emailController,
                      passwordController);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkValidate(
      TextEditingController nameController,
      TextEditingController phoneController,
      TextEditingController emailController,
      TextEditingController passwordController) {
    bool cancel = true;

    if (nameController.text.isEmpty) {
      util.showFlutterToast("Please enter username");
      cancel = false;
    } else if (phoneController.text.isEmpty) {
      util.showFlutterToast("Please enter phone number");
      cancel = false;
    } else if (phoneController.text.length < 10) {
      util.showFlutterToast("Please enter valid phone number");
      cancel = false;
    } else if (emailController.text.isEmpty) {
      util.showFlutterToast("Please enter email");
      cancel = false;
    } else if (!validateEmail(emailController.text)) {
      util.showFlutterToast("Please enter valid email address");
      cancel = false;
    } else if (passwordController.text.isEmpty) {
      util.showFlutterToast("Please enter password");
      cancel = false;
    } else if (passwordController.text.length < 6 ||
        passwordController.text.length > 6) {
      util.showFlutterToast("Please enter valid password");
      cancel = false;
    } else if (!checkedValue) {
      util.showFlutterToast("Please check terms and condition");
      cancel = false;
    }

    if (cancel) {
      callRegister(
          nameController, phoneController, emailController, passwordController);
    }
  }

  Future<void> callRegister(
      TextEditingController nameController,
      TextEditingController phoneController,
      TextEditingController emailController,
      TextEditingController passwordController) async {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) => new VerificationPage(
            value: User(nameController.text, phoneController.text,
                emailController.text, passwordController.text)));
    Navigator.of(context).push(route);
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern as String);
    if (!regex.hasMatch(value) || value == null)
      return false;
    else
      return true;
  }
}