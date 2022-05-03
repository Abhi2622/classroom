import 'package:classroom/ModelClass/subjectModelClass.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../SupportingWidget/printString.dart';
import '../SupportingWidget/showSnackbarMessage.dart';

class SubjectProvider extends ChangeNotifier{

  bool subjectLoading=false;
  List <SubjectModel> subjectList=[];

  Future subjectApiCall(BuildContext context) async {
    subjectLoading = true;
    notifyListeners();
    try {
      var resp = await Dio().get("https://hamon-interviewapi.herokuapp.com/subjects/?api_key=Bd9aA");
      subjectLoading = false;
      notifyListeners();
      PrintString(resp.data);
      Map respData = resp.data;
      subjectList=subjectModelFromJson(respData["subjects"]);
      notifyListeners();
    } catch (e) {
      subjectLoading = false;
      showSnackbarMessage(context, "something went wrong");
      PrintString("${e}");
      notifyListeners();
    }
  }

}