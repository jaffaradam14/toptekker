import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launch_review/launch_review.dart';
import 'package:toptekker/screens/change_password_screen.dart';
import 'package:toptekker/screens/edit_profile_screen.dart';
import 'package:toptekker/screens/login_screen.dart';
import 'package:toptekker/screens/refund_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../AppColors.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Tekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  File? imgFile;
  final imgPicker = ImagePicker();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: false,
        title: Text('TopTekker'),
      ),
      body: new Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Container(
                height: 150,
                width: double.infinity,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(5),
                  child: new Column(children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: imgFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  imgFile!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                    Container(
                      height: 6,
                    ),
                    Text(
                      'Jaffar',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
              ),
              Container(
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: new Column(
                      children: [
                        Container(height: 15.0),
                        new Container(
                          child: new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 15.0,
                                  ),
                                  new Icon(Icons.edit),
                                  Container(width: 10.0),
                                  new Text('Edit Profile'),
                                ],
                              )),
                        ),
                        Container(color: Colors.grey, height: 0.5),
                        new Container(
                          child: new GestureDetector(
                              onTap: () {
                                rateUS("com.app.toptekker");
                                /*LaunchReview.launch(androidAppId: "market://details?id=",
                                    iOSAppId: "");*/
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 15.0,
                                  ),
                                  new Icon(Icons.thumb_up),
                                  Container(width: 10.0),
                                  new Text('Rate Us'),
                                ],
                              )),
                        ),
                        Container(color: Colors.grey, height: 0.5),
                        new Container(
                          child: new GestureDetector(
                              onTap: () {
                                shareApp();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 15.0,
                                  ),
                                  new Icon(Icons.share),
                                  Container(width: 10.0),
                                  new Text('Share with Friends'),
                                ],
                              )),
                        ),
                        Container(color: Colors.grey, height: 0.5),
                        new Container(
                          child: new GestureDetector(
                              onTap: () {
                                var route = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    new ChangePasswordPage(from: "settings",mobile: "",));
                                Navigator.of(context).push(route);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 15.0,
                                  ),
                                  new Icon(Icons.lock),
                                  Container(width: 10.0),
                                  new Text('Change Password'),
                                ],
                              )),
                        ),
                        Container(color: Colors.grey, height: 0.5),
                        new Container(
                          child: new GestureDetector(
                              onTap: () {
                                print("click Google drive");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 15.0,
                                  ),
                                  new Icon(Icons.subscriptions),
                                  Container(width: 10.0),
                                  new Text('Subscriptions'),
                                ],
                              )),
                        ),
                      ],
                    )),
              ),
              Container(
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: new Column(
                      children: [
                        Container(height: 15.0),
                        new Container(
                          child: new GestureDetector(
                              onTap: () {
                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new RefundPolicyPage(value: "refund"),
                                );
                                Navigator.of(context).push(route);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 15.0,
                                  ),
                                  new Icon(Icons.policy),
                                  Container(width: 10.0),
                                  new Text('Refund Policy'),
                                ],
                              )),
                        ),
                        Container(color: Colors.grey, height: 0.5),
                        new Container(
                          child: new GestureDetector(
                              onTap: () {
                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  new RefundPolicyPage(value: "terms_condition"),
                                );
                                Navigator.of(context).push(route);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 15.0,
                                  ),
                                  new Icon(Icons.book),
                                  Container(width: 10.0),
                                  new Text('Terms & Condition'),
                                ],
                              )),
                        ),
                        Container(color: Colors.grey, height: 0.5),
                        new Container(
                          child: new GestureDetector(
                              onTap: () {
                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  new RefundPolicyPage(value: "privacy"),
                                );
                                Navigator.of(context).push(route);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 15.0,
                                  ),
                                  new Icon(Icons.privacy_tip),
                                  Container(width: 10.0),
                                  new Text('Privacy Policy'),
                                ],
                              )),
                        ),
                        Container(color: Colors.grey, height: 0.5),
                        new Container(
                          child: new GestureDetector(
                              onTap: () {
                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  new RefundPolicyPage(value: "contact_us"),
                                );
                                Navigator.of(context).push(route);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 15.0,
                                  ),
                                  new Icon(Icons.contact_page),
                                  Container(width: 10.0),
                                  new Text('Contact us'),
                                ],
                              )),
                        ),
                        Container(color: Colors.grey, height: 0.5),
                        new Container(
                          child: new GestureDetector(
                              onTap: () {
                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  new RefundPolicyPage(value: "about_us"),
                                );
                                Navigator.of(context).push(route);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 15.0,
                                  ),
                                  new Icon(Icons.business),
                                  Container(width: 10.0),
                                  new Text('About Us'),
                                ],
                              )),
                        ),
                      ],
                    )),
              ),
              Container(
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: new Column(
                      children: [
                        Container(height: 15.0),
                        new Container(
                          child: new GestureDetector(
                              onTap: () {
                                showLogoutAlert(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 15.0,
                                  ),
                                  new Icon(Icons.logout),
                                  Container(width: 10.0),
                                  new Text('Logout'),
                                ],
                              )),
                        ),
                      ],
                    )),
              ),
              Container(
                  child: Column(
                children: [
                  Container(height: 10.0),
                  new Text(
                    'V0.0.1',
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  Container(height: 10.0),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> shareApp() async {
    Share.share('check out my website https://example.com');
  }

  void rateUS(String appPackageName) {
    try {
      launch("market://details?id=" + appPackageName);
    } on PlatformException catch (e) {
      launch("https://play.google.com/store/apps/details?id=" + appPackageName);
    } finally {
      launch("https://play.google.com/store/apps/details?id=" + appPackageName);
    }
  }

  Future<void> _imgFromCamera() async {
    /*File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });*/
  }

  Future<void> _imgFromGallery() async {
    /*File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
    });*/
  }

  void showLogoutAlert(BuildContext context){
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
              children:[
                Image(
                    height: 30.0, image: new AssetImage("assets/icons/icon.png")),
                Text('  Logout ')
              ]
          ),
          content: Text("Do you want to close this application?"),
          actions: <Widget>[
            FlatButton(
              child: Text("No"),
              onPressed: () {
                //Put your code here which you want to execute on Yes button click.
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("Yes"),
              onPressed: () async {

                SharedPreferences preferences = await SharedPreferences.getInstance();
                await preferences.clear();

                Navigator.of(context).pop();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        );
      },
    );
  }

}
