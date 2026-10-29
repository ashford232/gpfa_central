import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/features/admins/data/services/admins_providers.dart';
import 'package:gpfa_central/shared/ui/assc.dart';
import 'package:gpfa_central/shared/ui/skeletons.dart';

class Admins extends ConsumerStatefulWidget {
  final Admin currentAdmin;
  const Admins({super.key, required this.currentAdmin});

  @override
  ConsumerState<Admins> createState() => _AdminsState();
}

class _AdminsState extends ConsumerState<Admins> {
  int? verified;
  int? pending;
  int? rejected;
  @override
  Widget build(BuildContext context) {
    final adminsAsync = ref.watch(getAllAdminsStreamProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Admins')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                dividerHeight: 0,
                indicatorSize: .tab,
                isScrollable: true,
                tabAlignment: .start,
                indicator: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                  borderRadius: .circular(2),
                ),
                labelColor: theme.colorScheme.onSurface,
                //   padding: .zero,
                splashBorderRadius: .circular(2),
                tabs: [
                  Tab(child: Text('Verified Admins ${verified ?? "0"}')),
                  Tab(child: Text('Pending Admins ${pending ?? "0"}')),
                  Tab(child: Text('Rejected Admins ${rejected ?? "0"}')),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: adminsAsync.when(
                  loading: () => AdminDummyList(admins: dummyAdmins),
                  error: (error, stackTrace) =>
                      Center(child: Text('Error loading admins: $error')),
                  data: (admins) {
                    final verifiedAdmins = admins
                        .where(
                          (admin) =>
                              admin.role != .unverified &&
                              admin.role != .rejected,
                        )
                        .toList();

                    final pendingAdmins = admins
                        .where((admin) => admin.role == .unverified)
                        .toList();
                    final rejectedAdmins = admins
                        .where((admin) => admin.role == .rejected)
                        .toList();

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        verified = verifiedAdmins.length;
                        pending = pendingAdmins.length;
                        rejected = rejectedAdmins.length;
                      });
                    });
                    return TabBarView(
                      children: [
                        AdminList(
                          admins: verifiedAdmins,
                          currentAdmin: widget.currentAdmin,
                        ),
                        AdminList(
                          admins: pendingAdmins,
                          currentAdmin: widget.currentAdmin,
                        ),
                        AdminList(
                          admins: rejectedAdmins,
                          currentAdmin: widget.currentAdmin,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminList extends ConsumerWidget {
  const AdminList({
    super.key,
    required this.admins,
    required this.currentAdmin,
  });

  final List<Admin> admins;
  final Admin currentAdmin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminsController = ref.read(adminsControllerProvider);
    ;
    final theme = Theme.of(context);
    if (admins.isEmpty) {
      return const Center(child: Text('No admins found.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = switch (constraints.maxWidth) {
          >= 1100 => 3,
          >= 650 => 2,
          _ => 1,
        };

        return GridView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 2,
            mainAxisExtent: 60,
          ),
          itemCount: admins.length,
          itemBuilder: (context, index) {
            final admin = admins[index];

            return InkWell(
              onTap: () async {
                try {
                  if (admin.role == .unverified ||
                      admin.role == .rejected ||
                      admin.role == .admin ||
                      admin.role == .staff && admin.role == .superadmin) {
                    final res = await showCustomNativeDialog(
                      admin.email,
                      title: admin.name,
                      windowTitle: 'Admin Management',
                      naturalText: admin.role == .admin || admin.role == .staff
                          ? null
                          : admin.role == .rejected
                          ? 'Delete'
                          : 'Reject',
                      positiveText: admin.role == .admin || admin.role == .staff
                          ? 'Suspend'
                          : 'Confirm',
                      negativeText: 'Cancel',
                    );

                    switch (res) {
                      case .negativeButton:
                        break;
                      case .neutralButton:
                        if (admin.role == .rejected) {
                          await adminsController.deleteAdmin(adminId: admin.id);
                        } else {
                          await adminsController.rejectAdmin(adminId: admin.id);
                        }
                        if (context.mounted) {
                          AppNotification.show(
                            additionalWidget: buildAdminAvatar(
                              context: context,
                              admin: admin,
                            ),
                            context: context,
                            title: admin.name,

                            message: admin.role == .rejected
                                ? 'Pending Admin Deleted'
                                : 'Admin Access Rejected',
                            type: AppNotificationType.success,
                          );
                        }

                        break;
                      case .positiveButton:
                        if (admin.role == .admin || admin.role == .staff) {
                          await adminsController.suspendAdmin(
                            adminId: admin.id,
                          );
                        } else {
                          await adminsController.confirmAdmin(
                            adminId: admin.id,
                          );
                        }
                        if (context.mounted) {
                          AppNotification.show(
                            additionalWidget: buildAdminAvatar(
                              context: context,
                              admin: admin,
                            ),
                            context: context,
                            title: admin.name,
                            message:
                                admin.role == .admin || admin.role == .staff
                                ? 'Admin Suspended'
                                : 'Admin Access Confirmed',
                            type: AppNotificationType.success,
                          );
                        }
                      default:
                        break;
                    }
                  }
                } catch (err) {
                  debugPrint(err.toString());
                  showNativeDialog(err.toString());
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 2,
                  ),
                  child: Row(
                    children: [
                      buildAdminAvatar(context: context, admin: admin),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              admin.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              admin.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
