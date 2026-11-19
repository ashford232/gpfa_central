import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/data/services/app_providers.dart';
import 'package:gpfa_central/shared/ui/app_buttons.dart';

class AddForm extends ConsumerStatefulWidget {
  final Admin admin;
  const AddForm({super.key, required this.admin});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddFormState();
}

class _AddFormState extends ConsumerState<AddForm> {
  @override
  Widget build(BuildContext context) {
    final navNotifier = ref.watch(
      navigationServiceProvider(widget.admin).notifier,
    );
    final nav = ref.watch(navigationServiceProvider(widget.admin));
    return Scaffold(
      appBar: AppBar(
        leading: appBackButton(
          onPressed: () {
            if (!nav.usual) {
              navNotifier.changeIndex(nav.index);
            }
          },
        ),
        title: Text('Add Form'),
      ),
    );
  }
}
