import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/auth/data/models/enums.dart';

class AdminsRepository {
  final FirebaseFirestore _firestore;

  AdminsRepository({required this._firestore});

  Future<List<Admin>> getAllAdmins() async {
    try {
      final snapshot = await _firestore.collection('admins').get();

      return snapshot.docs
          .where((doc) => doc.exists)
          .map((doc) => Admin.fromMap(doc.data()))
          .toList();
    } catch (err) {
      debugPrint(err.toString());
      return [];
    }
  }

  Stream<List<Admin>> getAllAdminsStream() {
    try {
      final snapshots = _firestore.collection('admins').snapshots();

      return snapshots.map(
        (snapshot) =>
            snapshot.docs.map((doc) => Admin.fromMap(doc.data())).toList(),
      );
    } catch (err) {
      debugPrint(err.toString());
      return Stream.value([]);
    }
  }

  Future<void> confirmAdmin({required String adminId}) async {
    try {
      final ref = _firestore.collection('admins').doc(adminId);
      final snapshot = await ref.get();

      if (snapshot.exists) {
        await ref.update({'role': Role.admin.name});
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> rejectAdmin({required String adminId}) async {
    try {
      final ref = _firestore.collection('admins').doc(adminId);
      final snapshot = await ref.get();

      if (snapshot.exists) {
        await ref.update({'role': Role.rejected.name});
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> suspendAdmin({required String adminId}) async {
    try {
      final ref = _firestore.collection('admins').doc(adminId);
      final snapshot = await ref.get();

      if (snapshot.exists) {
        await ref.update({'role': Role.unverified.name});
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> deleteAdmin({required String adminId}) async {
    try {
      final ref = _firestore.collection('admins').doc(adminId);
      final snapshot = await ref.get();

      if (snapshot.exists) {
        await ref.delete();
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
