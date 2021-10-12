import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toptekker/AppColors.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:http/http.dart' as http;
import 'package:toptekker/retrofit/data/completed_response_data_model.dart';

import '../Util.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(UpcomingScreen());
}

class UpcomingScreen extends StatelessWidget {
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

class UpcomingScreenPage extends StatefulWidget {
  @override
  UpcomingScreenState createState() {
    return new UpcomingScreenState();
  }
}

class UpcomingScreenState extends State {
  late SharedPreferences sharedPreferences;
  String user_id = "";
  final List<CompletedResponseDataModel> completed_response_details = [];
  late Util util;
  final shared_data = GetStorage();

  @override
  void initState() {
    super.initState();
    util = new Util(context);
    getSharedPreferenceValue();
    getBookingDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: this.completed_response_details.length,
          itemBuilder: _listViewItemBuilder,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10,
            );
          }),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var newsDetail = this.completed_response_details[index];

    List months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    var separated = newsDetail.appointment_date.split("-");
    print("date_separated---> " + separated[0]);
    print("date_separated---> " + separated[1]);
    print("date_separated---> " + separated[2]);

    var current_mon = separated[1];
    print(months[int.parse(current_mon) - 1]);

    var cancel_status;
    if (newsDetail.is_cancelled == "1") {
      if (newsDetail.cancelled_by == user_id) {
        cancel_status = "Cancelled";
      } else {
        cancel_status = "Cancelled by Acadamy";
      }
    } else {
      cancel_status = "";
    }

    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.PRIMARY_COLOR)
              ),
              child: Column(children: [
                Container(
                  child: Text(
                    months[int.parse(current_mon) - 1],
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
                Container(
                  child: Text(
                    separated[2],
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
                Container(
                  child: Text(
                    separated[2],
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                )
              ]),
            ),
            flex: 1,
          ),
          new Flexible(
            child: Column(children: [
              Container(
                child: Text(
                  newsDetail.bus_title,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
              Container(
                child: Text(
                  newsDetail.service_title,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ),
              Container(
                child: Text(
                  newsDetail.start_time,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
              Container(
                child: Text(
                  cancel_status,
                  style: TextStyle(fontSize: 16.0, color: Colors.red),
                ),
              )
            ]),
            flex: 4,
          ),
          new Flexible(
            child:Image.network(
                    Apis.base_url +
                        "/uploads/admin/category/" +
                        newsDetail.cat_image,
                    height: 35,
                    fit: BoxFit.fitHeight,
                  ),
            flex: 0,
          ),
        ],
      ),
    );
  }

  Future<void> getSharedPreferenceValue() async {
    user_id = shared_data.read("user_id");
    print("user_id" + user_id);
  }

  Future<void> getBookingDetails() async {
    var urls = Apis.my_appointments;
    Map data = {
      'user_id': user_id,
      'type': "upcoming",
      'bus_id': "0",
    };
    print("getBookingDetails_data" + data.toString());
    var response = await http.post(Uri.parse(urls),
        headers: <String, String>{}, body: data);

    if (response.statusCode == 200) {
      var userData = response.body;
      print("userData" + userData);
      completed_response_details.clear();

      final Map<String, dynamic> responseData = json.decode(response.body);
      if(!responseData['data'].isEmpty){
        responseData['data'].forEach((completedBookingDetails) {
          if (completedBookingDetails != null) {
            final CompletedResponseDataModel completedResponseDataModel =
            CompletedResponseDataModel(
                completedBookingDetails['id'],
                completedBookingDetails['user_id'],
                completedBookingDetails['bus_id'],
                completedBookingDetails['doct_id'],
                completedBookingDetails['service_id'],
                completedBookingDetails['appointment_date'],
                completedBookingDetails['booking_date_and_start_time'],
                completedBookingDetails['start_time'],
                completedBookingDetails['slot_interval'],
                completedBookingDetails['cat_id'],
                completedBookingDetails['cat_title'],
                completedBookingDetails['cat_image'],
                completedBookingDetails['service_title'],
                completedBookingDetails['time_token'],
                completedBookingDetails['status'],
                completedBookingDetails['app_name'],
                completedBookingDetails['app_email'],
                completedBookingDetails['app_phone'],
                completedBookingDetails['created_at'],
                completedBookingDetails['payment_type'],
                completedBookingDetails['payment_ref'],
                completedBookingDetails['payment_mode'],
                completedBookingDetails['payment_amount'],
                completedBookingDetails['advance_paid'],
                completedBookingDetails['convenience_fee'],
                completedBookingDetails['promo_code'],
                completedBookingDetails['promo_discount'],
                completedBookingDetails['promo_description'],
                completedBookingDetails['bus_title'],
                completedBookingDetails['country_name'],
                completedBookingDetails['currency'],
                completedBookingDetails['cancelled_by'],
                completedBookingDetails['is_cancelled'],
                completedBookingDetails['cancel_reason'],
                completedBookingDetails['type'],
                completedBookingDetails['plan_id'],
                completedBookingDetails['mem_plan_id'],
                completedBookingDetails['discount'],
                completedBookingDetails['description'],
                completedBookingDetails['cancellation_policy'],
                completedBookingDetails['cancellation_hour'],
                completedBookingDetails['bus_contact']);
            setState(() {
              completed_response_details.add(completedResponseDataModel);
              print("completed_response_details----> "+completed_response_details.toString());
            });
          }
        });
      }else{
        util.showFlutterToast("No data found");
      }
    }
  }
}
