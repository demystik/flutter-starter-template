import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_spacing.dart';

enum AppBadgeVariant {
  primary,
  success,
  warning,
  error,
  neutral,
}

enum AppBadgeStyle {
  filled,
  subtle,
  outlined,
}

enum AppBadgeSize {
  sm,
  md,
}

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.primary,
    this.style = AppBadgeStyle.subtle,
    this.size = AppBadgeSize.md,
    this.leadingIcon,
  })  : child = null,
        count = null,
        isDot = false,
        maxCount = 99,
        showZero = false;

  /// Creates a badge attached as an overlay on a child widget, showing a numeric counter.
  const AppBadge.count({
    super.key,
    required this.child,
    required this.count,
    this.maxCount = 99,
    this.showZero = false,
    this.variant = AppBadgeVariant.error,
  })  : label = null,
        style = AppBadgeStyle.filled,
        size = AppBadgeSize.sm,
        leadingIcon = null,
        isDot = false;

  /// Creates a simple status dot overlay on a child widget.
  const AppBadge.dot({
    super.key,
    required this.child,
    this.variant = AppBadgeVariant.error,
  })  : label = null,
        count = null,
        maxCount = 99,
        showZero = false,
        style = AppBadgeStyle.filled,
        size = AppBadgeSize.sm,
        leadingIcon = null,
        isDot = true;

  final String? label;
  final Widget? child;
  final int? count;
  final int maxCount;
  final bool showZero;
  final bool isDot;
  final AppBadgeVariant variant;
  final AppBadgeStyle style;
  final AppBadgeSize size;
  final Widget? leadingIcon;

  Color _getBaseColor(ColorScheme colors) {
    switch (variant) {
      case AppBadgeVariant.primary:
        return colors.primary;
      case AppBadgeVariant.success:
        return AppColors.success;
      case AppBadgeVariant.warning:
        return AppColors.warning;
      case AppBadgeVariant.error:
        return AppColors.error;
      case AppBadgeVariant.neutral:
        return colors.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final baseColor = _getBaseColor(colors);

    // If used as an overlay badge (.count or .dot)
    if (child != null) {
      if (count != null && count! <= 0 && !showZero) {
        return child!;
      }

      Widget badgeWidget;
      if (isDot) {
        badgeWidget = Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: baseColor,
            shape: BoxShape.circle,
            border: Border.all(color: colors.surface, width: 1.5),
          ),
        );
      } else {
        final displayString = count != null && count! > maxCount
            ? '$maxCount+'
            : '${count ?? 0}';

        badgeWidget = Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(color: colors.surface, width: 1.5),
          ),
          child: Center(
            child: Text(
              displayString,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
          ),
        );
      }

      return Stack(
        clipBehavior: Clip.none,
        children: [
          child!,
          Positioned(
            top: -4,
            right: -4,
            child: badgeWidget,
          ),
        ],
      );
    }

    // Standalone badge / status pill
    Color bgColor;
    Color fgColor;
    BoxBorder? border;

    switch (style) {
      case AppBadgeStyle.filled:
        bgColor = baseColor;
        fgColor = Colors.white;
        break;

      case AppBadgeStyle.subtle:
        bgColor = baseColor.withValues(alpha: 0.14);
        fgColor = baseColor;
        break;

      case AppBadgeStyle.outlined:
        bgColor = Colors.transparent;
        fgColor = baseColor;
        border = Border.all(color: baseColor.withValues(alpha: 0.5), width: 1);
        break;
    }

    final isSmall = size == AppBadgeSize.sm;
    final padding = isSmall
        ? const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2)
        : const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm + 2, vertical: AppSpacing.xs);
    final fontSize = isSmall ? 11.0 : 12.0;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: border,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            IconTheme(
              data: IconThemeData(size: fontSize + 1, color: fgColor),
              child: leadingIcon!,
            ),
            const SizedBox(width: 4),
          ],
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                color: fgColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
        ],
      ),
    );
  }
}
