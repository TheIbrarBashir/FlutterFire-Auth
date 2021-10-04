import 'package:cas_finance_management/repository/firebase/firebase_auth/firebase_auth_services.dart';
import 'package:cas_finance_management/repository/firebase_model_class/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreCourse {
  late User _user;
  FireStoreCourse() {
    _user = UserAuthentication.firebaseUser!;
  }

  final Course course = Course();
  bool isCourseAdded = false;
  bool isCourseError = false;

  String? get uid => _user.uid;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addCourse(
      {String? courseTitle, String? courseTeacher, double? courseFee}) async {
    DocumentReference documentReference = _userCollection.doc(uid);

    return documentReference
        .collection('course')
        .add((Course(
                courseTitle: courseTitle,
                courseTeacher: courseTeacher,
                courseFee: courseFee)
            .toMap()))
        .then((value) {
    //  documentReference.update({'courseId': FieldValue.increment(1)});
      isCourseAdded = true;
    }).catchError((error) {
      isCourseError = true;
    });
  }

  /*Stream<Stream<QuerySnapshot<Map<String, dynamic>>>> getCourses() async* {
    yield _userCollection.doc(uid).collection('courses').snapshots();
  }*/
}
