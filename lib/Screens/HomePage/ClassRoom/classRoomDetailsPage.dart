import 'package:classroom/Providers/classroomProvider.dart';
import 'package:classroom/Screens/HomePage/ClassRoom/subjectDetails.dart';
import 'package:classroom/SupportingWidget/Qtext.dart';
import 'package:classroom/res/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassRoomDetailsPage extends StatefulWidget {
  final int id;

  const ClassRoomDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _ClassRoomDetailsPageState createState() => _ClassRoomDetailsPageState();
}

class _ClassRoomDetailsPageState extends State<ClassRoomDetailsPage> {
  ClassroomProvider classroomProvider = ClassroomProvider();

  @override
  Widget build(BuildContext context) {
    classroomProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const QText("CLassRoom"),
      ),
      bottomNavigationBar: SubjectDetails(),
      body: Stack(
        children: [
          if (classroomProvider.classDetails != null)
            Column(
              children: [
               const SizedBox(height: 20),
                Image.asset(
                  boardImage,
                  height: 100,
                  width: 100,
                ),
               const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: classroomProvider.classDetails!.size,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 40,
                              crossAxisSpacing: 40,
                              childAspectRatio: .9,
                              mainAxisExtent: 50),
                      itemBuilder: (context, index) {
                        return Container(height: 100,width: 100,child: Image.asset(studentImage),);
                      }),
                ),
              ],
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
