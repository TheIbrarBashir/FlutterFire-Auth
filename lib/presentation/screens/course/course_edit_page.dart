// ignore_for_file: avoid_print, unused_field

import 'package:cas_finance_management/configuration.dart';
import 'package:cas_finance_management/presentation/screens/course/course_page.dart';
import 'package:cas_finance_management/presentation/widgets/widgets.dart';
import 'package:cas_finance_management/repository/firebase/firestore_services/firestore_course.dart';

import 'package:flutter/material.dart';

class CourseEditPage extends StatefulWidget {
  static const routeName = '/courseEdit';

  const CourseEditPage({Key? key}) : super(key: key);

  @override
  _CourseEditPageState createState() => _CourseEditPageState();
}

class _CourseEditPageState extends State<CourseEditPage> {
  TextEditingController _courseTitleEditingController = TextEditingController();
  TextEditingController _courseTeacherEditingController =
      TextEditingController();
  TextEditingController _courseFeeEditingController = TextEditingController();

  String? _courseTitle;
  String? _courseTeacher;
  double? _courseFee;
  Widget _courseField({
    Widget? leading,
    String? title,
    required String? data,
    required Widget trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
        title: Text('$title'),
        leading: leading,
        subtitle: Text('$data'),
        trailing: trailing,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _arguments =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    _courseTitle = _arguments.courseTitle;
    _courseTeacher = _arguments.courseTeacher;
    _courseFee = _arguments.courseFee;

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _courseField(
              title: 'Course Title',
              leading: const Icon(Icons.book_online, color: ColorSchema.grey),
              data: _courseTitle,
              trailing: IconButton(
                onPressed: () {
                  _courseTitleEditingController =
                      TextEditingController(text: _courseTitle);
                  _showCourseEditDialog(
                      context: context,
                      onSave: () async {
                        _courseTitle = _courseTitleEditingController.text;
                        await FireStoreCourse().updateCourse(
                            userId: _arguments.userId,
                            docId: _arguments.documentId,
                            data: {'courseTitle': _courseTitle});
                        Navigator.pop(context);
                      },
                      child: InputFormField(
                        labelText: 'Course Title',
                        autoFocus: true,
                        controller: _courseTitleEditingController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ));
                },
                icon: const Icon(
                  Icons.edit,
                  color: ColorSchema.blue,
                ),
              )), // End Course Title
          _courseField(
            title: 'Course Instructor',
            leading: const Icon(Icons.person_outline_rounded,
                color: ColorSchema.grey),
            data: _courseTeacher,
            trailing: IconButton(
                onPressed: () {
                  _courseTeacherEditingController =
                      TextEditingController(text: _courseTeacher);
                  _showCourseEditDialog(
                      context: context,
                      onSave: () async {
                        _courseTeacher = _courseTeacherEditingController.text;
                        await FireStoreCourse().updateCourse(
                            userId: _arguments.userId,
                            docId: _arguments.documentId,
                            data: {'courseTeacher': _courseTeacher});
                        Navigator.pop(context);
                      },
                      child: InputFormField(
                        autoFocus: true,
                        labelText: 'Course Instructor',
                        controller: _courseTeacherEditingController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ));
                },
                icon: const Icon(Icons.edit, color: ColorSchema.blue)),
          ), // end Course Teacher
          _courseField(
            title: 'Course Fee',
            leading: const Icon(Icons.assignment_turned_in_outlined,
                color: ColorSchema.grey),
            data: _courseFee.toString(),
            trailing: IconButton(
                onPressed: () {
                  _courseFeeEditingController =
                      TextEditingController(text: _courseFee.toString());
                  _showCourseEditDialog(
                      onSave: () async {
                        _courseFee =
                            double.tryParse(_courseFeeEditingController.text);
                        await FireStoreCourse().updateCourse(
                            userId: _arguments.userId,
                            docId: _arguments.documentId,
                            data: {'courseFee': _courseFee});

                        Navigator.pop(context);
                      },
                      context: context,
                      child: InputFormField(
                        labelText: 'Course Fee',
                        autoFocus: true,
                        controller: _courseFeeEditingController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ));
                },
                icon: const Icon(Icons.edit, color: ColorSchema.blue)),
          ) // end course fee
        ],
      )),
    );
  }
}

Future<void> _showCourseEditDialog(
    {required BuildContext context,
    VoidCallback? onSave,
    Widget? child}) async {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Container(
              height: 80,
              alignment: Alignment.center,
              child: child,
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(onPressed: onSave, child: const Text('Save')),
            ],
          ));
}
