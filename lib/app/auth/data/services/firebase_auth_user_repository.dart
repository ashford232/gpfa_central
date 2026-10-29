import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/auth/data/models/enums.dart';
import 'package:rxdart/rxdart.dart';
class FirebaseAuthUserRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseAuthUserRepository({required this._auth, required this._firestore});
  Stream<User?> getUserStream() {
    return _auth.authStateChanges();
  }

  Stream<Admin?> getAdminStream() {
  return getUserStream().switchMap((user) {
    if (user == null) {
      return Stream.value(null);
    }

    return _firestore
        .collection('admins')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }

      return Admin.fromMap(snapshot.data()!);
    });
  });
}

  Future<Admin?> getAdmin() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return null;
      final res = await _firestore.collection("admins").doc(uid).get();
      if (!res.exists) return null;
      if (res.data() == null) return null;
      return Admin.fromMap(res.data()!);
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<bool?> emailExists({required String email}) async {
    try {
      final res = await _firestore
          .collection('admins')
          .where('email', isEqualTo: email.trim().toLowerCase())
          .limit(1)
          .get();
      return res.docs.isNotEmpty;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<bool?> isDbEmpty() async {
    try {
      final res = await _firestore.collection('admins').get();
      return res.docs.isEmpty;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<Admin?> requestAdminAccess({
    required User user,
    required String name,
    required Role role,
  }) async {
    try {
      final admin = Admin(
        id: user.uid,
        name: name,
        email: user.email ?? "",
        phone: "",
        avatar: "",
        role: role,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final ref = _firestore.collection('admins').doc(user.uid);
      ref.set(admin.toMap());
      return admin;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }
}
