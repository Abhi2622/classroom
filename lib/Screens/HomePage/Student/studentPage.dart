import 'package:classroom/Providers/classroomProvider.dart';
import 'package:classroom/Screens/HomePage/Student/studentDetailsPage.dart';
import 'package:classroom/SupportingWidget/Qtext.dart';
import 'package:classroom/SupportingWidget/navigationHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  ClassroomProvider classroomProvider = ClassroomProvider();

  @override
  Widget build(BuildContext context) {
    classroomProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: QText("Student"),
      ),
      body: Stack(
        children: [
          ListView.separated(
            itemCount: classroomProvider.studentList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  push(
                    context,
                    StudentDetailsPage(
                      id: classroomProvider.studentList[index].id!,
                    ),
                  );
                },
                tileColor: Colors.greenAccent,
                title: QText(classroomProvider.studentList[index].name!),
                subtitle: QText(classroomProvider.studentList[index].email!),
                trailing:
                    QText("Age: ${classroomProvider.studentList[index].age}"),
                leading: const Icon(Icons.person),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 5);
            },
          ),
          if (classroomProvider.studentLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      classroomProvider.studentApiCall(context);
    });
  }
}
