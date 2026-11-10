import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpfa_central/app/features/users/data/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({required this._firestore});

  Future<List<UserModel>> getAllUsers() async {
    try {
      final res = await _firestore.collection('users').get();
      if (res.docs.isEmpty) {
        return [];
      }
      return res.docs
          .where((doc) => doc.exists)
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();
    } catch (err) {
      debugPrint(err.toString());
      return [];
    }
  }

  Future<UserModel?> getUser({required String userId}) async {
    try {
      final res = await _firestore.collection('users').doc(userId).get();
      if (!res.exists || res.data() == null) {
        return null;
      }
      return UserModel.fromMap(res.data()!);
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Stream<UserModel?> watchUser({required String userId}) {
    try {
      final res = _firestore.collection('users').doc(userId).snapshots();
      return res
          .where((snap) => snap.exists && snap.data() != null)
          .map((doc) => UserModel.fromMap(doc.data()!));
    } catch (err) {
      debugPrint(err.toString());
      return Stream.value(null);
    }
  }

  Stream<List<UserModel>> watchAllUsers() {
    try {
      final res = _firestore.collection('users').snapshots();
      return res.map(
        (doc) => doc.docs
            .where((doc) => doc.exists)
            .map((doc) => UserModel.fromMap(doc.data()))
            .toList(),
      );
    } catch (err) {
      debugPrint(err.toString());
      return Stream.value([]);
    }
  }
}
