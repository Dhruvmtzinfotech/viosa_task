import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viosa_task/api/api.dart';
import 'package:viosa_task/controller/homecontroller.dart';
import 'package:viosa_task/models/allcourses_model.dart';
import 'package:viosa_task/routes/app_routes.dart';
import 'package:viosa_task/views/my_profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeCon = Get.put(HomeController());
  CoursesModel courseList = CoursesModel();

  @override
  void initState() {
    super.initState();
    progres();
    homeCon.api.myGetProgress();

  }

  Future<void> progres() async {
    courseList = (await Api().getAllCourses()
    )!;

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 100;
    double width = MediaQuery.of(context).size.width * 100;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: const ListTile(
              leading: Icon(Icons.home),
              title: Text('Home',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ),
          ),
            GestureDetector(
              onTap: (){
                Get.to(()=>const MyProfile());
              },
              child: const ListTile(
                leading: Icon(Icons.person_outline),
                title: Text('My Profile',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();

                GoogleSignIn googleSignIn = GoogleSignIn();  // Google logout
                googleSignIn.signOut();

                Get.back();
                Get.offAllNamed(Routes.login);
              },
              child: Padding(
                padding:  const EdgeInsets.all(20.0),
                child: Container(
                  padding:  const EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xfff7d2fe)
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Logout",textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 20,
                        color: Colors.grey
                      ),),
                      Icon(Icons.arrow_forward,color: Colors.grey
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(title: const Text("HomeView"),),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text('Courses',style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 15),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Image.asset('assets/icons/courses.png'),
                                const SizedBox(width: 5),
                                const Text("32",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Progress',style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 15),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Image.asset('assets/icons/progress.png'),
                                const SizedBox(width: 5),
                                Text(Api().percentage.toString(),style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Obx(() => Column(
                          children: [
                            const Text('Watch Time',style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 15,),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Image.asset('assets/icons/time.png'),
                                const SizedBox(width: 5),
                                Text(Api().watchTime.value.toString(),style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),)
                      ],
                    ),
                  )
              ),
            ),
            if(courseList.courses != null)
            Expanded(child:
            ListView.builder(
                itemCount:courseList.courses!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        border: Border.all(
                          color: Colors.orange,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Image.network(courseList.courses![index].thumbnail.toString()),height: 100,width: 100,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(courseList.courses![index].name.toString(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(courseList.courses![index].description.toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
