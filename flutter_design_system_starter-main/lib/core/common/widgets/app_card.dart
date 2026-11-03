import 'package:flutter/material.dart';
import '../../config/theme/app_spacing.dart';

enum AppCardVariant {
  elevated,
  outlined,
  filled,
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.variant = AppCardVariant.elevated,
    this.color,
    this.borderRadius,
    this.border,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final AppCardVariant variant;
  final Color? color;
  final double? borderRadius;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(borderRadius ?? AppRadius.lg);

    Color cardColor;
    BorderSide effectiveBorder = BorderSide.none;
    List<BoxShadow>? shadows;

    switch (variant) {
      case AppCardVariant.elevated:
        cardColor = color ?? colors.surface;
        shadows = [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ];
        break;

      case AppCardVariant.outlined:
        cardColor = color ?? Colors.transparent;
        effectiveBorder = border ??
            BorderSide(
              color: colors.outline.withValues(alpha: 0.3),
              width: 1,
            );
        break;

      case AppCardVariant.filled:
        cardColor =
            color ?? colors.surfaceContainerHighest.withValues(alpha: 0.5);
        break;
    }

    if (border != null) {
      effectiveBorder = border!;
    }

    Widget content = Padding(
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      child: child,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: shadows,
      ),
      child: Material(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: effectiveBorder,
        ),
        clipBehavior: Clip.antiAlias,
        child: onTap != null
            ? InkWell(
                onTap: onTap,
                borderRadius: radius,
                child: content,
              )
            : content,
      ),
    );
  }
}
