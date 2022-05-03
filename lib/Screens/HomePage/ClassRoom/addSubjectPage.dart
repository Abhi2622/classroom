import 'package:classroom/Providers/subjectProvider.dart';
import 'package:classroom/SupportingWidget/Qtext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSubjectPage extends StatefulWidget {
  @override
  _AddSubjectPageState createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  SubjectProvider subjectProvider = SubjectProvider();
  @override
  Widget build(BuildContext context) {
    subjectProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: const QText("Add subject"),),
      body:  Stack(
        children: [
          ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context,subjectProvider.subjectList[index].id);
                  },
                  tileColor: Colors.greenAccent,
                  title: QText(
                    "${subjectProvider.subjectList[index].name}",
                  ),
                  subtitle:
                  QText("${subjectProvider.subjectList[index].teacher}"),
                  trailing:
                  QText("${subjectProvider.subjectList[index].credits}"),
                  leading: const Icon(Icons.menu_book_sharp),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemCount: subjectProvider.subjectList.length),

          if (subjectProvider.subjectLoading)
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
      subjectProvider.subjectApiCall(context);
    });
  }
}
