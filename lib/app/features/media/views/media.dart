import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/shared/ui/app_buttons.dart';

class Media extends ConsumerStatefulWidget {
  const Media({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Media> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: appBackButtonX(),
        title: Text("Media", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
