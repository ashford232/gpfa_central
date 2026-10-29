import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/central/views/app.dart';
import 'package:gpfa_central/app/central/views/unverified_admin.dart';

class AppWrapper extends ConsumerWidget {
  final Admin admin;
  const AppWrapper({super.key, required this.admin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (admin.role == .unverified) {
      return UnverifiedAdmin();
    }
    return App(admin: admin);
  }
}
