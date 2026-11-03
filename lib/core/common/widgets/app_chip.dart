import 'package:flutter/material.dart';
import '../../config/theme/app_spacing.dart';

enum AppChipVariant { filled, outlined }

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.onTap,
    this.onDeleted,
    this.selected = false,
    this.enabled = true,
    this.leadingIcon,
    this.trailingIcon,
    this.variant = AppChipVariant.filled,
  });

  final String label;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final bool selected;
  final bool enabled;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final AppChipVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final borderRadius = BorderRadius.circular(AppRadius.full);

    Color bgColor;
    if (!enabled) {
      bgColor = colors.surfaceContainerHighest.withValues(alpha: 0.2);
    } else if (selected) {
      bgColor = colors.primary;
    } else if (variant == AppChipVariant.outlined) {
      bgColor = Colors.transparent;
    } else {
      bgColor = colors.surfaceContainerHighest.withValues(alpha: 0.5);
    }

    Color textColor;
    if (!enabled) {
      textColor = colors.onSurface.withValues(alpha: 0.38);
    } else if (selected) {
      textColor = colors.onPrimary;
    } else {
      textColor = colors.onSurface;
    }

    BorderSide? border;
    if (variant == AppChipVariant.outlined) {
      border = BorderSide(
        color: !enabled
            ? colors.outline.withValues(alpha: 0.2)
            : selected
                ? colors.primary
                : colors.outline.withValues(alpha: 0.4),
        width: 1,
      );
    }

    return Material(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: border ?? BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs + 2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                IconTheme(
                  data: IconThemeData(size: 16, color: textColor),
                  child: leadingIcon!,
                ),
                const SizedBox(width: AppSpacing.xs + 2),
              ],
              Text(
                label,
                style: text.labelMedium?.copyWith(
                  color: textColor,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: AppSpacing.xs + 2),
                IconTheme(
                  data: IconThemeData(size: 16, color: textColor),
                  child: trailingIcon!,
                ),
              ],
              if (onDeleted != null) ...[
                const SizedBox(width: AppSpacing.xs + 2),
                InkWell(
                  onTap: enabled ? onDeleted : null,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  child: Icon(
                    Icons.close_rounded,
                    size: 14,
                    color: textColor.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
