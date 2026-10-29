import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.aspectRatio,
    this.border,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? aspectRatio;
  final bool? border;

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, _) => AspectRatio(
        aspectRatio: aspectRatio ?? 1,
        child: placeholder ?? const SizedBox.expand(),
      ),
      errorWidget: (_, _, _) => AspectRatio(
        aspectRatio: aspectRatio ?? 1,
        child:
            errorWidget ??
            const Center(child: Icon(HugeIconsStroke.imageNotFound02)),
      ),
    );

    if (borderRadius == null) {
      return image;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border == null
            ? null
            : Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.2),
                width: 0.6,
              ),
      ),
      child: ClipRRect(borderRadius: borderRadius!, child: image),
    );
  }
}
