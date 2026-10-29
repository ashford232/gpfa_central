import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/shared/ui/app_buttons.dart';

class Mail extends ConsumerStatefulWidget {
  const Mail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Mail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: appBackButtonX(),
        title: Text("Mail", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
