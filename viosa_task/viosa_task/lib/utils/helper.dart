import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';

class Helper
{
  static SharedPreferences? preferences;

  static String spUserToken = "token";
  static String loginResponse = "LoginResponse";
  static String userDetailsModel = "UserDetailsModel";



  static Future<String?> getUserToken() async{    // get Bearer Token
    preferences = await SharedPreferences.getInstance();
    return preferences!.getString(spUserToken);
  }

  static Future<bool> saveLoginRes(Map<String, dynamic> response) async {     // save login response
    preferences = await SharedPreferences.getInstance();
    String res = jsonEncode(UserModel.fromJson(response));
    return await preferences!.setString(loginResponse, res);
  }


  static Future<bool> saveLoginUser(String name, String email, String phone, String role, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('name', name);
     prefs.setString('email', email);
     prefs.setString('phoneNumber', phone);
     prefs.setString('role', role);
     prefs.setString('token', token);
    return true;
  }



    // save user details
  // static Future<bool> saveUserDetails(Map<String, dynamic> response) async {
  //   preferences = await SharedPreferences.getInstance();  // instance of SharedPreferences
  //   String res = jsonEncode(UserDetailsModel.fromJson(response));  // Convert the 'response' Map to a JSON string using jsonEncode
  //   return await preferences!.setString(userDetailsModel, res);  // Save the JSON string in SharedPreferences under model 'userDetailsModel'
  // }



}
