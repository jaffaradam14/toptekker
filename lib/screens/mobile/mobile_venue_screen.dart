import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/data/venue_data.dart';
import 'package:toptekker/retrofit/model/ActiveModel/active_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/venue_model.dart';
import 'package:toptekker/retrofit/services/web_service.dart';

import '../../AppColors.dart';
import '../academy_screen.dart';

class VenueScreen extends StatelessWidget {
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

class VenueScreenPage extends StatefulWidget {
  @override
  VenueScreenPageState createState() => VenueScreenPageState();
}

class VenueScreenPageState extends State {
  final List<VenueData> venue_items = [];
  List<VenueData> _newsArticles = [];
  List<VenueData> saveVenueData = [];

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.PRIMARY_COLOR,
          centerTitle: false,
          title: Text('TopTekker'),
        ),
        body: GridView.builder(
          itemCount: this._newsArticles.length,
          itemBuilder: _listViewItemBuilder,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 1.0, childAspectRatio: 3.0),
        ));
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var newsDetail = this._newsArticles[index];
    return InkWell(
        onTap: () {
          CategoryModel venue_data = new CategoryModel(
              newsDetail.id,
              newsDetail.title,
              newsDetail.slug,
              newsDetail.parent,
              newsDetail.leval,
              newsDetail.description,
              newsDetail.image,
              newsDetail.status,
              newsDetail.Count,
              newsDetail.PCount
          );
          print("list_tile" + venue_data.title);

          ActiveModels.categoryModel = venue_data;

          var route = new MaterialPageRoute(
              builder: (BuildContext context) =>
              new AcademyScreenSize());
          Navigator.of(context).push(route);
        },
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

  void getCategory() {
    Map data = {};
    Webservice().load(VenueData.all).then((newsArticles) => {
      setState(() => {_newsArticles = newsArticles})
    });
  }
}