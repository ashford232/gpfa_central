import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/data/services/app_providers.dart';
import 'package:gpfa_central/app/features/admins/views/admins.dart';
import 'package:gpfa_central/app/features/applications/views/applications.dart';
import 'package:gpfa_central/app/features/blog/views/blog.dart';
import 'package:gpfa_central/app/features/home/views/home.dart';
import 'package:gpfa_central/app/features/internships/views/internships.dart';
import 'package:gpfa_central/app/features/mail/views/mail.dart';
import 'package:gpfa_central/app/features/media/views/media.dart';
import 'package:gpfa_central/app/features/profile/views/admin_profile.dart';
import 'package:gpfa_central/app/features/scholars/views/scholars.dart';
import 'package:gpfa_central/app/features/settings/views/settings.dart';
import 'package:gpfa_central/shared/ui/app_textfield.dart';
import 'package:gpfa_central/shared/ui/assc.dart';
import 'package:gpfa_central/shared/ui/avatars.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class App extends ConsumerStatefulWidget {
  final Admin admin;
  const App({super.key, required this.admin});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final navService = ref.watch(navigationServiceProvider);
    final navNotifier = ref.watch(navigationServiceProvider.notifier);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      body: Row(
        children: [
          Column(
            children: [
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: .circular(30),
                child: Image.asset(
                  'assets/images/gpfa.jpg',
                  width: 60,
                  height: 60,
                  fit: .cover,
                ),
              ),
              const SizedBox(height: 5),

              Expanded(
                child: SizedBox(
                  width: 74,
                  child: ListView.builder(
                    itemCount: _navItems(admin: widget.admin).length,
                    itemBuilder: (context, index) {
                      final nav = _navItems(admin: widget.admin)[index];
                      final isActive = navService.index == nav.id;
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: InkWell(
                              borderRadius: .circular(6),

                              onTap: () {
                                navNotifier.change(nav.id);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOutCubic,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: .circular(6),
                                  color: isActive
                                      ? theme.colorScheme.onSurface.withValues(
                                          alpha: 0.12,
                                        )
                                      : null,
                                ),
                                width: 74,
                                child: Column(
                                  crossAxisAlignment: .center,
                                  mainAxisAlignment: .center,
                                  children: [
                                    AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      switchInCurve: Curves.easeOut,
                                      switchOutCurve: Curves.easeIn,
                                      transitionBuilder: (child, animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      child: AnimatedSize(
                                        duration: const Duration(
                                          milliseconds: 250,
                                        ),

                                        child: Icon(
                                          isActive ? nav.activeIcon : nav.icon,
                                          size: isActive ? 30 : 25,
                                        ),
                                      ),
                                    ),

                                    AnimatedSize(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      curve: Curves.easeInOutCubic,
                                      child: isActive
                                          ? SizedBox(width: 0)
                                          : Column(
                                              children: [
                                                const SizedBox(height: 5),
                                                Text(
                                                  nav.name,
                                                  maxLines: 1,
                                                  textAlign: .center,
                                                  overflow: .ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            top: 15,
                            left: 8,
                            bottom: 15,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: isActive ? 1 : 0),
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOutCubic,
                              builder: (context, value, child) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 5,
                                    height: isActive
                                        ? (15 + (value * 15))
                                        : (30 - (value * 15)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: isActive
                                          ? theme.colorScheme.primary
                                          : Colors.transparent,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisSize: .min,
                            children: [
                              Flexible(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 300,
                                    maxHeight: 35,
                                  ),

                                  child: AppTextFormField(
                                    prefixIcon: Icon(HugeIconsStroke.search01),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 0,
                                    ),
                                    hintText:
                                        'Search ${_navItems(admin: widget.admin)[navService.index].name.toLowerCase()}',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showAppDialogShell(
                                  context: context,
                                  builder: (context) {
                                    return Mail();
                                  },
                                );
                              },
                              icon: Icon(HugeIconsStroke.chat01),
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () {
                                showAppDialogShell(
                                  context: context,
                                  builder: (context) {
                                    return Media();
                                  },
                                );
                              },
                              icon: Icon(HugeIconsStroke.download02),
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () {
                                showAppDialogShell(
                                  context: context,
                                  builder: (context) {
                                    return AdminProfile(
                                      admin: widget.admin,
                                      currentAdmin: widget.admin,
                                    );
                                  },
                                );
                              },
                              icon: buildAdminAvatar(admin: widget.admin),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    clipBehavior: .hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: .only(topLeft: .circular(20)),
                      border: Border(
                        top: BorderSide(
                          width: 0.5,
                          color: Theme.of(
                            context,
                          ).dividerColor.withValues(alpha: 0.7),
                        ),
                        left: BorderSide(
                          width: 0.5,
                          color: Theme.of(
                            context,
                          ).dividerColor.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: .only(topLeft: .circular(20)),

                      child: IndexedStack(
                        index: navService.index,
                        children: _navItems(
                          admin: widget.admin,
                        ).map((nv) => nv.widget).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Nav {
  final String name;
  final int id;
  final IconData icon;
  final IconData activeIcon;
  final Widget widget;

  Nav({
    required this.name,
    required this.id,
    required this.icon,
    required this.widget,
    required this.activeIcon,
  });
}

List<Nav> _navItems({required Admin admin}) {
  final navItems = [
    Nav(
      name: 'Dashboard',
      id: 0,
      icon: HugeIconsStroke.home04,
      activeIcon: HugeIconsSolid.home04,
      widget: Home(),
    ),
    if (admin.role == .superadmin)
      Nav(
        name: 'Admins',
        id: 1,
        icon: HugeIconsStroke.userShield01,
        activeIcon: HugeIconsSolid.userShield01,
        widget: Admins(currentAdmin: admin),
      ),
    Nav(
      name: 'Scholars',
      id: 2,
      icon: HugeIconsStroke.userGroup,
      activeIcon: HugeIconsSolid.userGroup,
      widget: Scholars(),
    ),
    Nav(
      name: 'Applications',
      id: 3,
      icon: HugeIconsStroke.file02,
      activeIcon: HugeIconsSolid.file02,
      widget: Applications(),
    ),
    Nav(
      name: 'Internships',
      id: 4,
      icon: HugeIconsStroke.briefcase01,
      activeIcon: HugeIconsSolid.briefcase01,
      widget: Internships(),
    ),
    Nav(
      name: 'Blog',
      id: 5,
      icon: HugeIconsStroke.news01,
      activeIcon: HugeIconsSolid.news01,
      widget: Blog(),
    ),
    Nav(
      name: 'Settings',
      id: 6,
      icon: HugeIconsStroke.settings01,
      activeIcon: HugeIconsSolid.settings01,
      widget: Settings(),
    ),
  ];

  return navItems;
}
