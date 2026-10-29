import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/services/auth_providers.dart';
import 'package:gpfa_central/app/auth/views/signin.dart';
import 'package:gpfa_central/app/central/views/app_wrapper.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStream = ref.watch(adminStreamProvider);
    return authStream.when(
      data: (admin) {
        if (admin == null) return Signin();
        return AppWrapper(admin: admin);
      },
      error: (err, st) => Scaffold(body: Center(child: Text(st.toString()))),
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
