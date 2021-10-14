import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/data/academy_data.dart';
import 'package:toptekker/retrofit/model/ActiveModel/academy_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/active_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/venue_model.dart';
import 'package:http/http.dart' as http;
import 'package:toptekker/screens/academy_details_screen.dart';
import '../AppColors.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(AcademyScreen());
}

class AcademyScreen extends StatelessWidget {
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

class AcademyScreenPage extends StatefulWidget {
  const AcademyScreenPage({Key? key}) : super(key: key);

  @override
  AcademyScreenPageState createState() {
    return new AcademyScreenPageState();
  }
}

class AcademyScreenPageState extends State {
  TextEditingController searchController = TextEditingController();
  late CategoryModel categoryModel;
  static String latitude = "0.0";
  static String longitude = "0.0";
  String sortBy = 'By Distance';
  final List<AcademyData> academy_details = [];

  final businessModel = GetStorage();
  List storageList = [];

  @override
  void initState() {
    super.initState();

    categoryModel = ActiveModels.categoryModel!;
    print("category_model" + categoryModel.description);

    getLocation();
    Future.delayed(Duration(seconds: 2), () {
      getAcademyDetails();
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
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: searchController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Search',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    this.academy_details.length.toString() + ' venues',
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () => {},
                    padding: EdgeInsets.all(0),
                    child: Row(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            showSortingAlert(context);
                          },
                          icon: Icon(Icons.social_distance),
                        ),
                        Text(getValue())
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 0.1,
            thickness: 1.2,
            indent: 10,
            endIndent: 10,
          ),
          Container(
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: this.academy_details.length,
                  itemBuilder: _listViewItemBuilder,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  }))
        ],
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var newsDetail = this.academy_details[index];
    return Container(
        child: ListTile(
      contentPadding: EdgeInsets.all(13.0),
      leading: _itemThumbnail(newsDetail),
      title: _itemTitle(newsDetail),
      subtitle: _itemSubTitle(newsDetail),
      onTap: () {
        BusinessModel academyModel = new BusinessModel(
            newsDetail.bus_id,
            newsDetail.user_id,
            newsDetail.bus_title,
            newsDetail.razorpay_acc,
            newsDetail.bus_slug,
            newsDetail.bus_email,
            newsDetail.bus_description,
            newsDetail.bus_google_street,
            newsDetail.bus_latitude,
            newsDetail.bus_longitude,
            newsDetail.bus_contact,
            newsDetail.bus_logo,
            newsDetail.bus_status,
            newsDetail.start_time,
            newsDetail.end_time,
            newsDetail.city_id,
            newsDetail.country_id,
            newsDetail.locality_id,
            newsDetail.is_trusted,
            newsDetail.facilities,
            newsDetail.pay_advance,
            newsDetail.advance_amount,
            newsDetail.currency,
            newsDetail.user_fullname,
            newsDetail.avg_rating,
            newsDetail.total_rating,
            newsDetail.review_count,
            newsDetail.fcm_topic);
        print("list_tile" + academyModel.bus_title);

        ActiveModels.businessModel = academyModel;

        storageList.add(academyModel);
        businessModel.write('business_model', storageList);

        var route = new MaterialPageRoute(
            builder: (BuildContext context) => new AcademyDetailsScreenPage(
                  academyModel: academyModel,
                ));
        Navigator.of(context).push(route);
      },
    ));
  }

  Widget _itemThumbnail(AcademyData newsDetail) {
    return Container(
      child: newsDetail.bus_logo == null
          ? null
          : Image.network(
              Apis.base_url + "uploads/business/" + newsDetail.bus_logo,
              fit: BoxFit.fitHeight,
            ),
    );
  }

  Widget _itemTitle(AcademyData newsDetail) {
    return Text(
      newsDetail.bus_title,
    );
  }

  Widget _itemSubTitle(AcademyData newsDetail) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 6),
                child: Text(
                  newsDetail.bus_google_street,
                )),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  newsDetail.bus_latitude,
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        ),
        SizedBox(height: 4),
        Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Book',
              style: TextStyle(color: Colors.orangeAccent),
            )),
      ],
    );
  }

  void getAcademyDetails() async {
    var urls = Apis.get_business;
    Map data = {
      'cat_id': categoryModel.id,
      'search': "",
      'lat': latitude,
      'lon': longitude,
      'locality': "",
      'locality_id': "",
      'sort_by': sortBy,
      'rad': "",
      'offcet': "0",
      'number_row': "10",
      'type': ""
    };
    print("academy_data" + data.toString());
    var response = await http.post(Uri.parse(urls),
        headers: <String, String>{}, body: data);
    if (response.statusCode == 200) {
      var userData = response.body;
      print("userData" + userData);
      academy_details.clear();
      final Map<String, dynamic> responseData = json.decode(response.body);
      responseData['data'].forEach((academyDetail) {
        if (academyDetail != null) {
          final AcademyData news = AcademyData(
            academyDetail['bus_id'],
            academyDetail['user_id'],
            academyDetail['bus_title'],
            academyDetail['razorpay_acc'],
            academyDetail['bus_slug'],
            academyDetail['bus_email'],
            academyDetail['bus_description'],
            academyDetail['bus_google_street'],
            academyDetail['bus_latitude'],
            academyDetail['bus_longitude'],
            academyDetail['bus_contact'],
            academyDetail['bus_logo'],
            academyDetail['bus_status'],
            academyDetail['start_time'],
            academyDetail['end_time'],
            academyDetail['city_id'],
            academyDetail['country_id'],
            academyDetail['locality_id'],
            academyDetail['is_trusted'],
            academyDetail['facilities'],
            academyDetail['pay_advance'],
            academyDetail['advance_amount'],
            academyDetail['currency'],
            academyDetail['user_fullname'],
            academyDetail['avg_rating'],
            academyDetail['total_rating'],
            academyDetail['review_count'],
            academyDetail['fcm_topic'],
          );
          setState(() {
            academy_details.add(news);
          });
        } else {
          print("No data found");
        }
      });
    }
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
      if (currentLocation.latitude != 0.0 && currentLocation.longitude != 0.0) {
        latitude = currentLocation.latitude.toString();
        longitude = currentLocation.longitude.toString();
      }
    });
  }

  void showSortingAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          int selectedRadio = 0;
          return AlertDialog(content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(mainAxisSize: MainAxisSize.min, children: [
              RadioListTile(
                groupValue: sortBy,
                title: Text('By Distance'),
                value: 'By Distance',
                onChanged: (String? value) {
                  setState(() {
                    sortBy = value!;
                    print("selectedValue----> " + sortBy);
                  });
                },
              ),
              RadioListTile(
                groupValue: sortBy,
                title: Text('By Name'),
                value: 'By Name',
                onChanged: (String? value) {
                  setState(() {
                    sortBy = value!;
                    print("selectedValue----> " + sortBy);
                  });
                },
              ),
              new FlatButton(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: new Text('Ok'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  print("getValue" + getValue());
                  getAcademyDetails();
                },
              ),
            ]);
          }));
        });
  }

  String getValue() {
    return sortBy;
  }
}
