// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gpfa_central/app/features/scholars/data/models/institution_model.dart';
import 'package:gpfa_central/app/features/users/data/models/enums.dart';


class ScholarModel {
  final String id;
  final String userId;
  final DateTime? dateOfBirth;
  final Gender gender;
  final String address;
  final Institution? institution;
  final DateTime? scholarshipStartDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ApplicationStatus status;
  final String awardLetterUrl;
  ScholarModel({
    required this.id,
    required this.userId,
    this.dateOfBirth,
    required this.gender,
    required this.address,
    this.institution,
    required this.status,
    this.scholarshipStartDate,
    required this.createdAt,
    required this.updatedAt,
    required this.awardLetterUrl,
  });

  ScholarModel copyWith({
    String? id,
    String? userId,
    DateTime? dateOfBirth,
    Gender? gender,
    String? address,
    String? awardLetterUrl,
    Institution? institution,
    DateTime? scholarshipStartDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    ApplicationStatus? status,
  }) {
    return ScholarModel(
      id: id ?? this.id,
      awardLetterUrl: awardLetterUrl ?? this.awardLetterUrl,
      userId: userId ?? this.userId,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      institution: institution ?? this.institution,
      scholarshipStartDate: scholarshipStartDate ?? this.scholarshipStartDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'awardLetterUrl': awardLetterUrl,
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
      'gender': gender.name,
      'address': address,
      'status': status.name,
      'institution': institution?.toMap(),
      'scholarshipStartDate': scholarshipStartDate?.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ScholarModel.fromMap(Map<String, dynamic> map) {
    return ScholarModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      awardLetterUrl: map['awardLetterUrl'] as String,
      dateOfBirth: map['dateOfBirth'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int),
      gender: Gender.values.firstWhere((test) => test.name == map["gender"]),
      address: map['address'] as String,
      institution: map['institution'] == null
          ? null
          : Institution.fromMap(map['institution'] as Map<String, dynamic>),
      status: ApplicationStatus.values.firstWhere(
        (test) => test.name == map["status"],
      ),

      scholarshipStartDate: map['scholarshipStartDate'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              map['scholarshipStartDate'] as int,
            ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScholarModel.fromJson(String source) =>
      ScholarModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Scholar(id: $id, userId: $userId,awardLetterUrl: $awardLetterUrl, status $status, dateOfBirth: $dateOfBirth, gender: $gender, address: $address, institution: $institution, scholarshipStartDate: $scholarshipStartDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ScholarModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.awardLetterUrl == awardLetterUrl &&
        other.status == status &&
        other.address == address &&
        other.institution == institution &&
        other.scholarshipStartDate == scholarshipStartDate &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        dateOfBirth.hashCode ^
        gender.hashCode ^
        awardLetterUrl.hashCode ^
        status.hashCode ^
        address.hashCode ^
        institution.hashCode ^
        scholarshipStartDate.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
