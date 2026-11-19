import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/data/services/app_providers.dart';
import 'package:gpfa_central/app/features/home/views/add_form.dart';
import 'package:gpfa_central/app/features/home/views/manage_forms.dart';
import 'package:gpfa_central/app/features/home/views/review_submissions.dart';
import 'package:gpfa_central/shared/utls/extensions.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class Home extends ConsumerStatefulWidget {
  final Admin admin;
  const Home({super.key, required this.admin});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final nav = ref.watch(navigationServiceProvider(widget.admin));
    final navNotifier = ref.watch(
      navigationServiceProvider(widget.admin).notifier,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = switch (constraints.maxWidth) {
          >= 1100 => 3,
          >= 650 => 2,
          _ => 1,
        };

        return Scaffold(
          appBar: AppBar(title: Text("Dashboard")),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final padding = switch (constraints.maxWidth) {
                >= 1100 => EdgeInsets.symmetric(horizontal: 100),
                >= 650 => EdgeInsets.symmetric(horizontal: 20),
                _ => EdgeInsets.symmetric(horizontal: 5),
              };

              return Padding(
                padding: padding,
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: _listDashboardItems.length,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 16,
                          left: 8,
                          right: 8,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 40,
                        ),
                        itemBuilder: (context, index) {
                          final item = _listDashboardItems[index];

                          return DashboardActionCard(
                            item: item,
                            onTap: () {
                              navNotifier.changeView(item.child);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  List<DashboardAction> get _listDashboardItems => [
    DashboardAction(
      name: "Add Form",
      color: Colors.red,
      icon: HugeIconsStroke.fileAdd,
      child: AddForm(admin: widget.admin),
    ),
    DashboardAction(
      name: "Manage Forms",
      color: Colors.blue,
      icon: HugeIconsStroke.folderEdit,
      child: ManageForms(admin: widget.admin),
    ),
    DashboardAction(
      child: ReviewSubmissions(admin: widget.admin),
      name: "Review Submissions",
      color: Colors.orange,
      icon: HugeIconsStroke.fileVerified,
    ),
  ];
}

class DashboardActionCard extends StatelessWidget {
  final DashboardAction item;
  final VoidCallback onTap;

  const DashboardActionCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(item.icon, color: item.color.appropriateTextColor, size: 25),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: item.color.appropriateTextColor,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_outward_rounded,
                      size: 17,
                      color: item.color.appropriateTextColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardAction {
  final String name;
  final Color color;
  final IconData icon;
  final Widget child;

  DashboardAction({
    required this.name,
    required this.color,
    required this.icon,
    required this.child,
  });
}
