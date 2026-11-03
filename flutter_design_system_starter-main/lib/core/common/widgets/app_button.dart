import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_spacing.dart';

enum AppButtonVariant {
  primary,
  outlined,
  ghost,
  danger,
}

enum AppButtonSize {
  sm,
  md,
  lg,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.lg,
    this.isLoading = false,
    this.isFullWidth = true,
    this.leadingIcon,
    this.trailingIcon,
    this.borderRadius,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? borderRadius;

  double get _height {
    switch (size) {
      case AppButtonSize.sm:
        return 38;
      case AppButtonSize.md:
        return 46;
      case AppButtonSize.lg:
        return 52;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case AppButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.sm + 4);
      case AppButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.md);
      case AppButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.lg);
    }
  }

  double get _iconSize {
    switch (size) {
      case AppButtonSize.sm:
        return 16;
      case AppButtonSize.md:
        return 18;
      case AppButtonSize.lg:
        return 20;
    }
  }

  double get _loaderSize {
    switch (size) {
      case AppButtonSize.sm:
        return 16;
      case AppButtonSize.md:
        return 18;
      case AppButtonSize.lg:
        return 20;
    }
  }

  TextStyle? _textStyle(TextTheme textTheme) {
    switch (size) {
      case AppButtonSize.sm:
        return textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600);
      case AppButtonSize.md:
        return textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600);
      case AppButtonSize.lg:
        return textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final radius = borderRadius ?? AppRadius.md;
    final isInteractive = !isLoading && onPressed != null;

    // Determine colors based on variant
    Color contentColor;
    switch (variant) {
      case AppButtonVariant.primary:
        contentColor = colors.onPrimary;
        break;
      case AppButtonVariant.outlined:
        contentColor = colors.primary;
        break;
      case AppButtonVariant.ghost:
        contentColor = colors.primary;
        break;
      case AppButtonVariant.danger:
        contentColor = colors.onError;
        break;
    }

    final effectiveTextStyle = _textStyle(textTheme)?.copyWith(
      color: isInteractive ? contentColor : colors.onSurface.withValues(alpha: 0.38),
    );

    Widget content = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          IconTheme(
            data: IconThemeData(
              size: _iconSize,
              color: effectiveTextStyle?.color,
            ),
            child: leadingIcon!,
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(label, style: effectiveTextStyle),
        if (trailingIcon != null) ...[
          const SizedBox(width: AppSpacing.sm),
          IconTheme(
            data: IconThemeData(
              size: _iconSize,
              color: effectiveTextStyle?.color,
            ),
            child: trailingIcon!,
          ),
        ],
      ],
    );

    if (isLoading) {
      content = SizedBox(
        height: _loaderSize,
        width: _loaderSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(contentColor),
        ),
      );
    }

    Widget button;
    switch (variant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
            elevation: 0,
            padding: _padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: content,
        );
        break;

      case AppButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.primary,
            padding: _padding,
            side: BorderSide(
              color: isInteractive
                  ? colors.primary
                  : colors.outline.withValues(alpha: 0.3),
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: content,
        );
        break;

      case AppButtonVariant.ghost:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: colors.primary,
            padding: _padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: content,
        );
        break;

      case AppButtonVariant.danger:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: colors.onError,
            elevation: 0,
            padding: _padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: content,
        );
        break;
    }

    return SizedBox(
      height: _height,
      width: isFullWidth ? double.infinity : null,
      child: button,
    );
  }
}
