import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toptekker/screens/booking_screen.dart';
import 'package:toptekker/screens/venue_screen.dart';
import 'package:get_storage/get_storage.dart';
import '../AppColors.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../ad_helper.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await GetStorage.init();
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Tekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

const String testDevice = '60bedd3a3365fc21';
const int maxFailedLoadAttempts = 3;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  int index = 0;
  final shared_data = GetStorage();
  String? _deviceId;

  late BannerAd _bannerAd;
  bool _isBannerAdReady  = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    String username = shared_data.read('user_name');
    print("is_login"+" ------> "+username);

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
    }


Future<void> initPlatformState() async {
  String? deviceId;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    deviceId = await PlatformDeviceId.getDeviceId;
    print("deviceId----> "+deviceId!);
  } on PlatformException {
    deviceId = 'Failed to get deviceId.';
  }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
  if (!mounted) return;

  setState(() {
    _deviceId = deviceId;
    print("deviceId->$_deviceId");
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: false,
        title: Text('TopTekker'),
      ),
      body: new ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Container(
              child: GestureDetector(
            onTap: () {
              print("click venue");

              var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new VenueScreenPage());
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
          SizedBox(height: 10,),
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd),
              ),
            ),
          )
        ],
      ),
    );
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

