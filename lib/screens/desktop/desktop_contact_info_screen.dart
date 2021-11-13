import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toptekker/retrofit/model/ActiveModel/active_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/slot_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/venue_model.dart';

import '../../AppColors.dart';
import '../../Util.dart';
import '../payment_details_screen.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(DesktopContactInfoScreen());
}

class DesktopContactInfoScreen extends StatelessWidget {
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

class DesktopContactInfoScreenPage extends StatefulWidget {
  late String selectedDate;
  late String payFor;
  late double width;

  DesktopContactInfoScreenPage(
      {Key? key,
      required this.width,
      required this.selectedDate,
      required this.payFor})
      : super(key: key);

  @override
  DesktopContactInfoScreenPageState createState() {
    return new DesktopContactInfoScreenPageState(width, selectedDate, payFor);
  }
}

class DesktopContactInfoScreenPageState extends State {
  List<SlotModel> selectedTimeSlots = [];
  late CategoryModel categoryModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late Util util;
  final shared_data = GetStorage();
  var username;
  var phonenumber;

  var selectedDate;
  var payFor;
  var width;
  late double marginSpace;

  DesktopContactInfoScreenPageState(
      double width, String selectedDate, String payFor) {
    this.width = width;
    this.selectedDate = selectedDate;
    this.payFor = payFor;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      marginSpace = width / 3;
    });

    util = Util(context);

    username = shared_data.read("user_name");
    phonenumber = shared_data.read("user_phone");

    selectedTimeSlots = ActiveModels.slotModel!;
    categoryModel = ActiveModels.categoryModel!;

    if (username != null) {
      nameController.text = username;
    }

    if (phonenumber != null) {
      phoneController.text = phonenumber;
    }

    print("selectedTimeSlot-----> " + selectedTimeSlots[0].slot_label);
    print("categoryModel----> " + categoryModel.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: false,
        title: Text('Contact Information'),
      ),
      body:Container(
          margin: EdgeInsets.fromLTRB(marginSpace, 0, marginSpace, 0),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  padding: EdgeInsets.all(6),
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Full name',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  padding: EdgeInsets.all(6),
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Phone',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    padding: EdgeInsets.all(6),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Color(0XFF2E7D32),
                      child: Text('Proceed'),
                      onPressed: () {
                        validateContactPage();
                      },
                    ))
              ],
            ),
          )
      ),
    );
  }

  void validateContactPage() {
    String username = nameController.text.toString();
    String phone = phoneController.text.toString();
    bool cancel = true;

    if (username.isEmpty) {
      util.showFlutterToast("Please enter username");
      cancel = false;
    } else if (phone.isEmpty) {
      util.showFlutterToast("Please enter mobile number");
      cancel = false;
    } else if (phone.length < 10) {
      util.showFlutterToast("Please enter valid mobile number");
      cancel = false;
    }

    if (cancel) {
      gotoPaymentDetailsPage(username, phone);
    }
  }

  void gotoPaymentDetailsPage(String username, String phone) {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) => new PaymentDetailsScreenSize(
              username: username,
              phone: phone,
              selectedDate: selectedDate,
              payFor: payFor,
            ));
    Navigator.of(context).push(route);
  }
}
