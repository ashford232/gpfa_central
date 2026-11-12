import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpfa_central/app/features/scholars/data/models/scholar_model.dart';
import 'package:gpfa_central/app/features/users/data/models/enums.dart';

class ScholarsRepository {
  final FirebaseFirestore _firestore;

  ScholarsRepository({required this._firestore});

  Future<List<ScholarModel>> getAllScholars() async {
    try {
      final res = await _firestore.collection('scholars').get();
      if (res.docs.isEmpty) {
        return [];
      }
      return res.docs
          .where((doc) => doc.exists)
          .map((doc) => ScholarModel.fromMap(doc.data()))
          .toList();
    } catch (err) {
      debugPrint(err.toString());
      return [];
    }
  }

  Stream<List<ScholarModel>> watchAllScholars() {
    try {
      final res = _firestore.collection('scholars').snapshots();
      return res.map(
        (doc) => doc.docs
            .where((doc) => doc.exists)
            .map((doc) => ScholarModel.fromMap(doc.data()))
            .toList(),
      );
    } catch (err) {
      debugPrint(err.toString());
      return Stream.value([]);
    }
  }

  Future<void> changeScholarStatus({
    required String scholarId,
    required String userId,
    required ApplicationStatus status,
  }) async {
    try {
      final docRef = _firestore.collection("scholars").doc(scholarId);
      final doc = await docRef.get();
      if (doc.exists) {
        docRef.update({"status": status.name});

        if (status == .accepted) {
          await onAccept(userId: userId);
        } else {
          await onNotAccept(userId: userId);
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> onAccept({required String userId}) async {
    try {
      final docRef = _firestore.collection('users').doc(userId);
      final doc = await docRef.get();
      if (doc.exists) {
        docRef.update({"userRole": UserRole.scholar.name});
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> onNotAccept({required String userId}) async {
    try {
      final docRef = _firestore.collection('users').doc(userId);
      final doc = await docRef.get();
      if (doc.exists) {
        docRef.update({"userRole": UserRole.user.name});
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
