import 'package:classroom/Providers/classroomProvider.dart';
import 'package:classroom/Screens/HomePage/ClassRoom/subjectDetails.dart';
import 'package:classroom/SupportingWidget/Qtext.dart';
import 'package:classroom/res/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConferenceDetailsPage extends StatefulWidget {
  final int id;

  const ConferenceDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _ConferenceDetailsPageState createState() => _ConferenceDetailsPageState();
}

class _ConferenceDetailsPageState extends State<ConferenceDetailsPage> {
  ClassroomProvider classroomProvider = ClassroomProvider();

  @override
  Widget build(BuildContext context) {
    classroomProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const QText("Conference Room"),
        elevation: 0,
      ),
      bottomNavigationBar: SubjectDetails(),
      body: Stack(
        children: [
          if (classroomProvider.classDetails != null) SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  boardImage,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: classroomProvider.classDetails!.size -
                              (classroomProvider.classDetails!.size ~/ 2),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset(studentImage),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 8);
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.blue.shade200,
                          height: (classroomProvider.classDetails!.size -
                                  (classroomProvider.classDetails!.size ~/ 2)) *
                              68,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: classroomProvider.classDetails!.size ~/ 2,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset(studentImage),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 8);
                          },
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          if (classroomProvider.classDetailsLoading)
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
      classroomProvider.classDetailApiCall(context, id: widget.id);
    });
  }
}
