// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'screens/bottom_screen.dart';
import 'screens/login_screen.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isGotoNextPage = false;

  SharedPreferences logindata;

  final shared_data = GetStorage();

  @override
  void initState() {
    super.initState();
    check_login_state();
    getLocation();
  }

  Future<void> check_login_state() async {
    logindata = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image(image: new AssetImage("assets/images/screen.png")),
        ]);
  }

  Future<void> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    location.onLocationChanged.listen((LocationData currentLocation) {
      if (!isGotoNextPage) {
        if (currentLocation.latitude != 0.0 &&
            currentLocation.longitude != 0.0) {
          isGotoNextPage = true;

          bool isLoggedIn = shared_data.read('is_user_logged_in');
          if (isLoggedIn == null) {
            isLoggedIn = false;
          }
          print("is_login" + isLoggedIn.toString()+" ------> ");

          if (!isLoggedIn) {
            Timer(
                Duration(seconds: 1),
                () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen())));
          } else {
            Timer(
                Duration(seconds: 1),
                () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BottomPage())));
          }
        }
      }
    });
  }
}
