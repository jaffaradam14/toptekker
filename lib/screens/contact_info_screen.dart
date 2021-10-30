import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toptekker/retrofit/data/time_slot_morning_data.dart';
import 'package:toptekker/retrofit/model/ActiveModel/active_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/slot_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/venue_model.dart';
import 'package:toptekker/screens/payment_details_screen.dart';

import '../AppColors.dart';
import '../Util.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(ContactInfoScreen());
}

class ContactInfoScreen extends StatelessWidget {
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

class ContactInfoScreenPage extends StatefulWidget {
  late String selectedDate;
  late String payFor;

  ContactInfoScreenPage(
      {Key? key, required this.selectedDate, required this.payFor})
      : super(key: key);

  @override
  ContactInfoScreenPageState createState() {
    return new ContactInfoScreenPageState(selectedDate, payFor);
  }
}

class ContactInfoScreenPageState extends State {
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

  ContactInfoScreenPageState(String selectedDate, String payFor) {
    this.selectedDate = selectedDate;
    this.payFor = payFor;
  }

  @override
  void initState() {
    super.initState();

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
      body: SingleChildScrollView(
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
        builder: (BuildContext context) => new PaymentDetailsScreenPage(
              username: username,
              phone: phone,
              selectedDate: selectedDate,
              payFor: payFor,
            ));
    Navigator.of(context).push(route);
  }
}
