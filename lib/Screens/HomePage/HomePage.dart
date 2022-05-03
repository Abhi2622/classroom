
import 'package:classroom/Screens/HomePage/ClassRoom/classRoomPage.dart';
import 'package:classroom/Screens/HomePage/Register/registerPage.dart';
import 'package:classroom/Screens/HomePage/Student/studentPage.dart';
import 'package:classroom/Screens/HomePage/Subject/subjectPage.dart';
import 'package:classroom/SupportingWidget/Qtext.dart';
import 'package:classroom/SupportingWidget/navigationHelper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List name = [
    {"name": "Student", "Page": StudentPage(),"icon": Icons.wc},
    {"name": "Classroom", "Page":ClassRoomPage(),"icon": Icons.school_rounded},
    {"name": "Subject", "Page": SubjectPage(),"icon": Icons.subject},
    {"name": "Register", "Page": RegisterPage(),"icon": Icons.app_registration}
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  push(context, name[index]["Page"]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlue,
                    gradient: LinearGradient(colors: [Colors.blueAccent,Colors.lightBlue])
                  ),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(name[index]["icon"],color: Colors.white,),
                      Center(
                          child: QText(
                        name[index]["name"],
                        color: Colors.white,
                      )),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: name.length),
      ),
    );
  }
}
