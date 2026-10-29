import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/services/auth_providers.dart';
import 'package:gpfa_central/shared/ui/app_buttons.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class UnverifiedAdmin extends ConsumerStatefulWidget {
  const UnverifiedAdmin({super.key});

  @override
  ConsumerState<UnverifiedAdmin> createState() => _UnverifiedAdminState();
}

class _UnverifiedAdminState extends ConsumerState<UnverifiedAdmin> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authController = ref.read(authControllerProvider);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Container(
                padding: EdgeInsets.all(24),

                decoration: BoxDecoration(
                  borderRadius: .circular(5),
                  border: Border.all(
                    color: theme.colorScheme.surfaceContainerHigh,
                  ),
                ),
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .center,
                  children: [
                    Icon(HugeIconsStroke.authorized, size: 60),
                    const SizedBox(height: 20),

                    Text(
                      'Access Restricted',
                      style: TextStyle(fontSize: 20, fontWeight: .bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Your account doesn’t currently have permission to access this panel. Please contact your administrator for assistance.',
                      style: TextStyle(fontSize: 16, fontWeight: .w300),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            backgroundColor: theme.colorScheme.error,
                            foregroundColor: theme.colorScheme.onError,
                            height: 35,
                            borderRadius: 1,

                            onPressed: () async {
                              authController.signout();
                            },
                            text: 'Logout',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AppButton(
                            borderRadius: 1,
                            height: 35,

                            onPressed: () async {
                              ref.invalidate(adminStreamProvider);
                              final _ = await ref.read(
                                adminStreamProvider.future,
                              );
                            },
                            text: 'Try again',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
