// To parse this JSON data, do
//
//     final classroomModel = classroomModelFromJson(jsonString);

import 'dart:convert';

List<ClassroomModel> classroomModelFromJson(List str) => List<ClassroomModel>.from(str.map((x) => ClassroomModel.fromJson(x)));

String classroomModelToJson(List<ClassroomModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassroomModel {
  ClassroomModel({
    this.id,
    this.layout,
    this.name,
    required this.size,
    required this.subject,
  });

  int? id;
  String? layout;
  String? name;
  int size;
  String subject;

  factory ClassroomModel.fromJson(Map<String, dynamic> json) => ClassroomModel(
    id: json["id"],
    layout: json["layout"],
    name: json["name"],
    size: json["size"],
    subject: json["subject"] == null ? "":json["subject"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "layout": layout,
    "name": name,
    "size": size,
    "subject":subject,
  };
}
