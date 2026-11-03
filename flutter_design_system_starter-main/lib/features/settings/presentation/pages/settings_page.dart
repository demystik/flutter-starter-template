import 'package:flutter/material.dart';
import '../../../../core/common/widgets/widgets.dart';
import '../../../../core/config/theme/app_spacing.dart';
import '../../../../core/router/auth_notifier.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          AppCard(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.palette_outlined),
                  title: Text('Appearance'),
                  subtitle: Text('System default (light/dark mode)'),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.language_rounded),
                  title: Text('Language'),
                  subtitle: Text('English (US)'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout_rounded, color: Colors.red),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    authNotifier.logOut();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
