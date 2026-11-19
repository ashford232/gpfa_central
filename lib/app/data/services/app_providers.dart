import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/data/services/navigation_service.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final navigationServiceProvider = NotifierProvider.family<NavigationService, NavigationState, Admin>((admin) => NavigationService(admin: admin));
