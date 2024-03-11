import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viosa_task/api/api.dart';

class MyProfileController extends GetxController{
  Api api = Api();


  var name = "".obs;
  var email = "".obs;
  var photo = "".obs;
  var userPhone = "".obs;
  var role ="".obs;
  var googleId = "".obs;

  googleData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString("name") ?? "";
    email.value = prefs.getString("email") ?? "";
    userPhone.value = prefs.getString("phoneNumber") ?? "";
    role.value = prefs.getString("role") ?? "";
    photo.value = prefs.getString("photo") ?? "";
    googleId.value = prefs.getString("googleid") ?? "";
  }



  // var username = "".obs;
  // var userEmail = "".obs;
  // var userPhone = "".obs;
  // var role = "".obs;
  //
  // userData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   username.value = prefs.getString("name") ?? "";
  //   userEmail.value = prefs.getString("email") ?? "";
  //   userPhone.value = prefs.getString("phoneNumber") ?? "";
  //   role.value = prefs.getString("user") ?? "";
  // }


}