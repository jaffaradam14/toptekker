import 'package:flutter/material.dart';

import '../../AppColors.dart';
import '../booking_screen.dart';
import '../home_screen.dart';
import '../notification_screen.dart';
import '../settings_screen.dart';

class DesktopBottomScreen extends StatelessWidget {
  final double width;

  const DesktopBottomScreen({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Tekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomPage(width),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomPage extends StatefulWidget {
  final double width;

  BottomPage(this.width);

  @override
  BottomPageState createState() => BottomPageState(width);
}

class BottomPageState extends State<BottomPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreenSize(),
    BookingPage(),
    NotificationPage(),
    SettingsPage(),
  ];

  late double marginSpace;
  late double width;

  BottomPageState(this.width);

  @override
  void initState() {
    super.initState();

    setState(() {
      marginSpace = width / 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(marginSpace, 0, marginSpace, 0),
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: AppColors.PRIMARY_COLOR,
                ),
                title: new Text(
                  "Home",
                  style: TextStyle(color: AppColors.PRIMARY_COLOR),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  color: AppColors.PRIMARY_COLOR,
                ),
                title: Text(
                  'Bookings',
                  style: TextStyle(color: AppColors.PRIMARY_COLOR),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  color: AppColors.PRIMARY_COLOR,
                ),
                title: Text(
                  'Notifications',
                  style: TextStyle(color: AppColors.PRIMARY_COLOR),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: AppColors.PRIMARY_COLOR,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(color: AppColors.PRIMARY_COLOR),
                ),
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          body: Container(
              child: _widgetOptions.elementAt(_selectedIndex)),
        )
    );
  }
}
