import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gpfa_central/main.dart';

enum AppNotificationType { success, error, warning, info }

class AppNotification {
  AppNotification._();

  static OverlayEntry? _entry;

  static void show({
    required String title,
    required String message,
    AppNotificationType type = AppNotificationType.info,
    String? actionLabel,
    VoidCallback? onAction,
    Widget? additionalWidget,
    Duration duration = const Duration(seconds: 4),
  }) {
    final overlay = router.navigatorKey.currentState?.overlay;
    if (overlay == null) {
      return;
    }
    _entry?.remove();
    _entry = null;

    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (overlayContext) => _AppNotificationOverlay(
        title: title,
        message: message,
        type: type,
        actionLabel: actionLabel,
        onAction: onAction,
        duration: duration,
        additionalWidget: additionalWidget,
        onDismiss: () {
          if (identical(_entry, entry)) {
            _entry = null;
          }
          entry.remove();
        },
      ),
    );

    _entry = entry;
    overlay.insert(entry);
  }

  static void dismiss() {
    _entry?.remove();
    _entry = null;
  }
}

class _AppNotificationOverlay extends StatefulWidget {
  const _AppNotificationOverlay({
    required this.title,
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismiss,
    this.actionLabel,
    this.onAction,
    this.additionalWidget,
  });

  final String title;
  final String message;
  final AppNotificationType type;
  final Duration duration;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback onDismiss;
  final Widget? additionalWidget;

  @override
  State<_AppNotificationOverlay> createState() =>
      _AppNotificationOverlayState();
}

class _AppNotificationOverlayState extends State<_AppNotificationOverlay> {
  Timer? _timer;
  bool _visible = false;
  bool _closing = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _visible = true);
      }
    });

    if (widget.duration > Duration.zero) {
      _timer = Timer(widget.duration, _hide);
    }
  }

  void _hide() {
    if (_closing || !mounted) return;

    _closing = true;
    _timer?.cancel();

    setState(() => _visible = false);

    Future.delayed(const Duration(milliseconds: 220), () {
      widget.onDismiss();
    });
  }

  Color _accentColor(ColorScheme colors) {
    return switch (widget.type) {
      AppNotificationType.success => const Color(0xFF16A34A),
      AppNotificationType.error => colors.error,
      AppNotificationType.warning => const Color(0xFFD97706),
      AppNotificationType.info => colors.primary,
    };
  }

  IconData _icon() {
    return switch (widget.type) {
      AppNotificationType.success => Icons.check_circle_outline_rounded,
      AppNotificationType.error => Icons.error_outline_rounded,
      AppNotificationType.warning => Icons.warning_amber_rounded,
      AppNotificationType.info => Icons.info_outline_rounded,
    };
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final accent = _accentColor(colors);

    return Positioned(
      bottom: 20,
      right: 20,
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: AnimatedSlide(
            offset: _visible ? Offset.zero : const Offset(0.08, 0),
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            child: AnimatedOpacity(
              opacity: _visible ? 1 : 0,
              duration: const Duration(milliseconds: 180),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 380, minWidth: 300),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: colors.outlineVariant.withValues(alpha: 0.6),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 28,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.additionalWidget != null) ...[
                              widget.additionalWidget!,
                              const SizedBox(width: 10),
                            ] else
                              Icon(_icon(), color: accent, size: 5),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    widget.message,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colors.onSurfaceVariant,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (widget.actionLabel != null) ...[
                          const SizedBox(height: 14),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FilledButton.tonal(
                              onPressed: widget.onAction == null
                                  ? null
                                  : () {
                                      _hide();
                                      widget.onAction!();
                                    },
                              child: Text(widget.actionLabel!),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
