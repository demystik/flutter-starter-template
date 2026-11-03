import 'package:flutter/material.dart';
import '../../config/theme/app_spacing.dart';

enum AppIconButtonVariant {
  ghost,
  filled,
  filledTonal,
  outlined,
}

enum AppIconButtonSize {
  sm,
  md,
  lg,
}

enum AppIconButtonShape {
  circle,
  rounded,
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = AppIconButtonVariant.ghost,
    this.size = AppIconButtonSize.md,
    this.shape = AppIconButtonShape.rounded,
    this.tooltip,
    this.isLoading = false,
    this.color,
    this.backgroundColor,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final AppIconButtonSize size;
  final AppIconButtonShape shape;
  final String? tooltip;
  final bool isLoading;
  final Color? color;
  final Color? backgroundColor;

  double get _dimension {
    switch (size) {
      case AppIconButtonSize.sm:
        return 32;
      case AppIconButtonSize.md:
        return 40;
      case AppIconButtonSize.lg:
        return 48;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppIconButtonSize.sm:
        return 16;
      case AppIconButtonSize.md:
        return 20;
      case AppIconButtonSize.lg:
        return 24;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isEnabled = onPressed != null && !isLoading;

    Color effectiveBgColor;
    Color effectiveFgColor;
    BorderSide border = BorderSide.none;

    switch (variant) {
      case AppIconButtonVariant.ghost:
        effectiveBgColor = backgroundColor ?? Colors.transparent;
        effectiveFgColor = color ?? colors.onSurface;
        break;

      case AppIconButtonVariant.filled:
        effectiveBgColor = backgroundColor ?? colors.primary;
        effectiveFgColor = color ?? colors.onPrimary;
        break;

      case AppIconButtonVariant.filledTonal:
        effectiveBgColor = backgroundColor ??
            colors.surfaceContainerHighest.withValues(alpha: 0.6);
        effectiveFgColor = color ?? colors.onSurface;
        break;

      case AppIconButtonVariant.outlined:
        effectiveBgColor = backgroundColor ?? Colors.transparent;
        effectiveFgColor = color ?? colors.onSurface;
        border = BorderSide(
          color: colors.outline.withValues(alpha: 0.3),
          width: 1,
        );
        break;
    }

    if (!isEnabled) {
      effectiveFgColor = colors.onSurface.withValues(alpha: 0.38);
      if (variant == AppIconButtonVariant.filled) {
        effectiveBgColor = colors.onSurface.withValues(alpha: 0.12);
      }
    }

    final borderRadius = shape == AppIconButtonShape.circle
        ? BorderRadius.circular(AppRadius.full)
        : BorderRadius.circular(AppRadius.md);

    Widget content = SizedBox(
      width: _dimension,
      height: _dimension,
      child: Center(
        child: isLoading
            ? SizedBox(
                width: _iconSize,
                height: _iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveFgColor),
                ),
              )
            : IconTheme(
                data: IconThemeData(
                  size: _iconSize,
                  color: effectiveFgColor,
                ),
                child: icon,
              ),
      ),
    );

    Widget button = Material(
      color: effectiveBgColor,
      shape: shape == AppIconButtonShape.circle
          ? CircleBorder(side: border)
          : RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: border,
            ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        customBorder: shape == AppIconButtonShape.circle
            ? const CircleBorder()
            : RoundedRectangleBorder(borderRadius: borderRadius),
        child: content,
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
