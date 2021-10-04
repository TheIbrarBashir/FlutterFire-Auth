class Course {
  int? courseId = 1;
  String? courseTitle;
  String? courseTeacher;
  double? courseFee;

//<editor-fold desc="Data Methods">

  Course({
    this.courseId,
    this.courseTitle,
    this.courseTeacher,
    this.courseFee,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          runtimeType == other.runtimeType &&
          courseId == other.courseId &&
          courseTitle == other.courseTitle &&
          courseTeacher == other.courseTeacher &&
          courseFee == other.courseFee);

  @override
  int get hashCode =>
      courseId.hashCode ^
      courseTitle.hashCode ^
      courseTeacher.hashCode ^
      courseFee.hashCode;

  @override
  String toString() {
    return 'Course{'
        ' courseId: $courseId,'
        ' courseTitle: $courseTitle,'
        ' courseTeacher: $courseTeacher,'
        ' courseFee: $courseFee,'
        '}';
  }

  Course copyWith({
    int? courseId,
    String? courseTitle,
    String? courseTeacher,
    double? courseFee,
  }) {
    return Course(
      courseId: courseId ?? this.courseId,
      courseTitle: courseTitle ?? this.courseTitle,
      courseTeacher: courseTeacher ?? this.courseTeacher,
      courseFee: courseFee ?? this.courseFee,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'courseTitle': courseTitle,
      'courseTeacher': courseTeacher,
      'courseFee': courseFee,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseId: map['courseId'] as int,
      courseTitle: map['courseTitle'] as String,
      courseTeacher: map['courseTeacher'] as String,
      courseFee: map['courseFee'] as double,
    );
  }

//</editor-fold>
}
