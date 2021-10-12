import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/data/notification_response_model_data.dart';
import '../AppColors.dart';
import '../Util.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  await GetStorage.init();
  runApp(NotificationScreen());
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Tekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotificationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotificationPage extends StatefulWidget {
  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  late SharedPreferences sharedPreferences;
  String user_id = "";
  late Util util;
  final List<NotificationResponseModelData> notification_response_details = [];
  final shared_data = GetStorage();

  @override
  void initState() {
    super.initState();

    getSharedPreferenceValue();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: false,
        title: Text('Notification'),
      ),
      body: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: _listViewItemBuilder,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 4,
            );
          },
          itemCount: this.notification_response_details.length),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var newsDetail = this.notification_response_details[index];

    var separated = newsDetail.date.split(" ");
    print("date_separated---> " + separated[0]);
    print("date_separated---> " + separated[1]);

    var separated_1 = separated[1].split(":");
    print("time_separated---> " + separated_1[0]);
    print("time_separated---> " + separated_1[1]);
    print("time_separated---> " + separated_1[2]);

    return InkWell(
        onTap: () {
          showNotifyAlert(newsDetail.bus_title, newsDetail.noti_image,
              newsDetail.noti_description);
        },
        child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  new Flexible(
                    child: Image.network(
                      Apis.base_url +
                          "/uploads/business/" +
                          newsDetail.bus_logo,
                      height: 35,
                      fit: BoxFit.fitHeight,
                    ),
                    flex: 0,
                  ),
                  new Flexible(
                    child: Column(children: [
                      Container(
                        child: Text(
                          newsDetail.bus_title,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.PRIMARY_COLOR,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Text(
                          newsDetail.noti_title,
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                      Container(
                        child: Text(
                          newsDetail.type,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                    ]),
                    flex: 4,
                  ),
                  new Flexible(
                    child: Container(
                      child: Column(children: [
                        Container(
                          child: Text(
                            separated[0],
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                        Container(
                          child: Text(
                            separated[1],
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                      ]),
                    ),
                    flex: 1,
                  ),
                ])));
  }

  Future<void> getSharedPreferenceValue() async {
    user_id = shared_data.read("user_id");
    print("user_id" + user_id);
  }

  Future<void> getNotifications() async {
    var urls = Apis.get_user_notifications;
    Map data = {
      'user_id': user_id,
    };

    print("getNotifications_data" + data.toString());
    var response = await http.post(Uri.parse(urls),
        headers: <String, String>{}, body: data);

    if (response.statusCode == 200) {
      var userData = response.body;
      print("userData" + userData);
      notification_response_details.clear();

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (!responseData['data'].isEmpty) {
        responseData['data'].forEach((notification_details) {
          NotificationResponseModelData notificationResponseModelData =
              NotificationResponseModelData(
                  notification_details['noti_id'],
                  notification_details['noti_title'],
                  notification_details['noti_description'],
                  notification_details['type'],
                  notification_details['noti_image'],
                  notification_details['noti_video'],
                  notification_details['date'],
                  notification_details['bus_id'],
                  notification_details['views'],
                  notification_details['bus_title'],
                  notification_details['bus_logo']);
          setState(() {
            notification_response_details.add(notificationResponseModelData);
          });
        });
      }
    }
  }

  void showNotifyAlert(
      String bus_title, String noti_image, String noti_description) {
    print("bus_title" + bus_title);
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(bus_title),
            content:Container(
              height: 420,
              child: Column(children: [
                Container(
                  child: Image.network(
                    noti_image,
                    height: 300,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Text(
                    noti_description,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok",textAlign: TextAlign.right,),
                    ))
              ]),
            ),
          );
        });
  }
}
