import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/data/time_slot_morning_data.dart';
import 'package:toptekker/retrofit/data/turf_response_data_model.dart';
import 'package:toptekker/retrofit/data/venue_data.dart';
import 'package:toptekker/retrofit/services/web_service.dart';
import '../AppColors.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:http/http.dart' as http;

import 'contact_info_screen.dart';

class TimeSlotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Tekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TimeSlotScreenPage extends StatefulWidget {
  @override
  TimeSlotScreenPageState createState() {
    return new TimeSlotScreenPageState();
  }
}

class TimeSlotScreenPageState extends State {
  late String selectedDate;
  late int idx;
  late List seperated;
  final List<TurfResponseModel> turf_response = [];
  List<VenueData> categoryDetails = [];

  final List<TimeSlotMorningData> timeslotmorningdata = [];

  @override
  void initState() {
    super.initState();
    getCategory();
    getTurf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.PRIMARY_COLOR,
          centerTitle: false,
          title: Text('TopTekker'),
        ),
        body: Stack(children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              _buildTableCalendar(),
              SizedBox(
                height: 10,
              ),
              const Divider(
                height: 0.1,
                thickness: 1.2,
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 60,
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: this.categoryDetails.length,
                itemBuilder: _listViewItemBuilder,
              )),
              SizedBox(
                height: 10,
              ),
              const Divider(
                height: 0.1,
                thickness: 1.2,
                indent: 0,
                endIndent: 0,
              ),
              Container(
                  child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: this.turf_response.length,
                itemBuilder: listTurfItemBuilder,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 1.8),
              )),
              const Divider(
                height: 0.1,
                thickness: 1.2,
                indent: 0,
                endIndent: 0,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: this.timeslotmorningdata.length,
                    itemBuilder: _listViewTimeSlotItemBuilder,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 1.0,
                        childAspectRatio: 2),
                  )),
            ]),
          ),
        ]),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: new BottomAppBar(
        child: InkWell(
          onTap: (){
            gotoContactPage();
          },
          child: Container(
            height: 50,
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      AppColors.PRIMARY_COLOR,
                      AppColors.PRIMARY_COLOR,
                    ]
                )
            ),
            child: new Row(
              mainAxisAlignment : MainAxisAlignment.center,
              mainAxisSize : MainAxisSize.max,
              crossAxisAlignment : CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child:Text("Book Now",style: TextStyle(
                      color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold,
                    ) ,)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var newsDetail = this.categoryDetails[index];
    return InkWell(
        child: Container(
            height: 10,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: newsDetail.image == null
                        ? null
                        : Image.network(
                            Apis.base_url +
                                "/uploads/admin/category/" +
                                newsDetail.image,
                            fit: BoxFit.fitHeight,
                          ),
                    height: 50,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      newsDetail.title,
                    ),
                  )
                ],
              ),
            )));
  }

  Widget listTurfItemBuilder(BuildContext context, int index) {
    var newsDetail = this.turf_response[index];
    return InkWell(
        child: Container(
            child: ListTile(
      contentPadding: EdgeInsets.all(13.0),
      title: _itemTurfTitle(newsDetail),
      onTap: () {
        getSlotTimings();
      },
    )));
  }

  Widget _listViewTimeSlotItemBuilder(BuildContext context, int index) {
    var newsDetail = this.timeslotmorningdata[index];
    return InkWell(
        child: Column(
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            height: 50,
            child: ListTile(
              title: _itemTimeSlotThumbnail(newsDetail),
              subtitle: _itemTimeSlotTitle(newsDetail),
              onTap: () {},
            ))
      ],
    ));
  }

  Widget _itemTimeSlotThumbnail(TimeSlotMorningData newsDetail) {
    return Container(
        padding: const EdgeInsets.all(3.0),
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: Text(
          newsDetail.slot_label,
          style: new TextStyle(fontSize: 11.0),
        ));
  }

  Widget _itemTimeSlotTitle(TimeSlotMorningData newsDetail) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(
          newsDetail.price,
          textAlign: TextAlign.center,
          style: new TextStyle(color: Colors.orange),
        ));
  }

  Widget _itemTurfTitle(TurfResponseModel turfData) {
    return Container(
        height: 50,
        alignment: Alignment.center,
        color: AppColors.PRIMARY_COLOR,
        child: Text(
          turfData.service_title,
          textAlign: TextAlign.center,
          style: new TextStyle(fontSize: 16.0, color: Colors.white),
        ));
  }

  Widget _itemThumbnail(VenueData newsDetail) {
    return Container(
      child: newsDetail.image == null
          ? null
          : Image.network(
              Apis.base_url + "/uploads/admin/category/" + newsDetail.image,
              fit: BoxFit.fitHeight,
            ),
    );
  }

  Widget _itemTitle(VenueData newsDetail) {
    return Text(
      newsDetail.title,
    );
  }

  Widget _buildTableCalendar() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    DateTime date2 = date.add(Duration(days: 6000, hours: 23));
    DateTime date3 = date.add(Duration(days: -2, hours: 23));

    print("seperated----> " + getDate(date));
    print("date----> " + date.toString());
    print("date_later---> " + date2.toString());
    print("date_ago---> " + date3.toString());

    return Container(
        color: AppColors.PRIMARY_COLOR,
        child: CalendarTimeline(
          initialDate: DateTime(now.year, now.month, now.day),
          firstDate: DateTime(now.year, now.month, now.day),
          lastDate: DateTime(date2.year, date2.month, date2.day),
          onDateSelected: (date) => {print("selectedDate" + getDate(date))},
          leftMargin: 20,
          monthColor: Colors.white,
          dayColor: Colors.grey,
          activeDayColor: Colors.yellow,
          activeBackgroundDayColor: AppColors.PRIMARY_COLOR,
          dotsColor: AppColors.PRIMARY_COLOR,
        ));
  }

  String getDate(DateTime date) {
    selectedDate = date.toString();
    idx = selectedDate.indexOf(" ");
    seperated = [
      selectedDate.substring(0, idx).trim(),
      selectedDate.substring(idx + 1).trim()
    ];

    return seperated[0];
  }

  void getCategory() {
    Map data = {};
    Webservice().load(VenueData.all).then((newsArticles) => {
          setState(() => {categoryDetails = newsArticles})
        });
  }

  Future<void> getTurf() async {
    var urls = Apis.get_services;
    Map data = {
      'cat_id': "10",
      'bus_id': "10",
    };
    var response = await http.post(Uri.parse(urls),
        headers: <String, String>{}, body: data);

    if (response.statusCode == 200) {
      var business_photo_response = response.body;
      print("userData" + business_photo_response);

      final Map<String, dynamic> responseData = json.decode(response.body);
      responseData['data'].forEach((turf_details) {
        final TurfResponseModel turfData = TurfResponseModel(
          turf_details['id'],
          turf_details['bus_id'],
          turf_details['service_title'],
          turf_details['service_price'],
          turf_details['promo_code'],
          turf_details['convenience_fee'],
          turf_details['service_discount'],
          turf_details['business_approxtime'],
          turf_details['categories'],
          turf_details['image'],
        );
        setState(() {
          turf_response.add(turfData);
        });
      });
    }
  }

  Future<void> getSlotTimings() async {
    var urls = Apis.get_time_slot;
    Map data = {
      'bus_id': "10",
      'user_type_id': "2",
      'turf_id': "20",
      'date': "2021-9-30",
      'category': "10",
      'type': "normal",
      'plan_id': "1",
      'cat_id': "10",
      'user_id': "95",
    };

    var response = await http.post(Uri.parse(urls),
        headers: <String, String>{}, body: data);

    if (response.statusCode == 200) {
      var userData = response.body;
      print("userData" + userData);

      final Map<String, dynamic> responseData = json.decode(response.body);
      responseData['data']['morning'].forEach((morningData) {
        final TimeSlotMorningData timeSlotMorningData = new TimeSlotMorningData(
          morningData['slot'],
          morningData['slot_label'],
          morningData['interval'],
          morningData['booking_id'],
          morningData['is_booked'],
          morningData['price'],
          morningData['time_token'],
          morningData['type'],
        );
        setState(() {
          timeslotmorningdata.add(timeSlotMorningData);
        });
      });
      responseData['data']['afternoon'].forEach((morningData) {
        final TimeSlotMorningData timeSlotMorningData = new TimeSlotMorningData(
          morningData['slot'],
          morningData['slot_label'],
          morningData['interval'],
          morningData['booking_id'],
          morningData['is_booked'],
          morningData['price'],
          morningData['time_token'],
          morningData['type'],
        );
        setState(() {
          timeslotmorningdata.add(timeSlotMorningData);
        });
      });
      responseData['data']['evening'].forEach((morningData) {
        final TimeSlotMorningData timeSlotMorningData = new TimeSlotMorningData(
          morningData['slot'],
          morningData['slot_label'],
          morningData['interval'],
          morningData['booking_id'],
          morningData['is_booked'],
          morningData['price'],
          morningData['time_token'],
          morningData['type'],
        );
        setState(() {
          timeslotmorningdata.add(timeSlotMorningData);
        });
      });
    }
  }

  void gotoContactPage() {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) => new ContactInfoScreenPage());
    Navigator.of(context).push(route);
  }
}