import 'package:get/get.dart';
import 'package:viosa_task/controller/splashcontroller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }

}