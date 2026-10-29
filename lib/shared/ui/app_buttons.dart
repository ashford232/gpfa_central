import 'package:flutter/material.dart';
import 'package:gpfa_central/main.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:lite_router/lite_router.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.text,
    this.child,
    this.prefix,
    this.suffix,
    this.isLoading = false,
    this.enabled = true,
    this.width,
    this.height = 48,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.borderRadius = 8,
    this.elevation = 0,
    this.textStyle,
    this.alignment = Alignment.center,
    this.grayscale,
  }) : assert(
         text != null || child != null,
         'Either text or child must be provided.',
       );

  final bool? grayscale;
  final VoidCallback? onPressed;

  /// Simple text button content.
  final String? text;

  /// Use this when you need completely custom content.
  final Widget? child;

  /// Widget displayed before the text/content.
  final Widget? prefix;

  /// Widget displayed after the text/content.
  final Widget? suffix;

  /// Shows a progress indicator and disables the button.
  final bool isLoading;

  /// Allows manually disabling the button.
  final bool enabled;

  /// Button width. Defaults to the available width.
  final double? width;

  /// Button height.
  final double height;

  /// Internal button padding.
  final EdgeInsetsGeometry? padding;

  /// Button background color.
  final Color? backgroundColor;

  /// Button text/icon color.
  final Color? foregroundColor;

  /// Background color when disabled.
  final Color? disabledBackgroundColor;

  /// Foreground color when disabled.
  final Color? disabledForegroundColor;

  /// Border color.
  final Color? borderColor;

  /// Border width.
  final double borderWidth;

  /// Border radius.
  final double borderRadius;

  /// Button elevation.
  final double elevation;

  /// Text style.
  final TextStyle? textStyle;

  /// Content alignment.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isEnabled = enabled && !isLoading && onPressed != null;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          elevation: elevation,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
          alignment: alignment,

          backgroundColor: grayscale == true
              ? theme.colorScheme.onSurface.withValues(alpha: 0.10)
              : backgroundColor ?? theme.colorScheme.onSurface,
          foregroundColor: grayscale == true
              ? theme.colorScheme.onSurface
              : foregroundColor ?? theme.colorScheme.surface,
          disabledBackgroundColor: disabledBackgroundColor,
          disabledForegroundColor: disabledForegroundColor,
          side: borderWidth > 0
              ? BorderSide(
                  color: borderColor ?? theme.colorScheme.outline,
                  width: borderWidth,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          textStyle:
              textStyle ??
              theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (child != null) {
      return child!;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefix != null) ...[prefix!, const SizedBox(width: 8)],

        Flexible(
          child: Text(text ?? "Button", overflow: TextOverflow.ellipsis),
        ),

        if (suffix != null) ...[const SizedBox(width: 8), suffix!],
        if (isLoading) ...[
          const SizedBox(width: 8),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ],
    );
  }
}

Widget appInkwell({
  required Widget child,
  InteractiveInkFeatureFactory? splashFactory,
  double? borderRadius,
  double? padding,
  BoxBorder? border,
  Color? background,
  Function()? onTap,
  Function(TapDownDetails)? onTapDown,
  final int? onPressedMilliseconds,
}) {
  return AppPressable(
    onTap: onTap,
    milliseconds: onPressedMilliseconds,
    borderRadius: BorderRadius.circular(borderRadius ?? 10),
    child: InkWell(
      onTapDown: onTapDown,
      splashFactory:
          splashFactory ?? InkSparkle.constantTurbulenceSeedSplashFactory,
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      child: Container(
        padding: EdgeInsets.all(padding ?? 8.0),

        decoration: BoxDecoration(
          border: border,
          color: background,
          borderRadius: .circular(borderRadius ?? 10),
        ),
        child: child,
      ),
    ),
  );
}

class AppPressable extends StatefulWidget {
  const AppPressable({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.borderColor,
    this.milliseconds,
  });

  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final int? milliseconds;

  @override
  State<AppPressable> createState() => _AppPressableState();
}

class _AppPressableState extends State<AppPressable> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = widget.borderRadius ?? BorderRadius.circular(2);

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.milliseconds ?? 700),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(
            width: 0.3,
            color: _pressed
                ? widget.borderColor ?? theme.colorScheme.outline
                : Colors.transparent,
          ),
          color: _pressed
              ? theme.colorScheme.onSurface.withValues(alpha: 0.06)
              : Colors.transparent,
        ),
        child: widget.child,
      ),
    );
  }
}

Widget appBackButton({VoidCallback? onPressed, Color? color}) {
  final context = router.navigatorKey.currentContext;
  return IconButton(
    onPressed:
        onPressed ??
        () {
          if (context?.canPop() == true) {
            context?.back();
          }
        },
    icon: Icon(HugeIconsSolid.arrowLeft02, color: color),
  );
}
