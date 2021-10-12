import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toptekker/screens/login_screen.dart';
import 'package:toptekker/screens/register_screen.dart';
import 'package:toptekker/screens/upcoming_screen.dart';

import '../AppColors.dart';
import 'completed_screen.dart';

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Tekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BookingPage extends StatefulWidget {
  @override
  BookingPageState createState() => BookingPageState();
}

class BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.PRIMARY_COLOR,
            centerTitle: false,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Upcoming",
                ),
                Tab(text: "Completed"),
              ],
            ),
            title: Text('TopTekker'),
          ),
          body: TabBarView(
            children: [
              Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => UpcomingScreenPage(),
                ),
              ),
              Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => CompletedScreenPage(),
                ),
              ),
            ],
          ),
        ));
  }
}
