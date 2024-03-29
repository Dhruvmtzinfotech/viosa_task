import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viosa_task/api/widget.dart';
import 'package:viosa_task/controller/homecontroller.dart';
import '../models/allcourses_model.dart';
import '../models/myprogrese_model.dart';
import '../utils/constants.dart';
import '../utils/helper.dart';

class Api {

  Dio dio = Dio(BaseOptions(
    baseUrl: Constants.baseUrl,
    contentType: "application/json",
  ));

  Future? header() async {
    String? token;
    await Helper.getUserToken().then((value) {
      token = value;
    });
    if (kDebugMode) {
      print(token);
    }
    return dio.options.headers["Authorization"] = "Bearer $token";
  }

  HomeController homeCon = Get.put(HomeController());


  Future? getUserLogin({String? email, String? password}) async {
    Map<String, dynamic> map = {"email": email, "password": password};
    String body = jsonEncode(map);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiVVNFUiIsImlkIjoiNjVlODMxYjRkYmIxNWViMjUwZGUyNTVhIiwiaWF0IjoxNzA5NzE1ODkyLCJleHAiOjE3MTIzMDc4OTJ9.GbbkjMwVlrmeGJ_EwlaV7HkQzMKjIACgDU5gJj-9Lh4'
      };
      var response = await dio.post("login", data: body,options: Options(headers: headers));
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['user'] != null) {

          var name = response.data['user']['name'];
          var role = response.data['user']['role'];
          var mobile = response.data['user']['phoneNumber'];
          var token = response.data['token'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("isLogin", "yes");
          prefs.setString('name', name);
          prefs.setString('email', email!);
          prefs.setString('phoneNumber',mobile);
          prefs.setString('role', role);
          prefs.setString('token', token);
        }
        return response.data;
      }
    } on DioException catch (ex) {
      return apiDialog(
          ex.response!.data["message"] ?? "please try again later");
    }
  }


  // RxBool isLoading = false.obs;
  Future<CoursesModel?> getAllCourses() async {
    try {
      // isLoading.value = true;
      var header = {
             'Content-type': 'application/json',
             "Accept": "application/json"
           };
      var response = await dio.get('https://api.viosa.in/admin/course',options: Options(headers: header));
      // isLoading.value = false;
      return CoursesModel.fromJson(response.data);
    } on DioException catch (ex) {
      if (ex.message.toString() == "Internet Connection Failure") {}
    }
    return null;
  }




  Future myGetProgress() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token') ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiVVNFUiIsImlkIjoiNjUyMzk2Mzk2MDVkOTQzMDNhYWEwNTAyIiwiaWF0IjoxNzA3ODg4ODc2LCJleHAiOjE3MTA0ODA4NzZ9.uOiTn8sjxny-DiRoFZjomm3uTjXkokmWiUIcPGDx2Ks";
    var userId = sharedPreferences.getString('userId') ?? "6343bf2ae33839d145810ec6";

    try {
      var response = await dio.post("https://api.viosa.in/user/progress/all",options: Options(
          headers: {
            'token': token,
            'Content-Type': 'application/json',
          },
        ),
        data: jsonEncode({'userId': userId}),
      );
      homeCon.progress = jsonDecode(response.toString());
      double completeChapter = (homeCon.progress.containsKey("result"))
          ? 0
          : double.parse(homeCon.progress["result"]["completedChapters"].toString());
      double totalChp = (homeCon.progress.containsKey("result"))
          ? 0
          : double.parse( homeCon.progress["result"]["totalChapters"].toString());

      if (totalChp == 0.00) {
        homeCon.percentage.value = 0.00;
      } else {
        homeCon.percentage.value = (completeChapter / totalChp) * 100;
      }
      homeCon.watchTime.value = intWatchTime( homeCon.progress["result"]["totalWatchedTime"]);
      homeCon.track.add(
        ProgressModel(
          title: "My Progress",
          value: "${ homeCon.percentage.toStringAsFixed(2)}%",
        ),
      );
      homeCon.track.add(
        ProgressModel(
          title: "My Watch Time",
          value:  homeCon.watchTime.value,
        ),
      );
      return  homeCon.progress;
    } on DioException catch (error) {
      print("Error in API call: $error");
      return null;
    }
  }

  String intWatchTime(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String hourLeft =
    h.toString().length < 2 ? "0$h" : h.toString();

    String minuteLeft =
    m.toString().length < 2 ? "0$m" : m.toString();

    String secondsLeft =
    s.toString().length < 2 ? "0$s" : s.toString();

    String result = "$hourLeft:$minuteLeft:$secondsLeft";

    return result;
  }

}
