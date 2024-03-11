import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:viosa_task/controller/homecontroller.dart';
import 'package:viosa_task/controller/splashcontroller.dart';
import 'package:viosa_task/views/home_view.dart';
import 'package:viosa_task/views/splash_view.dart';
import '../controller/logincontroller.dart';
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
        name: Routes.splash,                                     // navigating within your
        page: () => SplashView(),
        binding: BindingsBuilder.put(() => SplashController()),  // create instance LoginController with the route.
        transition: Transition.cupertino,                        // transition animation to be used navigating this route
      ),
      GetPage(
        name: Routes.login,
        page: () =>  LoginView(),
        binding: BindingsBuilder.put(() => LoginController()),
        transition: Transition.cupertino,
      ),
      GetPage(
          name: Routes.home,
          page: () => HomeView(),
        binding: BindingsBuilder.put(() => HomeController()),
        transition: Transition.cupertino,
      ),
    ];
  }
}
