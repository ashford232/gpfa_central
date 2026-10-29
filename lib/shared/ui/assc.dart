import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:gpfa_central/main.dart';

class AppLoadingDialog extends StatelessWidget {
  final String message;

  const AppLoadingDialog({super.key, this.message = 'Loading...'});

  static void show({String message = 'Loading...'}) {
    final context = router.navigatorKey.currentContext;
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents closing by tapping outside
        builder: (context) => AppLoadingDialog(message: message),
      );
    }
  }

  /// Hide/dismiss the loading dialog globally
  static void hide() {
    final context = router.navigatorKey.currentContext;
    if (context != null && Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: .center,
            children: [
              SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  strokeCap: .round,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 20.0),
              Flexible(
                child: Text(message, style: const TextStyle(fontSize: 16.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showNativeDialog(String message, {String title = 'Notice'}) async {
  try {
    await FlutterPlatformAlert.showAlert(
      windowTitle: title,
      text: message,
      alertStyle: AlertButtonStyle.ok,
      iconStyle: IconStyle.information,
    );
  } catch (e) {
    debugPrint("Failed to show native OS dialog: $e");
  }
}

Future<CustomButton?> showCustomNativeDialog(
  String message, {
  String title = 'Notice',
  String? windowTitle,
  String? naturalText,
  String? positiveText,
  String? negativeText,
}) async {
  try {
    return await FlutterPlatformAlert.showCustomAlert(
      windowTitle: title,
      text: message,
      iconStyle: IconStyle.none,
      options: PlatformAlertOptions(
        windows: WindowsAlertOptions(additionalWindowTitle: windowTitle ?? ""),
      ),
      neutralButtonTitle: naturalText,
      negativeButtonTitle: negativeText,
      positiveButtonTitle: positiveText,
    );
  } catch (e) {
    debugPrint("Failed to show native OS dialog: $e");
    return null;
  }
}

Future<T?> showAppDialogShell<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  String? title,
  String? subtitle,
  double width = 440,
  double height = 440,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black.withValues(alpha: 0.3),
    transitionDuration: const Duration(milliseconds: 120),
    pageBuilder: (context, animation, secondaryAnimation) {
      final brightness = Theme.of(context).brightness;

      final backgroundColor = brightness == Brightness.dark
          ? const Color(0xFF202020)
          : const Color(0xFFF3F3F3);

      final borderColor = brightness == Brightness.dark
          ? Colors.white.withValues(alpha: 0.1)
          : Colors.black.withValues(alpha: 0.1);

      final textColor = brightness == Brightness.dark
          ? Colors.white
          : Colors.black87;

      final subtitleColor = brightness == Brightness.dark
          ? Colors.white60
          : Colors.black54;

      return Center(
        child: FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: width,
                height: height,
                constraints: const BoxConstraints(maxHeight: 700),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Optional Standard Header (if title is provided)
                      if (title != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              if (subtitle != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: subtitleColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                      // 🔥 HERE IS WHERE YOUR CUSTOM WIDGET GOES
                      Flexible(child: builder(context)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
