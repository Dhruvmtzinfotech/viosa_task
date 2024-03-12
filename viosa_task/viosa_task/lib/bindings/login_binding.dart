import 'package:get/get.dart';
import 'package:viosa_task/controller/logincontroller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }

}