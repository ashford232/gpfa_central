import 'package:flutter/material.dart';
import 'package:gpfa_central/app/auth/data/models/admin.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AdminDummyList extends StatelessWidget {
  const AdminDummyList({super.key, required this.admins});

  final List<Admin> admins;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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

            return Container(
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
                    Bone.circle(size: 35),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Skeletonizer(
                        effect: PulseEffect(
                          from: theme.colorScheme.onSurface.withValues(
                            alpha: 0.1,
                          ),
                        ),
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
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
