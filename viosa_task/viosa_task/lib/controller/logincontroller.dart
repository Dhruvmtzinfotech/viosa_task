import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:viosa_task/api/api.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  RxBool passwordVisible = true.obs;

  void passwordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  RxBool isLogin = false.obs;
  String isSuccess = "";

  Api api = Api();

}