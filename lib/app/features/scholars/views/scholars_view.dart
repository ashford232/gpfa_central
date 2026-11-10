import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:gpfa_central/app/features/scholars/data/models/scholar_model.dart';
import 'package:gpfa_central/app/features/scholars/data/services/scholars_provider.dart';
import 'package:gpfa_central/app/features/users/data/services/user_providers.dart';
import 'package:gpfa_central/shared/ui/avatars.dart';
import 'package:gpfa_central/shared/ui/skeletons.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ScholarView extends ConsumerStatefulWidget {
  final Admin currentAdmin;
  const ScholarView({super.key, required this.currentAdmin});

  @override
  ConsumerState<ScholarView> createState() => _ScholarsState();
}

class _ScholarsState extends ConsumerState<ScholarView> {
  int? accepted;
  int? pending;
  int? rejected;
  int? underReview;
  int? disqualified;
  @override
  Widget build(BuildContext context) {
    final scholarsAsync = ref.watch(watchAllScholarsProvider);
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
                  Tab(child: Text('Accepted ${accepted ?? "0"}')),
                  Tab(child: Text('Underreview ${underReview ?? "0"}')),
                  Tab(child: Text('Pending ${pending ?? "0"}')),
                  Tab(child: Text('Disqualified ${rejected ?? "0"}')),
                  Tab(child: Text('Rejected Scholars ${rejected ?? "0"}')),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: scholarsAsync.when(
                  loading: () => AdminDummyList(admins: dummyAdmins),
                  error: (error, stackTrace) =>
                      Center(child: Text('Error loading scholars: $error')),
                  data: (scholars) {
                    final acceptedScholar = scholars
                        .where((scholar) => scholar.status == .accepted)
                        .toList();
                    final pendingScholar = scholars
                        .where((scholar) => scholar.status == .pending)
                        .toList();
                    final rejectedScholar = scholars
                        .where((scholar) => scholar.status == .rejected)
                        .toList();

                    final underReviewScholar = scholars
                        .where((scholar) => scholar.status == .underReview)
                        .toList();
                    final disqualifiedScholar = scholars
                        .where((scholar) => scholar.status == .disqualified)
                        .toList();

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        accepted = acceptedScholar.length;
                        pending = pendingScholar.length;
                        rejected = rejectedScholar.length;
                        underReview = underReviewScholar.length;
                        disqualified = disqualifiedScholar.length;
                      });
                    });
                    return TabBarView(
                      children: [
                        ScholarList(
                          scholars: acceptedScholar,
                          currentAdmin: widget.currentAdmin,
                        ),
                        ScholarList(
                          scholars: underReviewScholar,
                          currentAdmin: widget.currentAdmin,
                        ),
                        ScholarList(
                          scholars: pendingScholar,
                          currentAdmin: widget.currentAdmin,
                        ),
                        ScholarList(
                          scholars: disqualifiedScholar,
                          currentAdmin: widget.currentAdmin,
                        ),
                        ScholarList(
                          scholars: rejectedScholar,
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

class ScholarList extends ConsumerWidget {
  const ScholarList({
    super.key,
    required this.scholars,
    required this.currentAdmin,
  });

  final List<ScholarModel> scholars;
  final Admin currentAdmin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    if (scholars.isEmpty) {
      return const Center(child: Text('No scholars found.'));
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
          itemCount: scholars.length,
          itemBuilder: (context, index) {
            final scholar = scholars[index];
            final userAsync = ref.watch(getUserProvider(scholar.userId));

            return userAsync.when(
              data: (user) {
                if (user == null) {
                  return SizedBox.shrink();
                }
                return InkWell(
                  onTap: () async {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.06,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      child: Row(
                        children: [
                          buildUserAvatar(user: user),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.email,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              error: (err, st) => Center(child: Text(err.toString())),
              loading: () => Skeletonizer(
                child: dummyUser(
                  theme: theme,
                  title: 'User name',
                  subtitle: 'example@gmail.com',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
