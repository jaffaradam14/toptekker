import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/model/ActiveModel/academy_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/active_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/service_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/slot_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/venue_model.dart';

import '../../AppColors.dart';
import '../order_screen.dart';
import '../razorpay_screen.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(DesktopPaymentDetailsScreen());
}

class DesktopPaymentDetailsScreen extends StatelessWidget {
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

class DesktopPaymentDetailsScreenPage extends StatefulWidget {
  double width;
  late String username;
  late String phone;
  late String selectedDate;
  late String payFor;

  DesktopPaymentDetailsScreenPage(
      {Key? key,
      required this.width,
      required this.username,
      required this.phone,
      required this.selectedDate,
      required this.payFor})
      : super(key: key);

  @override
  DesktopPaymentDetailsPageState createState() {
    return new DesktopPaymentDetailsPageState(
        width, username, phone, selectedDate, payFor);
  }
}

class DesktopPaymentDetailsPageState extends State {
  late String username;
  late double width;
  late String phone;
  late String selectedDate;
  late String payFor;
  String slot_labels = "";
  late CategoryModel categoryModel;
  late ServiceModel serviceModel;
  late List<SlotModel> selectedTimeSlots;
  late BusinessModel businessModel;
  double turf_fee = 0.0;
  double totalamount = 0.0;
  double turf_advance_amount = 0.0;
  double convenience_fee = 0.0;
  double total_advance_to_pay_now = 0.0;
  double balanceamount = 0.0;
  final shared_data = GetStorage();
  var userId;
  var planId;
  late double marginSpace;

  DesktopPaymentDetailsPageState(double width, String username, String phone,
      String selectedDate, String payFor) {
    this.width = width;
    this.username = username;
    this.phone = phone;
    this.selectedDate = selectedDate;
    this.payFor = payFor;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      marginSpace = width / 3;
    });

    userId = shared_data.read("user_type_id");

    categoryModel = ActiveModels.categoryModel!;
    serviceModel = ActiveModels.serviceModel!;
    selectedTimeSlots = ActiveModels.slotModel!;
    businessModel = ActiveModels.businessModel!;

    for (int i = 0; i < selectedTimeSlots.length; i++) {
      SlotModel slotsModel = selectedTimeSlots[i];
      slot_labels = slot_labels + ", " + slotsModel.slot_label;
      double slotPrice = double.parse(slotsModel.price);
      turf_fee = turf_fee + slotPrice;
      planId = slotsModel.plan_id;
    }
    print("slotlabels---> " + slot_labels.substring(1));

    totalamount = turf_fee - double.parse(serviceModel.service_discount);
    print("totalamount----> " + totalamount.toString());

    setAdvancePay(serviceModel.advance, serviceModel.advance_type);
    setConvenienceFee(
        serviceModel.convenience_fee, serviceModel.convenience_fee_type);

    total_advance_to_pay_now = convenience_fee + turf_advance_amount;
    balanceamount = totalamount - turf_advance_amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: false,
        title: Text('Payment Details'),
      ),
      body: Container(
          margin: EdgeInsets.fromLTRB(marginSpace, 0, marginSpace, 0),
          child: Stack(
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
                                child: Image.network(
                                  Apis.base_url +
                                      "/uploads/admin/category/" +
                                      categoryModel.image,
                                  height: 30.0,
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                      left: 6.0, right: 0.0),
                                  child: Text(
                                    categoryModel.title,
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
                                serviceModel.service_title,
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
                                selectedDate,
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
                              Expanded(
                                  child: Text(
                                slot_labels.substring(1),
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
                              child: Text(
                                turf_fee.toString() + " INR",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: 8.0, top: 6.0, right: 0.0),
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
                              margin: EdgeInsets.only(
                                  left: 0, top: 6.0, right: 0.0),
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
                              child: Text(totalamount.toString() + " INR",
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
                              margin:
                                  EdgeInsets.only(left: 0, top: 6.0, right: 0),
                              child: Text('Advance to pay')),
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 0, top: 6.0, right: 0),
                              child:
                                  Text(turf_advance_amount.toString() + " INR"))
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
                                  EdgeInsets.only(left: 0, top: 6.0, right: 0),
                              child: Text('Convenience Fee')),
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 0, top: 6.0, right: 0),
                              child: Text(
                                convenience_fee.toString() + " INR",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 6, top: 6, right: 6, bottom: 6),
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
                                    total_advance_to_pay_now.toString() +
                                        " INR",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 6, top: 6, right: 6, bottom: 6),
                                  child: Text(
                                    balanceamount.toString() + " INR",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
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
                        margin: EdgeInsets.only(
                            left: 6, top: 6, right: 6, bottom: 6),
                        child: Text(
                          'Cancellation Policy',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                            left: 6, top: 6, right: 6, bottom: 6),
                        child: Text(
                          'Cannot cancel before 36 hours',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        )),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                            left: 6, top: 12, right: 6, bottom: 6),
                        child: Text(
                          'Terms of service',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                            left: 6, top: 6, right: 6, bottom: 6),
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
          )),
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
    if (total_advance_to_pay_now == 0 || userId == "3") {
      turf_advance_amount = 0;
      convenience_fee = 0;

      var route = new MaterialPageRoute(
          builder: (BuildContext context) => new OrderScreenSize(
                payment_by: "cash",
                transaction_id: "",
                date: selectedDate,
                timeslot: slot_labels,
                mem_slots: "",
                interval: "",
                fullname: username,
                email: "",
                phone: phone,
                turf_fee: turf_fee.toString(),
                advance: turf_advance_amount.toString(),
                convenience_fee: convenience_fee.toString(),
                promo_code: "",
                promo_discount: "",
                type: "",
                pay_for: payFor,
                plan_id: planId,
              ));
      Navigator.of(context).push(route);
    } else {
      var route = new MaterialPageRoute(
          builder: (BuildContext context) => new RazorpayScreenSize(
                date: selectedDate,
                timeslot: slot_labels,
                mem_slots: "",
                interval: "",
                fullname: username,
                email: "",
                phone: phone,
                turf_fee: turf_fee.toString(),
                advance: turf_advance_amount.toString(),
                convenience_fee: convenience_fee.toString(),
                promo_code: "",
                promo_discount: "",
                type: "",
                pay_for: payFor,
                plan_id: planId,
              ));
      Navigator.of(context).push(route);
    }
  }

  void setAdvancePay(String advance, String type) {
    print("advance&type" + advance + "---->" + type);
    if (type != "" && type == "percentage") {
      //turf_advance_amount = Math.round((advance/100) * totalamount);
      turf_advance_amount = ((double.parse(advance) / 100) * totalamount);
    } else {
      turf_advance_amount = double.parse(advance);
    }
    print("turf_advance_amount----> " + turf_advance_amount.toString());
  }

  void setConvenienceFee(String conv_fee, String type) {
    if (conv_fee == null) {
      conv_fee = "0.0";
    }
    if (type != "" && type == "percentage") {
      convenience_fee = ((double.parse(conv_fee) / 100) * turf_advance_amount);
    } else {
      convenience_fee = double.parse(conv_fee);
    }
    convenience_fee =
        convenience_fee + double.parse(businessModel.booking_charge);
    print("convenience_fee----> " + convenience_fee.toString());
  }
}
