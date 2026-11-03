import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_spacing.dart';

enum AppAvatarSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

enum AppAvatarShape {
  circle,
  rounded,
}

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.image,
    this.name,
    this.fallbackIcon = Icons.person_rounded,
    this.size = AppAvatarSize.md,
    this.shape = AppAvatarShape.circle,
    this.isOnline,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String? imageUrl;
  final ImageProvider? image;
  final String? name;
  final IconData fallbackIcon;
  final AppAvatarSize size;
  final AppAvatarShape shape;
  final bool? isOnline;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;

  double get _dimension {
    switch (size) {
      case AppAvatarSize.xs:
        return 24;
      case AppAvatarSize.sm:
        return 32;
      case AppAvatarSize.md:
        return 40;
      case AppAvatarSize.lg:
        return 48;
      case AppAvatarSize.xl:
        return 64;
    }
  }

  double get _fontSize {
    switch (size) {
      case AppAvatarSize.xs:
        return 10;
      case AppAvatarSize.sm:
        return 12;
      case AppAvatarSize.md:
        return 14;
      case AppAvatarSize.lg:
        return 16;
      case AppAvatarSize.xl:
        return 22;
    }
  }

  double get _statusDotSize {
    switch (size) {
      case AppAvatarSize.xs:
        return 6;
      case AppAvatarSize.sm:
        return 8;
      case AppAvatarSize.md:
        return 10;
      case AppAvatarSize.lg:
        return 12;
      case AppAvatarSize.xl:
        return 14;
    }
  }

  String _getInitials(String input) {
    final parts = input.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts[0].isEmpty) return '';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final radius = shape == AppAvatarShape.circle
        ? BorderRadius.circular(AppRadius.full)
        : BorderRadius.circular(AppRadius.md);

    final bg = backgroundColor ??
        colors.primary.withValues(alpha: 0.12);
    final fg = foregroundColor ?? colors.primary;

    Widget avatarContent;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatarContent = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: _dimension,
        height: _dimension,
        errorBuilder: (context, error, stackTrace) => _buildFallback(fg),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              width: _dimension * 0.5,
              height: _dimension * 0.5,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(fg),
              ),
            ),
          );
        },
      );
    } else if (image != null) {
      avatarContent = Image(
        image: image!,
        fit: BoxFit.cover,
        width: _dimension,
        height: _dimension,
        errorBuilder: (context, error, stackTrace) => _buildFallback(fg),
      );
    } else {
      avatarContent = _buildFallback(fg);
    }

    Widget body = Container(
      width: _dimension,
      height: _dimension,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: radius,
      ),
      clipBehavior: Clip.antiAlias,
      child: Center(child: avatarContent),
    );

    if (onTap != null) {
      body = InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: body,
      );
    }

    if (isOnline != null) {
      final dotColor = isOnline! ? AppColors.success : colors.outline;
      body = Stack(
        clipBehavior: Clip.none,
        children: [
          body,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: _statusDotSize,
              height: _statusDotSize,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.surface,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return body;
  }

  Widget _buildFallback(Color fg) {
    if (name != null && name!.trim().isNotEmpty) {
      return Text(
        _getInitials(name!),
        style: TextStyle(
          color: fg,
          fontSize: _fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return Icon(
      fallbackIcon,
      size: _dimension * 0.55,
      color: fg,
    );
  }
}
