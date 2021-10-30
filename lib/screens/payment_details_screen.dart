import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:toptekker/screens/razorpay_screen.dart';

import '../AppColors.dart';

class PaymentDetailsScreen extends StatelessWidget {
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

class PaymentDetailsScreenPage extends StatefulWidget {
  late String username;
  late String phone;
  late String selectedDate;
  late String payFor;

  PaymentDetailsScreenPage(
      {Key? key,
      required this.username,
      required this.phone,
      required this.selectedDate,
      required this.payFor})
      : super(key: key);

  @override
  PaymentDetailsPageState createState() {
    return new PaymentDetailsPageState(username,phone,selectedDate,payFor);
  }
}

class PaymentDetailsPageState extends State {

  late String username;
  late String phone;
  late String selectedDate;
  late String payFor;

  PaymentDetailsPageState(String username, String phone, String selectedDate, String payFor){
    this.username = username;
    this.phone = phone;
    this.selectedDate = selectedDate;
    this.payFor = payFor;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: false,
        title: Text('Payment Details'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(6),
                  child: Card(
                    child: Column(
                      children: [
                        Row(children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 8.0, top: 6.0, right: 0.0),
                            child: Image(
                                height: 35.0,
                                image: new AssetImage("assets/icons/icon.png")),
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 6.0, right: 0.0),
                              child: Text(
                                'Cricket',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                        ]),
                        Row(children: [
                          Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.golf_course_rounded,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Container(
                              child: Text(
                            'Cricket new',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ))
                        ]),
                        Row(children: [
                          Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Container(
                              child: Text(
                            'Thu, 30 September 2021',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ))
                        ]),
                        Row(children: [
                          Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.timer,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Container(
                              child: Text(
                            '06:00 PM - 06:30 PM',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ))
                        ]),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              left: 8.0, top: 6.0, right: 0.0),
                          child: Text('Turf fee')),
                      Container(
                          margin: const EdgeInsets.only(
                              left: 8.0, top: 6.0, right: 8.0),
                          child: Text('1000.0 INR'))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin:
                              EdgeInsets.only(left: 8.0, top: 6.0, right: 0.0),
                          child: Text('Discount')),
                      Container(
                          margin: const EdgeInsets.only(
                              left: 8.0, top: 6.0, right: 8.0),
                          child: Text('0.0 INR'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6, right: 6),
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.timer,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 16, right: 6),
                            child: Text(
                              'APPLY PROMO CODE',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin:
                              EdgeInsets.only(left: 0, top: 6.0, right: 0.0),
                          child: Text(
                            'Total Amount',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: AppColors.PRIMARY_COLOR,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: const EdgeInsets.only(
                              left: 0, top: 6.0, right: 0),
                          child: Text('1000.0 INR',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: AppColors.PRIMARY_COLOR,
                                  fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 0, top: 6.0, right: 0),
                          child: Text('Advance to pay')),
                      Container(
                          margin: const EdgeInsets.only(
                              left: 0, top: 6.0, right: 0),
                          child: Text('0.0 INR'))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 0, top: 6.0, right: 0),
                          child: Text('Convenience Fee')),
                      Container(
                          margin: const EdgeInsets.only(
                              left: 0, top: 6.0, right: 0),
                          child: Text('0.0 INR'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6, top: 6, right: 6, bottom: 6),
                  child: Card(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: 6, top: 6, right: 6, bottom: 6),
                              child: Text(
                                '0.00 INR',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.only(
                                  left: 6, top: 6, right: 6, bottom: 6),
                              child: Text(
                                '1000.0 INR',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: 6, top: 0, right: 6, bottom: 6),
                              child: Text(
                                'Advance to pay now',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.PRIMARY_COLOR),
                              )),
                          Container(
                              margin: EdgeInsets.only(
                                  left: 6, top: 0, right: 6, bottom: 6),
                              child: Text(
                                'Amount payable at court',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.PRIMARY_COLOR),
                              ))
                        ],
                      ),
                    ],
                  )),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    margin:
                        EdgeInsets.only(left: 6, top: 6, right: 6, bottom: 6),
                    child: Text(
                      'Cancellation Policy',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                    alignment: Alignment.topLeft,
                    margin:
                        EdgeInsets.only(left: 6, top: 6, right: 6, bottom: 6),
                    child: Text(
                      'Cannot cancel before 36 hours',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    )),
                Container(
                    alignment: Alignment.topLeft,
                    margin:
                        EdgeInsets.only(left: 6, top: 12, right: 6, bottom: 6),
                    child: Text(
                      'Terms of service',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                    alignment: Alignment.topLeft,
                    margin:
                        EdgeInsets.only(left: 6, top: 6, right: 6, bottom: 6),
                    child: Text(
                      'By continuing, you agree to our terms of service',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    )),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: new BottomAppBar(
        child: InkWell(
          onTap: () {
            showConfirmationAlert(context);
          },
          child: Container(
            height: 50,
            decoration: new BoxDecoration(
                gradient: new LinearGradient(colors: [
              AppColors.PRIMARY_COLOR,
              AppColors.PRIMARY_COLOR,
            ])),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      "Confirm and Book",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showConfirmationAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text("Do Want To Proceed ?"),
          actions: <Widget>[
            FlatButton(
              child: Text("No"),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                //Put your code here which you want to execute on Yes button click.
                Navigator.of(context).pop();
                gotoRazorpayPage();
              },
            ),
          ],
        );
      },
    );
  }

  void gotoRazorpayPage() {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) => new RazorpayScreenPage());
    Navigator.of(context).push(route);
  }
}
