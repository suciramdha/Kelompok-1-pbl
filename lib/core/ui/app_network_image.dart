import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.semanticLabel,
    this.imageProvider,
    this.errorWidget,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String? semanticLabel;

  /// Dipakai untuk test tanpa network.
  final ImageProvider? imageProvider;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final cacheWidth = width == null
        ? null
        : (width! * MediaQuery.devicePixelRatioOf(context)).round();

    Widget child;
    if (imageProvider != null) {
      child = Image(
        image: imageProvider!,
        width: width,
        height: height,
        fit: fit,
        semanticLabel: semanticLabel,
        errorBuilder: (context, error, stackTrace) =>
            _fallback(context, scheme),
      );
    } else {
      child = Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: cacheWidth,
        semanticLabel: semanticLabel,
        loadingBuilder: (context, image, progress) {
          if (progress == null) return image;
          return Container(
            width: width,
            height: height,
            color: scheme.surfaceContainerHigh,
            alignment: Alignment.center,
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: scheme.primary,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) =>
            _fallback(context, scheme),
      );
    }

    if (borderRadius == null) return child;
    return ClipRRect(borderRadius: borderRadius!, child: child);
  }

  Widget _fallback(BuildContext context, ColorScheme scheme) {
    return errorWidget ??
        Container(
          width: width,
          height: height,
          color: scheme.surfaceContainerLow,
          alignment: Alignment.center,
          child: Icon(
            Icons.restaurant_rounded,
            size: 24,
            color: scheme.onSurfaceVariant,
          ),
        );
  }
}
