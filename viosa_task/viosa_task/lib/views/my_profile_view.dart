import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viosa_task/controller/myprofilecontroller.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  MyProfileController profileCon = Get.put(MyProfileController());


  @override
  void initState() {
    super.initState();
    profileCon.googleData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Get.back();
                      }, icon: Icon(Icons.arrow_back)),
                      Text("My Profile",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                  SizedBox(height: height * 5),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage(profileCon.photo.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 5,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Basic Details",style: TextStyle(
                              fontSize: 20
                          ),),
                          SizedBox(height: height * 3),
                          Text(profileCon.role.value,style: Theme.of(context).textTheme.displaySmall),
                          Text(profileCon.name.value,style:Theme.of(context).textTheme.displaySmall),
                          Text(profileCon.email.value,style:Theme.of(context).textTheme.displaySmall),
                          // Text(profileCon.userPhone.value,style:Theme.of(context).textTheme.displaySmall),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          })
        ),
      ),
    );
  }
}
