import 'package:classroom/Providers/classroomProvider.dart';
import 'package:classroom/SupportingWidget/Qtext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentDetailsPage extends StatefulWidget {
  final int id;

  const StudentDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _StudentDetailsPageState createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  ClassroomProvider classroomProvider = ClassroomProvider();

  @override
  Widget build(BuildContext context) {
    classroomProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: QText("Student Details"),
      ),
      body: Stack(
        children: [
          if (classroomProvider.studentDetails != null)
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const  CircleAvatar(
                  child: Icon(Icons.person),
                ),
              const SizedBox(height: 20),
                  QText(
                    classroomProvider.studentDetails!.name.toString(),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
               const SizedBox(height: 5),
                QText(
                  classroomProvider.studentDetails!.email.toString(),
                ),
                QText("Age: ${classroomProvider.studentDetails!.age}"),

              ],
            ),
          ),
          if (classroomProvider.studentDetailsLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await classroomProvider.studentDetailApiCall(context, id: widget.id);
    });
  }

  @override
  void dispose() {
    super.dispose();
    classroomProvider.clear();
  }
}
