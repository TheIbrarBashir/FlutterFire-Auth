class Course {
  String? courseTitle;
  String? courseTeacher;
  double? courseFee;

//<editor-fold desc="Data Methods">

  Course({
    this.courseTitle,
    this.courseTeacher,
    this.courseFee,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          runtimeType == other.runtimeType &&
          courseTitle == other.courseTitle &&
          courseTeacher == other.courseTeacher &&
          courseFee == other.courseFee);

  @override
  int get hashCode =>
      courseTitle.hashCode ^ courseTeacher.hashCode ^ courseFee.hashCode;

  @override
  String toString() {
    return 'AddCourse{'
        ' courseTitle: $courseTitle,'
        ' courseTeacher: $courseTeacher,'
        ' courseFee: $courseFee,'
        '}';
  }

  Course copyWith({
    String? courseTitle,
    String? courseTeacher,
    double? courseFee,
  }) {
    return Course(
      courseTitle: courseTitle ?? this.courseTitle,
      courseTeacher: courseTeacher ?? this.courseTeacher,
      courseFee: courseFee ?? this.courseFee,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'course_title': courseTitle,
      'course_teacher': courseTeacher,
      'course_fee': courseFee,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseTitle: map['course_title'] as String,
      courseTeacher: map['course_teacher'] as String,
      courseFee: map['course_fee'] as double,
    );
  }

//</editor-fold>
}
