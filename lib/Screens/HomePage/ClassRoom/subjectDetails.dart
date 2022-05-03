import 'package:classroom/Providers/classroomProvider.dart';
import 'package:classroom/Screens/HomePage/ClassRoom/addSubjectPage.dart';
import 'package:classroom/SupportingWidget/Qtext.dart';
import 'package:classroom/res/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectDetails extends StatefulWidget {
  @override
  _SubjectDetailsState createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  ClassroomProvider classroomProvider = ClassroomProvider();

  @override
  Widget build(BuildContext context) {
    classroomProvider = Provider.of(context);
    return Container(
      color: primaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(classroomProvider.classSubjectDetailsLoading)
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),

          ///
          if (classroomProvider.classSubjectDetails != null &&
              !classroomProvider.classSubjectDetailsLoading)
            ListTile(
                title: QText(
                  "${classroomProvider.classSubjectDetails?.name}",
                  color: Colors.white,
                ),
                trailing: IconButton(
                  onPressed: () {
                    _getSubject();
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                )),
          if (classroomProvider.classSubjectDetails == null &&
              !classroomProvider.classSubjectDetailsLoading )
            ListTile(
                title: const QText(
                  "Add subject",
                  color: Colors.white,
                ),
                trailing: IconButton(
                  onPressed: () {
                    _getSubject();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )),
        ],
      ),
    );
  }

  _getSubject() async {
    var id = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddSubjectPage(),
      ),
    );

    if (id != null) {
      classroomProvider.updateclassApiCall(context, id: id);
    }
  }
}
