import 'package:classroom/Providers/classroomProvider.dart';
import 'package:classroom/SupportingWidget/Qtext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectDetails extends StatefulWidget {
  final int id;

  const SubjectDetails({Key? key, required this.id}) : super(key: key);

  @override
  _SubjectDetailsState createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  ClassroomProvider classroomProvider = ClassroomProvider();

  @override
  Widget build(BuildContext context) {
    classroomProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const QText("Subject Details"),
      ),
      body: Stack(
        children: [
          if (classroomProvider.subjectDetails != null)
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.menu_book_sharp),
                  ),
                  QText(
                    classroomProvider.subjectDetails!.name.toString(),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 5),
                  QText(
                    classroomProvider.subjectDetails!.teacher.toString(),
                  ),
                  QText(
                    classroomProvider.subjectDetails!.credits.toString(),
                  ),
                ],
              ),
            ),
          if (classroomProvider.subjectDetailsLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      classroomProvider.subjectDetailApiCall(context, id: widget.id);
    });
  }
}
