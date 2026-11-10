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
    required ApplicationStatus status,
  }) async {
    try {
      final doc = _firestore.collection("scholars").doc(scholarId);
      doc.update({"status": status.name});
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
