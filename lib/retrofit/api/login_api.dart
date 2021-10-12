import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:toptekker/retrofit/Apis.dart';
import 'package:toptekker/retrofit/model/login_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

@RestApi(baseUrl: Apis.apis)
abstract class LoginApiService {

  /*factory LoginApiService(Dio dio) = _LoginApiService;
  @POST(Apis.login+"={user_phone}/{user_password}")
  Future<LoginResponseModel> getUserDetails(int num);*/

  /*Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    final response =
        await http.post(Apis.login, body: loginRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }*/
}
