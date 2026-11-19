import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/central/views/app.dart';
import 'package:gpfa_central/app/features/admins/views/admin_view.dart';
import 'package:gpfa_central/app/features/applications/views/applications.dart';
import 'package:gpfa_central/app/features/blog/views/blog.dart';
import 'package:gpfa_central/app/features/home/views/home.dart';
import 'package:gpfa_central/app/features/internships/views/internships.dart';
import 'package:gpfa_central/app/features/scholars/views/scholars_view.dart';
import 'package:gpfa_central/app/features/settings/views/settings.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class NavigationService extends Notifier<NavigationState> {
  final Admin admin;

  NavigationService({required this.admin});
  @override
  NavigationState build() {
    return NavigationState(
      index: 0,
      currentView: navItems()[0].widget,
      usual: true,
    );
  }

  void changeIndex(int val) {
    state = state.copyWith(
      index: val,
      currentView: navItems()[val].widget,
      usual: true,
    );
  }

  void changeView(Widget view) {
    state = state.copyWith(currentView: view, usual: false);
  }

  //
  List<Nav> navItems() {
    final navItems = [
      Nav(
        name: 'Dashboard',
        id: 0,
        icon: HugeIconsStroke.home04,
        activeIcon: HugeIconsSolid.home04,
        widget: Home(admin: admin),
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
        widget: ScholarView(currentAdmin: admin),
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
}

class NavigationState {
  final int index;
  final Widget currentView;
  final bool usual;
  NavigationState({
    required this.index,
    required this.currentView,
    required this.usual,
  });

  NavigationState copyWith({int? index, Widget? currentView, bool? usual}) {
    return NavigationState(
      usual: usual ?? this.usual,
      index: index ?? this.index,
      currentView: currentView ?? this.currentView,
    );
  }
}
