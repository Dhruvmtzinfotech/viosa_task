import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viosa_task/controller/splashcontroller.dart';
import 'package:viosa_task/routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashController splashCon = Get.put(SplashController());


  checkLogin() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("isLogin"))
    {
      // splashCon.isLoading = true;
      Get.offAllNamed(Routes.home);
    }
    else
    {
      // splashCon.isLoading = false;
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checkLogin();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: Get.height * 2,),
          Center(child: Lottie.asset("assets/animation/Lottie_Animation.json")),
        ],
      ),
    );
  }
}
