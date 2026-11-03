import 'package:flutter/material.dart';
import '../../../../core/common/widgets/widgets.dart';
import '../../../../core/config/theme/app_spacing.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final colors = context.colors;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Welcome Card
          AppCard(
            child: Row(
              children: [
                const AppAvatar(
                  name: 'Astro User',
                  size: AppAvatarSize.lg,
                  isOnline: true,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Welcome Back!', style: text.titleMedium),
                          const SizedBox(width: AppSpacing.xs),
                          const AppBadge(
                            label: 'PRO',
                            variant: AppBadgeVariant.primary,
                            style: AppBadgeStyle.filled,
                            size: AppBadgeSize.sm,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Starter template is ready to build.',
                        style: text.bodySmall?.copyWith(
                          color: colors.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          Text('Quick Actions', style: text.titleMedium),
          const SizedBox(height: AppSpacing.sm),

          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Test Success',
                  size: AppButtonSize.md,
                  variant: AppButtonVariant.primary,
                  onPressed: () => context.showSuccessSnackBar(
                    'Operation executed successfully!',
                    title: 'Success',
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppButton(
                  label: 'Test Modal',
                  size: AppButtonSize.md,
                  variant: AppButtonVariant.outlined,
                  onPressed: () => context.showConfirmationDialog(
                    title: 'Confirm Action',
                    message: 'Do you want to proceed with this test dialog?',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          Text('Design System Tokens', style: text.titleMedium),
          const SizedBox(height: AppSpacing.sm),

          const Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              AppChip(label: 'Design System', selected: true),
              AppChip(label: 'Material 3'),
              AppChip(label: 'go_router'),
              AppChip(label: 'Dio Client'),
              AppChip(label: 'Tokens Ready'),
            ],
          ),
        ],
      ),
    );
  }
}
