import 'package:flutter/material.dart';
import '../../common/feedback/app_bottom_sheet.dart';
import '../../common/feedback/app_dialog.dart';
import '../../common/feedback/app_snack_bar.dart';

extension BuildContextThemeExtensions on BuildContext {
  /// Quick access to Theme
  ThemeData get theme => Theme.of(this);

  /// Quick access to ColorScheme
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Quick access to TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Check if current theme brightness is dark
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// Quick access to screen size
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
}

extension BuildContextFeedbackExtensions on BuildContext {
  /// Show success snackbar
  void showSuccessSnackBar(String message, {String? title}) {
    AppSnackBar.showSuccess(this, message, title: title);
  }

  /// Show error snackbar
  void showErrorSnackBar(String message, {String? title}) {
    AppSnackBar.showError(this, message, title: title);
  }

  /// Show warning snackbar
  void showWarningSnackBar(String message, {String? title}) {
    AppSnackBar.showWarning(this, message, title: title);
  }

  /// Show info snackbar
  void showInfoSnackBar(String message, {String? title}) {
    AppSnackBar.showInfo(this, message, title: title);
  }

  /// Show confirmation dialog
  Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) {
    return AppDialog.showConfirmation(
      this,
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      isDestructive: isDestructive,
    );
  }

  /// Show alert dialog
  Future<void> showAlertDialog({
    required String title,
    required String message,
    String buttonLabel = 'OK',
  }) {
    return AppDialog.showAlert(
      this,
      title: title,
      message: message,
      buttonLabel: buttonLabel,
    );
  }

  /// Show bottom sheet
  Future<T?> showAppBottomSheet<T>({
    required Widget child,
    String? title,
  }) {
    return AppBottomSheet.show<T>(
      this,
      title: title,
      child: child,
    );
  }
}
