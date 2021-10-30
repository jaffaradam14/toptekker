import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/data/academy_data.dart';
import 'package:toptekker/retrofit/data/business_photos_response_model_data.dart';
import 'package:toptekker/retrofit/data/get_sports_response_data_model.dart';
import 'package:toptekker/retrofit/data/login_data_model.dart';
import 'package:toptekker/retrofit/data/special_timings_data.dart';
import 'package:toptekker/retrofit/model/ActiveModel/academy_model.dart';
import 'package:http/http.dart' as http;
import 'package:toptekker/retrofit/model/ActiveModel/active_model.dart';
import 'package:toptekker/screens/time_slot_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../AppColors.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(AcademyDetailsScreen());
}

class AcademyDetailsScreen extends StatelessWidget {
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

class AcademyDetailsScreenPage extends StatefulWidget {
  final BusinessModel academyModel;

  AcademyDetailsScreenPage({Key? key, required this.academyModel})
      : super(key: key);

  @override
  AcademyDetailsScreenPageState createState() {
    return new AcademyDetailsScreenPageState();
  }
}

class AcademyDetailsScreenPageState extends State {
  late final BusinessModel academyModel;
  final List<BusinessPhotosData> photo_details = [];
  final List<GetSportsResponseModel> get_sports_details_model = [];
  final List<SpecialTimingsData> special_timings_data = [];
  final shared_data = GetStorage();
  List storageList = [];
  List<AcademyData> academy_details = [];

  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    academyModel = ActiveModels.businessModel!;
    print("academyModel---->" + academyModel.bus_google_street);

    loadPhotos();
    getSports();

    _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(double.parse(academyModel.bus_latitude),
            double.parse(academyModel.bus_longitude)),
        infoWindow: InfoWindow(title: 'The title of the marker')));

    print("storage_list" + storageList.length.toString());
  }

  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: false,
        title: Text('TopTekker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: PageView.builder(
                  itemCount: this.photo_details.length,
                  itemBuilder: (context, index) {
                    var newsDetail = this.photo_details[index];
                    return Container(
                      child: newsDetail.photo_image == null
                          ? null
                          : Image.network(
                        Apis.base_url +
                            "/uploads/business/businessphoto/" +
                            newsDetail.photo_image,
                          fit:BoxFit.fill
                      ),
                    );
                  }),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0XFF2E7D32),
                child: Text('View Membership Plan'),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Card(
                  child: Row(
                    children: [
                      new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Text(
                          'TIME        ' +
                              academyModel.start_time +
                              " to " +
                              academyModel.end_time,
                          style: new TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                height: 50,
                child: Column(
                  children: [
                    Container(
                      child: new Text(
                        'SPORTS ',
                        textAlign: TextAlign.left,
                        style: new TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Expanded(
                            child: ListView.builder(
                      padding: EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: this.get_sports_details_model.length,
                      itemBuilder: _listViewImageItemBuilder,
                    ))),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Phone",
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: AppColors.PRIMARY_COLOR,
                              fontFamily: 'georgia'),
                        ),
                        subtitle: Text(
                          academyModel.bus_contact,
                          style: new TextStyle(
                              fontSize: 15.0, color: Colors.black),
                        ),
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            new IconButton(
                              onPressed: () {
                                makingPhoneCall(academyModel.bus_contact);
                              },
                              icon: Icon(
                                Icons.add_ic_call_rounded,
                                color: AppColors.PRIMARY_COLOR,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Email",
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: AppColors.PRIMARY_COLOR,
                              fontFamily: 'georgia'),
                        ),
                        subtitle: Text(
                          academyModel.bus_email,
                          style: new TextStyle(
                              fontSize: 15.0, color: Colors.black),
                        ),
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            Icon(
                              Icons.email,
                              color: AppColors.PRIMARY_COLOR,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Facilities",
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: AppColors.PRIMARY_COLOR,
                              fontFamily: 'georgia'),
                        ),
                        subtitle: Text(
                          academyModel.facilities,
                          style: new TextStyle(
                              fontSize: 15.0, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                )),
            Container(
                height: 300,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SingleChildScrollView(
                    child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Location",
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: AppColors.PRIMARY_COLOR,
                              fontFamily: 'georgia'),
                        ),
                        subtitle: Text(
                          academyModel.bus_google_street,
                          style: new TextStyle(
                              fontSize: 15.0, color: Colors.black),
                        ),
                      ),
                      Container(
                          height: 200,
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  double.parse(academyModel.bus_latitude),
                                  double.parse(academyModel.bus_longitude)),
                              zoom: 10,
                            ),
                            markers: _markers,
                          ))
                    ],
                  ),
                ))),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Additional Info",
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: AppColors.PRIMARY_COLOR,
                              fontFamily: 'georgia'),
                        ),
                        subtitle: Text(
                          academyModel.bus_description,
                          style: new TextStyle(
                              fontSize: 15.0, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.PRIMARY_COLOR,
        onPressed: () => {getBookingAlert()},
        child: const Text('Book'),
      ),
    );
  }

  Widget _listViewImageItemBuilder(BuildContext context, int index) {
    var newsDetail = this.get_sports_details_model[index];
    return InkWell(
        child: Container(
            child: Container(
      child: Expanded(
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
          ],
        ),
      ),
    )));
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var newsDetail = this.photo_details[index];
    return Container(
      child: newsDetail.photo_image == null
          ? null
          : Image.network(
              Apis.base_url +
                  "/uploads/business/businessphoto/" +
                  newsDetail.photo_image,
            ),
    );
  }

  Widget _itemThumbnail(BusinessPhotosData newsDetail) {
    return Container(
      child: newsDetail.photo_image == null
          ? null
          : Image.network(
              Apis.base_url + "/uploads/business/" + newsDetail.photo_image,
              height: 200,
            ),
    );
  }

  Future<void> loadPhotos() async {
    var urls = Apis.get_photos;
    Map data = {
      'bus_id': academyModel.bus_id,
    };
    var response = await http.post(Uri.parse(urls),
        headers: <String, String>{}, body: data);

    if (response.statusCode == 200) {
      var business_photo_response = response.body;
      print("userData" + business_photo_response);

      final Map<String, dynamic> responseData = json.decode(response.body);
      responseData['data'].forEach((photos_details) {
        final BusinessPhotosData businessData = BusinessPhotosData(
          photos_details['id'],
          photos_details['bus_id'],
          photos_details['photo_title'],
          photos_details['photo_image'],
        );
        setState(() {
          photo_details.add(businessData);
        });
      });
    }
  }

  Future<void> getSports() async {
    var urls = Apis.get_sports;
    Map data = {
      'bus_id': academyModel.bus_id,
    };
    var response = await http.post(Uri.parse(urls),
        headers: <String, String>{}, body: data);
    if (response.statusCode == 200) {
      var get_sports_response = response.body;
      print("get_sports_response" + get_sports_response);

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['data'] != null) {
        responseData['data'].forEach((get_sports_details) {
          final GetSportsResponseModel getSportsResponseModel =
              new GetSportsResponseModel(
                  get_sports_details['id'],
                  get_sports_details['bus_id'],
                  get_sports_details['category_id'],
                  get_sports_details['title'],
                  get_sports_details['slug'],
                  get_sports_details['parent'],
                  get_sports_details['leval'],
                  get_sports_details['description'],
                  get_sports_details['image'],
                  get_sports_details['status']);
          setState(() {
            get_sports_details_model.add(getSportsResponseModel);
          });
        });
      }
    }
  }

  makingPhoneCall(String contact) async {
    String call_number = 'tel:' + contact;
    var url = call_number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> getBookingAlert() async {
    var urls = Apis.get_user_subscriptions_and_special_timings;
    Map data = {
      'user_id': shared_data.read("user_id"),
      'bus_id': academyModel.bus_id,
      'user_type': "user",
      'category': "10",
    };
    var response = await http.post(Uri.parse(urls),
        headers: <String, String>{}, body: data);

    if (response.statusCode == 200) {
      special_timings_data.clear();
      final Map<String, dynamic> responseData = json.decode(response.body);
      responseData['data'].forEach((bookingData) {
        if (bookingData == null) {
          print("no data found");
        }
      });
      responseData['special_timings'].forEach((special_timings) {
        if (special_timings != null) {
          final SpecialTimingsData specialTimingsData = SpecialTimingsData(
              special_timings['id'],
              special_timings['bus_id'],
              special_timings['title'],
              special_timings['categories'],
              special_timings['categories_title'],
              special_timings['working_days'],
              special_timings['morning_enabled'],
              special_timings['afternoon_enabled'],
              special_timings['evening_enabled'],
              special_timings['morning_time_start'],
              special_timings['morning_time_end'],
              special_timings['afternoon_time_start'],
              special_timings['afternoon_time_end'],
              special_timings['evening_time_start'],
              special_timings['evening_time_end'],
              special_timings['morning_price'],
              special_timings['afternoon_price'],
              special_timings['evening_price'],
              special_timings['created_at']);
          setState(() {
            special_timings_data.add(specialTimingsData);
          });

          showTimingsAlert(special_timings_data, context);
        }
      });
    }
  }

  void showTimingsAlert(
      List<SpecialTimingsData> special_timings_data, BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Special Timings',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Container(
              height: 420,
              child: Column(children: [
                Container(
                  height: 300.0, // Change as per your requirement
                  width: 300.0, // Change as per your requirement
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: this.special_timings_data.length,
                    itemBuilder: _listViewSpecialItemBuilder,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      'OR',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: FlatButton(
                    textColor: Colors.white,
                    color: AppColors.PRIMARY_COLOR,
                    child: Text('Continue to normal booking'),
                    onPressed: () {
                      Navigator.pop(context);
                      gotoTimeSlotPage();
                    },
                  ),
                )
              ])), //setupAlertDialoadContainer(special_timings_data),
        );
      },
    );
  }

  setupAlertDialoadContainer(List<SpecialTimingsData> special_timings_data) {
    return Column(children: [
      Container(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: this.special_timings_data.length,
          itemBuilder: _listViewSpecialItemBuilder,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10,
            );
          },
        ),
      ),
      Container(
          alignment: Alignment.center,
          child: Text(
            'OR',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          )),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 50,
        width: double.infinity,
        child: RaisedButton(
          textColor: Colors.white,
          color: AppColors.PRIMARY_COLOR,
          child: Text('Continue to normal booking'),
          onPressed: () {
            Navigator.of(context).pop();
            gotoTimeSlotPage();
          },
        ),
      )
    ]);
  }

  Widget _listViewSpecialItemBuilder(BuildContext context, int index) {
    var newsDetail = this.special_timings_data[index];
    return ClipRect(
        child: ListTile(
      tileColor: AppColors.PRIMARY_COLOR,
      dense: true,
      title: _itemTitle(newsDetail),
      subtitle: _itemSubTitle(newsDetail),
    ));
  }

  Widget _itemTitle(SpecialTimingsData newsDetail) {
    return Text(
      newsDetail.title,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _itemSubTitle(SpecialTimingsData newsDetail) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
            alignment: Alignment.topLeft,
            child: Text(
              newsDetail.categories_title,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            )),
        SizedBox(
          height: 4,
        ),
        Container(
            alignment: Alignment.topLeft,
            child: Text(
              newsDetail.morning_time_start,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            )),
        SizedBox(
          height: 4,
        ),
        Container(
            alignment: Alignment.topLeft,
            child: Text(
              newsDetail.working_days,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ))
      ],
    );
  }

  void gotoTimeSlotPage() {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) => new TimeSlotScreenPage());
    Navigator.of(context).push(route);
  }
}
