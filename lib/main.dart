import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_notifications/flutter_desktop_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/views/auth_wrapper.dart';
import 'package:gpfa_central/firebase_options.dart';
import 'package:gpfa_central/shared/themes/app_theme.dart';
import 'package:lite_router/lite_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await WindowsNotification.registerAumid(
    aumid: 'com.gpfa.central',
    displayName: 'GPFA Central',
  );
  runApp(ProviderScope(child: GpfaCentral()));
}

final router = LiteRouter();

class GpfaCentral extends StatelessWidget {
  const GpfaCentral({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPFA Central Suite',
      navigatorKey: router.navigatorKey,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: .system,
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  }
}
