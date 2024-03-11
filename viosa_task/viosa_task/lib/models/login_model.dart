import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? message;
  User? user;
  String? role;
  String? token;

  UserModel({
    this.message,
    this.user,
    this.role,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    role: json["role"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user?.toJson(),
    "role": role,
    "token": token,
  };
}

class User {
  String? id;
  String? name;
  String? role;
  String? phoneNumber;
  String? designation;
  dynamic profileImage;
  String? hireProRole;
  List<dynamic>? education;
  List<dynamic>? cart;
  List<dynamic>? workExperience;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? email;

  User({
    this.id,
    this.name,
    this.role,
    this.phoneNumber,
    this.designation,
    this.profileImage,
    this.hireProRole,
    this.education,
    this.cart,
    this.workExperience,
    this.createdAt,
    this.updatedAt,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    role: json["role"],
    phoneNumber: json["phoneNumber"],
    designation: json["designation"],
    profileImage: json["profileImage"],
    hireProRole: json["hireProRole"],
    education: json["education"] == null ? [] : List<dynamic>.from(json["education"]!.map((x) => x)),
    cart: json["cart"] == null ? [] : List<dynamic>.from(json["cart"]!.map((x) => x)),
    workExperience: json["workExperience"] == null ? [] : List<dynamic>.from(json["workExperience"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "role": role,
    "phoneNumber": phoneNumber,
    "designation": designation,
    "profileImage": profileImage,
    "hireProRole": hireProRole,
    "education": education == null ? [] : List<dynamic>.from(education!.map((x) => x)),
    "cart": cart == null ? [] : List<dynamic>.from(cart!.map((x) => x)),
    "workExperience": workExperience == null ? [] : List<dynamic>.from(workExperience!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "email": email,
  };
}
