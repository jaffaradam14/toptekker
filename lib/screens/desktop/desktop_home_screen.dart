import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:toptekker/screens/venue_screen.dart';

import '../../AppColors.dart';
import '../../ad_helper.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(DesktopHomeScreen());
}

class DesktopHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Tekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DesktopHomeScreenPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

const String testDevice = '60bedd3a3365fc21';
const int maxFailedLoadAttempts = 3;

class DesktopHomeScreenPage extends StatefulWidget {
  @override
  DesktopHomeScreenPageState createState() => DesktopHomeScreenPageState();
}

class DesktopHomeScreenPageState extends State<DesktopHomeScreenPage> {
  int index = 0;
  final shared_data = GetStorage();
  String? _deviceId;

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    String username = shared_data.read('user_name');
    print("is_login" + " ------> " + username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.PRIMARY_COLOR,
          centerTitle: false,
          title: Text('TopTekker'),
        ),
        body: Container(
          constraints: BoxConstraints(maxWidth: 400),
          child: ListView(
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              Container(
                  child: GestureDetector(
                onTap: () {
                  print("click venue");

                  var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new VenueScreenSize());
                  Navigator.of(context).push(route);
                }, // handle your image tap here
                child: Image.asset(
                  'assets/images/banner1_1.png',
                  fit: BoxFit.cover, // this is the solution for border
                  width: 110.0,
                  height: 110.0,
                ),
              )),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  child: GestureDetector(
                onTap: () {
                  print("click coach");
                }, // handle your image tap here
                child: Image.asset(
                  'assets/images/banner3_1.png',
                  fit: BoxFit.cover, // this is the solution for border
                  width: 110.0,
                  height: 110.0,
                ),
              )),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  child: GestureDetector(
                onTap: () {
                  print("click tournament");
                }, // handle your image tap here
                child: Image.asset(
                  'assets/images/banner2_1.png',
                  fit: BoxFit.cover, // this is the solution for border
                  width: 110.0,
                  height: 110.0,
                ),
              )),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  child: GestureDetector(
                onTap: () {
                  print("click membership");
                }, // handle your image tap here
                child: Image.asset(
                  'assets/images/membership.png',
                  fit: BoxFit.cover, // this is the solution for border
                  width: 110.0,
                  height: 110.0,
                ),
              )),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

/*void navigateToScreens(int index) {
  if (index == 0) {
    print("home");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  } else if (index == 1) {
    print("bookings");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingScreen()),
    );
  } else if (index == 2) {
    print("notification");
  } else if (index == 3) {
    print("settings");
  }
}*/
}
