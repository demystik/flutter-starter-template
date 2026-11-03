import 'package:flutter/material.dart';
import '../../../../core/common/widgets/widgets.dart';
import '../../../../core/config/theme/app_spacing.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final colors = context.colors;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const Center(
            child: AppAvatar(
              name: 'Astro User',
              size: AppAvatarSize.xl,
              isOnline: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Astro Developer', style: text.titleLarge),
          Text(
            'developer@example.com',
            style: text.bodyMedium?.copyWith(
              color: colors.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.shield_outlined),
                  title: const Text('Account Security'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.notifications_none_rounded),
                  title: const Text('Notifications'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
