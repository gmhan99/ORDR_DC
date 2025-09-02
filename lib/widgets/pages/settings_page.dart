import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ordr_dc/l10n/app_localizations.dart';
import 'package:flutter/material.dart' as material;

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.settings_title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSettingItem(
                    icon: FluentIcons.translate,
                    title: locale.settings_language_title,
                    subtitle: locale.settings_language_subtitle,
                    onTap: () {
                      // 언어 설정 기능 구현 예정
                      print('언어 설정 클릭됨');
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    icon: FluentIcons.color,
                    title: locale.settings_theme_title,
                    subtitle: locale.settings_theme_subtitle,
                    onTap: () {
                      // 테마 설정 기능 구현 예정
                      print('테마 설정 클릭됨');
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    icon: FluentIcons.info,
                    title: locale.settings_info_title,
                    subtitle: locale.settings_info_subtitle,
                    onTap: () {
                      // 앱 정보 표시
                      print('앱 정보: ORDR DC Season 2 v1.0.0');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return material.InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.grey.withOpacity(0.7),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              FluentIcons.chevron_right,
              size: 16,
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
