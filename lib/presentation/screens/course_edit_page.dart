import 'package:cas_finance_management/presentation/screens/course_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourseMasterDetailPage extends StatefulWidget {
  static const routeName = '/courseMaster';
  const CourseMasterDetailPage({Key? key}) : super(key: key);

  @override
  _CourseMasterDetailPageState createState() => _CourseMasterDetailPageState();
}

class _CourseMasterDetailPageState extends State<CourseMasterDetailPage> {
  String update = 'Teacher Changed';
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      body: Center(
          child: ListTile(
        title: Text('${arguments.courseTitle}'),
        onLongPress: () async {
          FirebaseFirestore.instance
              .collection('users')
              .doc(arguments.userId)
              .collection('course')
              .doc(arguments.documentId)
              .update({'courseTeacher': update}).then(
                  (value) => print('Recorde updated'));
        },
      )),
    );
  }
}
