import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_spacing.dart';

enum AppSnackBarVariant {
  success,
  error,
  warning,
  info,
}

abstract class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    AppSnackBarVariant variant = AppSnackBarVariant.info,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    Color bgColor;
    Color iconColor;
    IconData icon;

    switch (variant) {
      case AppSnackBarVariant.success:
        bgColor = AppColors.success;
        iconColor = Colors.white;
        icon = Icons.check_circle_rounded;
        break;
      case AppSnackBarVariant.error:
        bgColor = AppColors.error;
        iconColor = Colors.white;
        icon = Icons.error_rounded;
        break;
      case AppSnackBarVariant.warning:
        bgColor = AppColors.warning;
        iconColor = Colors.white;
        icon = Icons.warning_amber_rounded;
        break;
      case AppSnackBarVariant.info:
        bgColor = AppColors.grey900;
        iconColor = AppColors.primary;
        icon = Icons.info_rounded;
        break;
    }

    messenger.showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: bgColor,
        margin: const EdgeInsets.all(AppSpacing.md),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        action: action,
        content: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: AppSpacing.sm + 4),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) ...[
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message, {String? title}) {
    show(context, message: message, title: title, variant: AppSnackBarVariant.success);
  }

  static void showError(BuildContext context, String message, {String? title}) {
    show(context, message: message, title: title, variant: AppSnackBarVariant.error);
  }

  static void showWarning(BuildContext context, String message, {String? title}) {
    show(context, message: message, title: title, variant: AppSnackBarVariant.warning);
  }

  static void showInfo(BuildContext context, String message, {String? title}) {
    show(context, message: message, title: title, variant: AppSnackBarVariant.info);
  }
}
