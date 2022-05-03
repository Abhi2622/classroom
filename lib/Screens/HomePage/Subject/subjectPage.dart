import 'package:classroom/Providers/classroomProvider.dart';
import 'package:classroom/Screens/HomePage/Subject/subjectDetails.dart';
import 'package:classroom/SupportingWidget/Qtext.dart';
import 'package:classroom/SupportingWidget/navigationHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  ClassroomProvider classroomProvider = ClassroomProvider();

  @override
  Widget build(BuildContext context) {
    classroomProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const QText("Subject"),
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    push(
                      context,
                      SubjectDetails(
                          id: classroomProvider.subjectList[index].id!),
                    );
                  },
                  tileColor: Colors.greenAccent,
                  title: QText(
                    "${classroomProvider.subjectList[index].name}",
                  ),
                  subtitle:
                      QText("${classroomProvider.subjectList[index].teacher}"),
                  trailing:
                      QText("${classroomProvider.subjectList[index].credits}"),
                  leading: const Icon(Icons.menu_book_sharp),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemCount: classroomProvider.subjectList.length),
          if (classroomProvider.subjectLoading)
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
      classroomProvider.subjectApiCall(context);
    });
  }
}
