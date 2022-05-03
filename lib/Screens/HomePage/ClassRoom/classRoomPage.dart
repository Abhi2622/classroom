import 'package:classroom/Providers/classroomProvider.dart';
import 'package:classroom/Screens/HomePage/ClassRoom/classRoomDetailsPage.dart';
import 'package:classroom/Screens/HomePage/ClassRoom/confrenceDetailsPage.dart';
import 'package:classroom/SupportingWidget/Qtext.dart';
import 'package:classroom/SupportingWidget/navigationHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassRoomPage extends StatefulWidget {
  @override
  _ClassRoomPageState createState() => _ClassRoomPageState();
}

class _ClassRoomPageState extends State<ClassRoomPage> {
  ClassroomProvider classroomProvider = ClassroomProvider();

  @override
  Widget build(BuildContext context) {
    classroomProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const QText("Class Room"),
      ),
      body: Stack(
        children: [
          ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    if (classroomProvider.classroomList[index].layout ==
                        "classroom") {
                      push(
                        context,
                        ClassRoomDetailsPage(
                            id: classroomProvider.classroomList[index].id!),
                      );
                    } else {
                      push(
                        context,
                       ConferenceDetailsPage(id: classroomProvider.classroomList[index].id!),
                      );
                    }
                  },
                  tileColor: Colors.greenAccent,
                  title:
                      QText("${classroomProvider.classroomList[index].name}"),
                  subtitle:
                      QText("${classroomProvider.classroomList[index].layout}"),
                  trailing: QText(
                      "Size :${classroomProvider.classroomList[index].size}"),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 5);
              },
              itemCount: classroomProvider.classroomList.length),
          if (classroomProvider.classroomLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      classroomProvider.classroomApiCall(context);
    });
  }
}
