// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

List<StudentModel> studentModelFromJson(List str) => List<StudentModel>.from(str.map((x) => StudentModel.fromJson(x)));

String studentModelToJson(List<StudentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentModel {
  StudentModel({
    this.age,
    this.email,
    this.id,
    this.name,
  });

  int? age;
  String? email;
  int? id;
  String? name;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    age: json["age"],
    email: json["email"],
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "age": age,
    "email": email,
    "id": id,
    "name": name,
  };
}
