import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/auth/data/services/auth_providers.dart';
import 'package:gpfa_central/app/features/admins/data/services/admins_providers.dart';
import 'package:gpfa_central/app/features/admins/views/admins.dart';
import 'package:gpfa_central/shared/ui/app_buttons.dart';
import 'package:gpfa_central/shared/ui/assc.dart';
import 'package:gpfa_central/shared/ui/avatars.dart';
import 'package:gpfa_central/shared/utls/extensions.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:lite_router/lite_router.dart';

class AdminProfile extends ConsumerStatefulWidget {
  final Admin admin;
  final Admin currentAdmin;
  const AdminProfile({
    super.key,
    required this.admin,
    required this.currentAdmin,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminProfileState();
}

class _AdminProfileState extends ConsumerState<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    final adminsController = ref.read(adminsControllerProvider);
    final authController = ref.read(authControllerProvider);
    final admin = widget.admin;
    final currentAdmin = widget.currentAdmin;
    final isCurrentAdmin = admin.id == currentAdmin.id;
    return Scaffold(
      appBar: AppBar(
        leading: appBackButtonX(),
        title: Text("Profile", style: TextStyle(fontSize: 16)),
        actions: [
          IconButton(
            onPressed: () async {
              if (isCurrentAdmin) {
                context.back();

                return authController.signout();
              }
              return adminAction(
                admin: admin,
                currentAdmin: currentAdmin,
                adminsController: adminsController,
              );
            },
            icon: isCurrentAdmin
                ? Text('Signout')
                : Icon(HugeIconsStroke.moreVertical),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            GestureDetector(
              onTap: () {
                showAppDialogShell(
                  width: 200,
                  height: 200,
                  context: context,
                  builder: (context) {
                    return Center(
                      child: buildAdminAvatar(
                        borderRadius: 0,
                        admin: admin,
                        width: 200,
                        height: 200,
                      ),
                    );
                  },
                );
              },
              child: buildAdminAvatar(admin: admin, width: 100, height: 100),
            ),
            const SizedBox(height: 10),

            Text(admin.name, style: TextStyle(fontSize: 24)),
            const SizedBox(height: 5),

            Text(admin.email, style: TextStyle(decoration: .underline)),
            const SizedBox(height: 5),

            if (admin.phone.isNotEmpty) ...[
              Text(admin.phone),
              const SizedBox(height: 5),
            ],
            Text(
              "Joined: ${DateFormat('MMMM d, yyy').format(admin.createdAt)}",
            ),
            const Spacer(),

            Divider(),
            Text(admin.role.name.capitalize),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
