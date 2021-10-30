// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cas_finance_management/presentation/widgets/widgets.dart';
import 'package:cas_finance_management/repository/firebase/firestore_services/firestore_course.dart';
import 'package:cas_finance_management/repository/firebase_model_class/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List _courseDropDownList = <String>['Choose Course'];

class EnrolledGroupsPage extends StatefulWidget {
  static const routeName = '/enrolled_groups';
  const EnrolledGroupsPage({Key? key}) : super(key: key);

  @override
  _EnrolledGroupsPageState createState() => _EnrolledGroupsPageState();
}

class _EnrolledGroupsPageState extends State<EnrolledGroupsPage> {
  final TextEditingController _timePickerController = TextEditingController();

  void populatingList() async {
    String _uid = FirebaseAuth.instance.currentUser!.uid;
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('course')
        .orderBy('courseServerStamp', descending: true)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((element) {
      var cour = Course.fromMap(element.data() as Map<String, dynamic>);
      _courseDropDownList.add(cour.courseTitle);

      print('DocID: ${cour.courseTitle}');
      print(_courseDropDownList.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initStates
    super.initState();
    setState(() {
      populatingList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InputFormField(
              labelText: 'Lecture Time',
              hintText: TimeOfDay.now().format(context).toLowerCase(),
              readOnly: true,
              controller: _timePickerController,
              onTap: () async {
                TimeOfDay? lectureTime;
                lectureTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                _timePickerController.text =
                    lectureTime!.format(context).toLowerCase();
              },
              icon: const Icon(Icons.access_time),
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
            ),
            InputFormField(
              labelText: 'Group Title',
              hintText: 'Flutter F3',
              icon: const Icon(Icons.groups_outlined),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            CourseDropDown(),
            InputFormField(
              labelText: 'Group CR',
              hintText: 'John Doe',
              icon: const Icon(Icons.person_outline),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    ));
  }
}

class CourseDropDown extends StatefulWidget {
  const CourseDropDown({Key? key}) : super(key: key);

  @override
  _CourseDropDownState createState() => _CourseDropDownState();
}

class _CourseDropDownState extends State<CourseDropDown> {
  var _chosenValue = 'Choose Course';

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DropdownButton<dynamic>(
          focusColor: Colors.white,
          value: _chosenValue,

          //elevation: 5,
          style: TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          items: _courseDropDownList
              .map<DropdownMenuItem<dynamic>>((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          hint: Text(
            "choose Course",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          onChanged: (value) {
            setState(() {
              _chosenValue = value;
            });
          },
          onTap: () {
            setState(() {});
          },
        ),
      ),
    );
  }
}
