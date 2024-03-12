import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:viosa_task/bindings/home_bindings.dart';
import 'package:viosa_task/views/home_view.dart';
import 'package:viosa_task/views/splash_view.dart';
import '../bindings/login_binding.dart';
import '../bindings/splash_binding.dart';
import '../views/login_view.dart';

class Routes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String myCourse = '/myCourse';
  static const String myProfile = '/myProfile';


  static List<GetPage<dynamic>> get getPages {
    return [
      GetPage(
        name: Routes.splash,
        page: () => SplashView(),
        binding: SplashBinding(),
      ),
      GetPage(
        name: Routes.login,
        page: () =>  LoginView(),
        binding: LoginBinding(),
      ),
      GetPage(
          name: Routes.home,
          page: () => HomeView(),
        binding: HomeBinding(),
      ),
    ];
  }
}
