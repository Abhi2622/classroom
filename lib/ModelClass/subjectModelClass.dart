// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

List<SubjectModel> subjectModelFromJson(List str) => List<SubjectModel>.from(str.map((x) => SubjectModel.fromJson(x)));

String subjectModelToJson(List<SubjectModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectModel {
  SubjectModel({
    this.credits,
    this.id,
    this.name,
    this.teacher,
  });

  int? credits;
  int? id;
  String? name;
  String? teacher;

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
    credits: json["credits"],
    id: json["id"],
    name: json["name"],
    teacher: json["teacher"],
  );

  Map<String, dynamic> toJson() => {
    "credits": credits,
    "id": id,
    "name": name,
    "teacher": teacher,
  };
}
