import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toptekker/screens/booking_screen.dart';
import 'package:toptekker/screens/home_screen.dart';
import 'package:toptekker/screens/notification_screen.dart';
import 'package:toptekker/screens/settings_screen.dart';

import '../AppColors.dart';

class BottomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Tekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomPage extends StatefulWidget {
  @override
  BottomPageState createState() => BottomPageState();
}

class BottomPageState extends State<BottomPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BookingPage(),
    NotificationPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
