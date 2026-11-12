import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/features/scholars/data/models/scholar_model.dart';
import 'package:gpfa_central/app/features/scholars/data/services/scholars_provider.dart';
import 'package:gpfa_central/app/features/users/data/models/user_model.dart';
import 'package:gpfa_central/shared/ui/app_buttons.dart';
import 'package:gpfa_central/shared/ui/avatars.dart';
import 'package:gpfa_central/shared/utls/extensions.dart';
import 'package:gpfa_central/shared/utls/utils.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:lite_router/lite_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ScholarReview extends ConsumerStatefulWidget {
  final ScholarModel scholar;
  final UserModel user;
  const ScholarReview({super.key, required this.scholar, required this.user});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScholarReviewState();
}

class _ScholarReviewState extends ConsumerState<ScholarReview> {
  bool disqualifyLoading = false;
  bool rejectLoading = false;
  bool underReviewLoading = false;
  bool acceptLoading = false;

  @override
  Widget build(BuildContext context) {
    final scholarController = ref.watch(scholarControllerProvider);
    return Scaffold(
      appBar: AppBar(leading: appBackButtonX(), title: Text('Scholar Review')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: .start,
              children: [
                buildUserAvatar(user: widget.user, width: 80, height: 80),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      widget.user.name,
                      style: TextStyle(fontSize: 18, fontWeight: .bold),
                    ),
                    Text(widget.user.email),
                    Text(DateFormat("yMMMd").format(widget.user.createdAt)),
                    Text(widget.scholar.status.name.capitalize),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        final uri = Uri.parse(widget.scholar.awardLetterUrl);

                        if (!await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception('Could not open award letter');
                        }
                      },
                      child: Row(
                        children: [
                          Icon(HugeIconsStroke.documentAttachment),
                          const SizedBox(width: 5),
                          Text('Award Letter'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (widget.scholar.status != .accepted) ...[
                      AppButton(
                        width: 300,

                        isLoading: acceptLoading,
                        onPressed: () async {
                          try {
                            setState(() {
                              acceptLoading = true;
                            });

                            await scholarController.changeStatus(
                              status: .accepted,
                              scholarId: widget.scholar.id,
                              userId: widget.user.id,
                            );
                          } catch (err) {
                            AppNotification.show(
                              title: 'Error',
                              message: err.toString(),
                            );
                          } finally {
                            setState(() {
                              acceptLoading = false;
                            });
                            if (context.mounted) {
                              context.back();
                            }
                          }
                        },
                        text: 'Accept',
                        prefix: Icon(HugeIconsStroke.checkmarkBadge01),
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (widget.scholar.status != .rejected) ...[
                      AppButton(
                        width: 300,
                        isLoading: rejectLoading,
                        onPressed: () async {
                          try {
                            setState(() {
                              rejectLoading = true;
                            });

                            await scholarController.changeStatus(
                              status: .rejected,
                              scholarId: widget.scholar.id,
                              userId: widget.user.id,
                            );
                          } catch (err) {
                            AppNotification.show(
                              title: 'Error',
                              message: err.toString(),
                            );
                          } finally {
                            setState(() {
                              rejectLoading = false;
                            });
                            if (context.mounted) {
                              context.back();
                            }
                          }
                        },
                        text: 'Reject',
                        prefix: Icon(HugeIconsStroke.cancel01),
                      ),
                      const SizedBox(height: 10),
                    ],

                    if (widget.scholar.status != .disqualified) ...[
                      AppButton(
                        width: 300,

                        isLoading: disqualifyLoading,
                        onPressed: () async {
                          try {
                            setState(() {
                              disqualifyLoading = true;
                            });
                            await scholarController.changeStatus(
                              status: .disqualified,
                              scholarId: widget.scholar.id,
                              userId: widget.user.id,
                            );
                          } catch (err) {
                            AppNotification.show(
                              title: 'Error',
                              message: err.toString(),
                            );
                          } finally {
                            setState(() {
                              disqualifyLoading = false;
                            });
                            if (context.mounted) {
                              context.back();
                            }
                          }
                        },
                        text: 'Disqualify',
                        prefix: Icon(HugeIconsStroke.userBlock01),
                      ),
                      const SizedBox(height: 10),
                    ],

                    if (widget.scholar.status != .underReview) ...[
                      AppButton(
                        width: 300,

                        isLoading: underReviewLoading,
                        onPressed: () async {
                          try {
                            setState(() {
                              underReviewLoading = true;
                            });
                            await scholarController.changeStatus(
                              status: .underReview,
                              scholarId: widget.scholar.id,
                              userId: widget.user.id,
                            );
                          } catch (err) {
                            AppNotification.show(
                              title: 'Error',
                              message: err.toString(),
                            );
                          } finally {
                            setState(() {
                              underReviewLoading = false;
                            });
                            if (context.mounted) {
                              context.back();
                            }
                          }
                        },
                        text: 'Under Review',
                        prefix: Icon(HugeIconsStroke.view),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
