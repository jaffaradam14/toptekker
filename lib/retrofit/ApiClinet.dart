import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'Apis.dart';

@RestApi(baseUrl: "http://www.toptekker.com/turfdemo/index.php/api")
abstract class ApiClient{
  /*factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Apis.login)
  Future<ResponseData> getLoginDetails();*/
}