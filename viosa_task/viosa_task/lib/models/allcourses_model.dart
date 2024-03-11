import 'dart:convert';

CoursesModel coursesModelFromJson(String str) => CoursesModel.fromJson(json.decode(str));

String coursesModelToJson(CoursesModel data) => json.encode(data.toJson());

class CoursesModel {
  List<Course>? courses;

  CoursesModel({
    this.courses,
  });

  factory CoursesModel.fromJson(Map<String, dynamic> json) => CoursesModel(
    courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
  };
}

class Course {
  String? courseId;
  String? name;
  bool? isPublished;
  String? thumbnail;
  String? description;
  String? category;
  Price? price;
  int? order;
  bool? isCounselling;
  String? videoLink1;
  String? videoLink2;
  bool? isTool;

  Course({
    this.courseId,
    this.name,
    this.isPublished,
    this.thumbnail,
    this.description,
    this.category,
    this.price,
    this.order,
    this.isCounselling,
    this.videoLink1,
    this.videoLink2,
    this.isTool,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    courseId: json["course_id"],
    name: json["name"],
    isPublished: json["isPublished"],
    thumbnail: json["thumbnail"],
    description: json["description"],
    category: json["category"],
    price: priceValues.map[json["price"]]!,
    order: json["order"],
    isCounselling: json["isCounselling"],
    videoLink1: json["videoLink1"],
    videoLink2: json["videoLink2"],
    isTool: json["isTool"],
  );

  Map<String, dynamic> toJson() => {
    "course_id": courseId,
    "name": name,
    "isPublished": isPublished,
    "thumbnail": thumbnail,
    "description": description,
    "category": category,
    "price": priceValues.reverse[price],
    "order": order,
    "isCounselling": isCounselling,
    "videoLink1": videoLink1,
    "videoLink2": videoLink2,
    "isTool": isTool,
  };
}

enum Price {
  CONTACT_US
}

final priceValues = EnumValues({
  "Contact Us": Price.CONTACT_US
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
