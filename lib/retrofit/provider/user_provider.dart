
import 'package:flutter/cupertino.dart';
import 'package:toptekker/retrofit/data/login_data_model.dart';

class UserProvider extends ChangeNotifier{
  LoginData loginData = LoginData("","","","","","");

  LoginData get getUserDetails => loginData;

  void setUser (LoginData loginData){
    loginData = loginData;
    notifyListeners();
  }

}