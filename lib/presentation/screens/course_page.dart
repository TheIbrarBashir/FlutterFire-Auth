import 'package:cas_finance_management/presentation/authentication_pages/login_form.dart';

import 'package:cas_finance_management/presentation/widgets/widgets.dart';

import 'package:cas_finance_management/repository/firebase/firestore_services/firestore_course.dart';
import 'package:cas_finance_management/repository/firebase_model_class/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _courseTitleController = TextEditingController();
    TextEditingController _courseTeacherController = TextEditingController();
    TextEditingController _courseFeeController = TextEditingController();
    Future<void> _addCourseDialog() async {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Add Course'),
                scrollable: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                content: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InputFormField(
                        labelText: 'Course title',
                        hintText: 'Android',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _courseTitleController,
                      ),
                      InputFormField(
                        labelText: 'Course Teacher',
                        hintText: 'Noman Ameer Khan',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _courseTeacherController,
                      ),
                      InputFormField(
                        labelText: 'Course Fee',
                        hintText: '50000.00',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _courseFeeController,
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        FireStoreCourse fireStoreCourse = FireStoreCourse();
                        fireStoreCourse.addCourse(
                            courseTitle: _courseTitleController.text,
                            courseTeacher: _courseTeacherController.text,
                            courseFee: double.parse(_courseFeeController.text));
                      },
                      icon: const Icon(Icons.post_add)),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.cancel))
                ],
              ));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              userAuth.logOut().then((value) {
                Navigator.pop(context);
              });
            },
            icon: const Icon(Icons.logout)),
      ),
      body: const CourseList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addCourseDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(_uid)
          .collection('course')
          .orderBy('courseId')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot userData = snapshot.data!.docs[index];
              Map<String, dynamic> course =
                  userData.data() as Map<String, dynamic>;

              Course _cour = Course.fromMap(course);

              return ListTile(
                title: Text('${_cour.courseTitle}'),
                subtitle: Text('${_cour.courseTeacher}'),
                trailing: Text('${_cour.courseFee}'),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
