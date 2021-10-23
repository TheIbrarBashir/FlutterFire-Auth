// ignore_for_file: avoid_print, unused_field

import 'package:cas_finance_management/configuration.dart';
import 'package:cas_finance_management/presentation/screens/course/course_page.dart';
import 'package:cas_finance_management/presentation/widgets/widgets.dart';

import 'package:flutter/material.dart';

class CourseEditPage extends StatefulWidget {
  static const routeName = '/courseEdit';

  const CourseEditPage({Key? key}) : super(key: key);

  @override
  _CourseEditPageState createState() => _CourseEditPageState();
}

class _CourseEditPageState extends State<CourseEditPage> {
  final TextEditingController _courseTitleEditingController =
      TextEditingController();
  final TextEditingController _courseTeacherEditingController =
      TextEditingController();
  final TextEditingController _courseFeeEditingController =
      TextEditingController();

  String? _courseTitle = 'Course Title';
  String? _courseTeacher = 'Course Teacher';
  String? _courseFee = '0.00';
  Widget _courseField(
      {Widget? leading,
      String? title,
      required String? data,
      required VoidCallback onPressed,
      required Icon icon}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
        title: Text('$title'),
        leading: leading,
        subtitle: Text('$data'),
        trailing: IconButton(onPressed: onPressed, icon: icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _arguments =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    _courseTitle = _arguments.courseTitle;
    _courseTeacher = _arguments.courseTeacher;
    _courseFee = _arguments.courseFee.toString();

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _courseField(
              title: 'Course Title',
              leading: const Icon(Icons.book_online, color: ColorSchema.grey),
              data: _courseTitle,
              onPressed: () {
                showCourseEditDialog(
                    context: context,
                    child: InputFormField(
                      labelText: 'Course Title',
                      controller: _courseTitleEditingController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ));
              },
              icon: const Icon(
                Icons.edit,
                color: ColorSchema.blue,
              )),
          _courseField(
              title: 'Course Instructor',
              leading: const Icon(Icons.person_outline_rounded,
                  color: ColorSchema.grey),
              data: _courseTeacher,
              onPressed: () {
                showCourseEditDialog(
                    context: context,
                    child: InputFormField(
                      labelText: 'Course Instructor',
                      controller: _courseTeacherEditingController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ));
              },
              icon: const Icon(Icons.edit, color: ColorSchema.blue)),
          _courseField(
              title: 'Course Fee',
              leading: const Icon(Icons.assignment_turned_in_outlined,
                  color: ColorSchema.grey),
              data: _courseFee,
              onPressed: () {
                showCourseEditDialog(
                    context: context,
                    child: InputFormField(
                      labelText: 'Course Fee',
                      controller: _courseFeeEditingController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ));
              },
              icon: const Icon(Icons.edit, color: ColorSchema.blue))
        ],
      )),
    );
  }
}

Future<void> showCourseEditDialog(
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
              TextButton(onPressed: () {}, child: const Text('Save')),
            ],
          ));
}
