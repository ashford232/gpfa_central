import 'dart:convert';

import 'package:gpfa_central/app/features/users/data/models/enums.dart';


class Institution {
  final String id;
  final String name;
  final String course;
  final SchoolType type;
  final CollegeLevel collegeLevel;
  final TvetLevel tvetLevel;
  final SecondaryLevel secondaryLevel;
  final DateTime startDate;
  final DateTime expectedEndDate;
  Institution({
    required this.id,
    required this.name,
    required this.course,
    required this.type,
    required this.collegeLevel,
    required this.tvetLevel,
    required this.secondaryLevel,
    required this.startDate,
    required this.expectedEndDate,
  });

  Institution copyWith({
    String? id,
    String? name,
    String? course,
    SchoolType? type,
    CollegeLevel? collegeLevel,
    TvetLevel? tvetLevel,
    SecondaryLevel? secondaryLevel,
    DateTime? startDate,
    DateTime? expectedEndDate,
  }) {
    return Institution(
      id: id ?? this.id,
      name: name ?? this.name,
      course: course ?? this.course,
      type: type ?? this.type,
      collegeLevel: collegeLevel ?? this.collegeLevel,
      tvetLevel: tvetLevel ?? this.tvetLevel,
      secondaryLevel: secondaryLevel ?? this.secondaryLevel,
      startDate: startDate ?? this.startDate,
      expectedEndDate: expectedEndDate ?? this.expectedEndDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'course': course,
      'type': type.name,
      'collegeLevel': collegeLevel.name,
      'tvetLevel': tvetLevel.name,
      'secondaryLevel': secondaryLevel.name,
      'startDate': startDate.millisecondsSinceEpoch,
      'expectedEndDate': expectedEndDate.millisecondsSinceEpoch,
    };
  }

  factory Institution.fromMap(Map<String, dynamic> map) {
    return Institution(
      id: map['id'] as String,
      name: map['name'] as String,
      course: map['course'] as String,
      type: SchoolType.values.firstWhere((test)=> test.name==map["type"]),
      collegeLevel: CollegeLevel.values.firstWhere((test)=> test.name==map["collegeLevel"]),
      tvetLevel: TvetLevel.values.firstWhere((test)=> test.name==map["tvetLevel"]),
      secondaryLevel: SecondaryLevel.values.firstWhere((test)=> test.name==map["secondaryLevel"]),
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      expectedEndDate: DateTime.fromMillisecondsSinceEpoch(map['expectedEndDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Institution.fromJson(String source) => Institution.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Institution(id: $id, name: $name, course: $course, type: $type, collegeLevel: $collegeLevel, tvetLevel: $tvetLevel, secondaryLevel: $secondaryLevel, startDate: $startDate, expectedEndDate: $expectedEndDate)';
  }

  @override
  bool operator ==(covariant Institution other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.course == course &&
      other.type == type &&
      other.collegeLevel == collegeLevel &&
      other.tvetLevel == tvetLevel &&
      other.secondaryLevel == secondaryLevel &&
      other.startDate == startDate &&
      other.expectedEndDate == expectedEndDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      course.hashCode ^
      type.hashCode ^
      collegeLevel.hashCode ^
      tvetLevel.hashCode ^
      secondaryLevel.hashCode ^
      startDate.hashCode ^
      expectedEndDate.hashCode;
  }
}
