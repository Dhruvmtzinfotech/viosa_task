import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viosa_task/controller/logincontroller.dart';
import 'package:viosa_task/routes/app_routes.dart';
import 'package:viosa_task/widgets/button.dart';
import '../utils/apptheme.dart';
import 'home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginCon = Get.put(LoginController());
  final FirebaseAuth auth = FirebaseAuth.instance;   // Create the object login


  @override
  Widget build(BuildContext context) {
   double height = MediaQuery.of(context).size.height / 100;
   double width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(title: Text("LoginView"),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return Form(
                  key: loginCon.loginKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Login to your VIOSA Account",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Color(0xff7E57E2))),
                        SizedBox(height: height * 5),
                        TextFormField(
                          controller: loginCon.email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: AppTheme.customDecoration("Enter Email",Icons.email),
                        ),
                        SizedBox(height: height * 3),
                        TextFormField(
                          controller: loginCon.password,
                          obscureText: loginCon.passwordVisible.value,
                          decoration: AppTheme.customDecoration("Enter the password",Icons.lock
                          ).copyWith(
                            suffixIcon: InkWell(
                              onTap: () {
                                loginCon.passwordVisibility();
                              },
                              child: Icon(
                                loginCon.passwordVisible.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          //validator: loginCon.customPasswordValidation,
                        ),
                        SizedBox(height: height * 5),
                        Button(btnText: "Login", onClick: () async{
                          if (loginCon.email.text.isEmpty || loginCon.password.text.isEmpty)
                          {
                            AppTheme.getSnackBar(message: "Enter Email");
                            return;
                          }
                          else{
                            await loginCon.api.getUserLogin(
                                email:loginCon.email.text,
                                password: loginCon.password.text)!.then((value) async {
                              if(loginCon.isLogin.value == true)
                              {
                                loginCon.isLogin.value = true;
                                AppTheme.getSnackBar(message: value["message"]);

                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('isLogin','yes');
                              }
                              else
                              {
                                loginCon.isLogin.value = false;
                                AppTheme.getSnackBar(message: value["message"]);
                              }
                              loginCon.email.clear();
                              loginCon.password.clear();
                              Get.back();
                              Get.offAllNamed(Routes.home);
                            });
                          }
                        }),
                        SizedBox(height: height * 5),
                        GestureDetector(onTap: () async {
                          final GoogleSignIn googleSignIn = GoogleSignIn();
                          final GoogleSignInAccount? googleSignInAccount = await googleSignIn
                              .signIn();
                          if (googleSignInAccount != null) {
                            final GoogleSignInAuthentication googleSignInAuthentication =
                            await googleSignInAccount.authentication;
                            final AuthCredential authCredential = GoogleAuthProvider.credential(
                                idToken: googleSignInAuthentication.idToken,
                                accessToken: googleSignInAuthentication.accessToken);

                            UserCredential result = await auth.signInWithCredential(authCredential);
                            User user = result.user!;

                            var name = user.displayName.toString();
                            var email = user.email.toString();
                            var photo = user.photoURL.toString();
                            var googleId = user.uid.toString();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("name", name);
                            prefs.setString("isLogin", "yes");
                            prefs.setString("email", email);
                            prefs.setString("photo", photo);
                            prefs.setString("googleid", googleId);
                          }
                          Get.back();
                          Get.offAllNamed(Routes.home);
                        },
                          child: Container(
                            width:width * 82,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset("assets/img/Google.jpg"),
                                ),
                                Text("Continue with Google",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

              })
            ],
          ),
        ),
      ),
    );
  }
}
