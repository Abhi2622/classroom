import 'package:classroom/ModelClass/classroomModelClass.dart';
import 'package:classroom/ModelClass/studentModelClass.dart';
import 'package:classroom/ModelClass/subjectModelClass.dart';
import 'package:classroom/SupportingWidget/printString.dart';
import 'package:classroom/SupportingWidget/showSnackbarMessage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ClassroomProvider extends ChangeNotifier {
  bool studentLoading = false;

  List<StudentModel> studentList = [];

  Future studentApiCall(BuildContext context) async {
    studentLoading = true;
    notifyListeners();
    try {
      var resp = await Dio().get(
          "https://hamon-interviewapi.herokuapp.com/students/?api_key=Bd9aA");
      studentLoading = false;
      notifyListeners();
      PrintString(resp.data);
      Map respData = resp.data;
      studentList = studentModelFromJson(respData["students"]);
      notifyListeners();
    } catch (e) {
      studentLoading = false;
      showSnackbarMessage(context, "something went wrong");
      PrintString("${e}");
      notifyListeners();
    }
  }

  bool studentDetailsLoading = false;
  StudentModel? studentDetails;

  Future studentDetailApiCall(BuildContext context, {id}) async {
    PrintString(
        "https://hamon-interviewapi.herokuapp.com/students/$id?api_key=Bd9aA");
    studentDetailsLoading = true;
    notifyListeners();
    try {
      var resp = await Dio().get(
          "https://hamon-interviewapi.herokuapp.com/students/$id?api_key=Bd9aA");
      studentDetailsLoading = false;
      notifyListeners();
      PrintString(resp.data);
      studentDetails = StudentModel.fromJson(resp.data);
      notifyListeners();
    } catch (e) {
      studentDetailsLoading = false;
      showSnackbarMessage(context, "something went wrong");
      PrintString("${e}");
      notifyListeners();
    }
  }

  bool subjectLoading = false;
  List<SubjectModel> subjectList = [];

  Future subjectApiCall(BuildContext context) async {
    subjectLoading = true;
    notifyListeners();
    try {
      var resp = await Dio().get(
          "https://hamon-interviewapi.herokuapp.com/subjects/?api_key=Bd9aA");
      subjectLoading = false;
      notifyListeners();
      PrintString(resp.data);
      Map respData = resp.data;
      subjectList = subjectModelFromJson(respData["subjects"]);
      notifyListeners();
    } catch (e) {
      subjectLoading = false;
      showSnackbarMessage(context, "something went wrong");
      PrintString("${e}");
      notifyListeners();
    }
  }

  bool subjectDetailsLoading = false;
  SubjectModel? subjectDetails;

  Future subjectDetailApiCall(BuildContext context, {id}) async {
    subjectDetailsLoading = true;
    notifyListeners();
    try {
      var resp = await Dio().get(
          "https://hamon-interviewapi.herokuapp.com/subjects/${id}?api_key=Bd9aA");
      subjectDetailsLoading = false;
      notifyListeners();
      PrintString(resp.data);
      subjectDetails = SubjectModel.fromJson(resp.data);
      notifyListeners();
    } catch (e) {
      subjectDetailsLoading = false;
      showSnackbarMessage(context, "something went wrong");
      PrintString("${e}");
      notifyListeners();
    }
  }

  bool classroomLoading = false;
  List<ClassroomModel> classroomList = [];

  Future classroomApiCall(BuildContext context) async {
    classroomLoading = true;
    notifyListeners();
    try {
      var resp = await Dio().get(
          "https://hamon-interviewapi.herokuapp.com/classrooms/?api_key=Bd9aA");
      classroomLoading = false;
      notifyListeners();
      PrintString(resp.data);
      Map respData = resp.data;
      classroomList = classroomModelFromJson(respData["classrooms"]);
      notifyListeners();
    } catch (e) {
      classroomLoading = false;
      showSnackbarMessage(context, "something went wrong");
      PrintString("${e}");
      notifyListeners();
    }
  }

  bool classDetailsLoading = false;
  ClassroomModel? classDetails;

  Future classDetailApiCall(BuildContext context, {id}) async {
    _clearPastClassData();
    classDetailsLoading = true;
    classSubjectDetailsLoading = true;

    notifyListeners();
    try {
      var resp = await Dio().get(
          "https://hamon-interviewapi.herokuapp.com/classrooms/${id}?api_key=Bd9aA");
      classDetailsLoading = false;
      classSubjectDetailsLoading = false;
      notifyListeners();
      PrintString(resp.data);
      classDetails = ClassroomModel.fromJson(resp.data);
      notifyListeners();
      PrintString(resp.data);
      if (classDetails!.subject.trim().isNotEmpty) {
        classSubjectDetailApiCall(context,
            id: int.parse(classDetails!.subject));
      }
    } catch (e) {
      classDetailsLoading = false;
      showSnackbarMessage(context, "something went wrong");
      PrintString("${e}");
      notifyListeners();
    }
  }

  bool updateClassLoading = false;

  Future updateclassApiCall(BuildContext context, {id}) async {
    FormData formData = FormData.fromMap({
      "subject": id,
    });
    updateClassLoading = true;
    notifyListeners();
    try {
      var resp = await Dio().patch(
        "https://hamon-interviewapi.herokuapp.com/classrooms/${classDetails!.id}?api_key=Bd9aA",
        data: formData,
      );
      updateClassLoading = false;
      notifyListeners();
      PrintString(resp.data);
      classDetails = ClassroomModel.fromJson(resp.data);
      if(classDetails!.subject.trim().isNotEmpty){
        classSubjectDetailApiCall(context,id:classDetails!.subject);
      }
      notifyListeners();
    } catch (e) {
      updateClassLoading = false;
      showSnackbarMessage(context, "something went wrong");
      PrintString("${e}");
      notifyListeners();
    }
  }

  bool classSubjectDetailsLoading = false;
  SubjectModel? classSubjectDetails;

  Future classSubjectDetailApiCall(BuildContext context, {id}) async {
    classSubjectDetailsLoading = true;
    notifyListeners();
    try {
      var resp = await Dio().get(
          "https://hamon-interviewapi.herokuapp.com/subjects/${id}?api_key=Bd9aA");
      classSubjectDetailsLoading = false;
      notifyListeners();
      PrintString(resp.data);
      classSubjectDetails = SubjectModel.fromJson(resp.data);
      notifyListeners();
    } catch (e) {
      classSubjectDetailsLoading = false;
      showSnackbarMessage(context, "something went wrong");
      PrintString("${e}");
      notifyListeners();
    }
  }

  clear() {
    studentDetails = null;
  }

  _clearPastClassData() {
    classDetails = null;
    classSubjectDetails = null;
    notifyListeners();
  }
}
