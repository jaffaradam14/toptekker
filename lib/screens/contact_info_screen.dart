import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toptekker/screens/payment_details_screen.dart';

import '../AppColors.dart';

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
  @override
  ContactInfoScreenPageState createState() {
    return new ContactInfoScreenPageState();
  }
}

class ContactInfoScreenPageState extends State {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final shared_data = GetStorage();
  var username;
  var phonenumber;

  @override
  void initState() {
    super.initState();

    username = shared_data.read("user_name");
    phonenumber = shared_data.read("user_phone");

    if(username != null){
      nameController.text = username;
    }

    if(phonenumber != null){
      phoneController.text = phonenumber;
    }

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
                    gotoPaymentDetailsPage();
                  },
                )
            )
          ],
        ),

      ),
    );
  }

  void gotoPaymentDetailsPage() {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) => new PaymentDetailsScreenPage());
    Navigator.of(context).push(route);
  }
}
