import 'package:get/get.dart';
import 'package:viosa_task/models/allcourses_model.dart';
import '../models/myprogrese_model.dart';

class HomeController extends GetxController{

  // Api api = Api();

  Rx<CoursesModel> coursesModel = CoursesModel().obs;


  RxDouble percentage = 0.0.obs;
  RxInt? courses;
  RxString watchTime = '00:00'.obs;
  var progress;
  RxList<ProgressModel> track = <ProgressModel> [].obs;
  RxMap myCourses = {}.obs;



}