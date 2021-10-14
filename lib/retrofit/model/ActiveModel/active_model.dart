import 'package:flutter/cupertino.dart';
import 'package:toptekker/retrofit/model/ActiveModel/academy_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/service_model.dart';
import 'package:toptekker/retrofit/model/ActiveModel/venue_model.dart';

class ActiveModels{

  BuildContext context;

  ActiveModels(this.context);

  static BusinessModel? businessModel;
  static CategoryModel? categoryModel;
  static ServiceModel? serviceModel;
}