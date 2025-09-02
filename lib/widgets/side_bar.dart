import 'package:fluent_ui/fluent_ui.dart';
import 'package:ordr_dc/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 현재 선택된 페이지를 관리하는 Provider
final selectedPageProvider = StateProvider<String>((ref) => 'home');

// 사이드바 축소/확장 상태를 관리하는 Provider
final sidebarCollapsedProvider = StateProvider<bool>((ref) => false);

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context);
    final selectedPage = ref.watch(selectedPageProvider);
    final isCollapsed = ref.watch(sidebarCollapsedProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNavButton(
          context: context,
          ref: ref,
          icon: FluentIcons.home,
          title: locale.side_button_home,
          pageId: 'home',
          isSelected: selectedPage == 'home',
          isCollapsed: isCollapsed,
        ),
        const SizedBox(height: 4),
        _buildNavButton(
          context: context,
          ref: ref,
          icon: FluentIcons.game,
          title: locale.side_button_roulette_rule,
          pageId: 'rule_roulette',
          isSelected: selectedPage == 'rule_roulette',
          isCollapsed: isCollapsed,
        ),
        const SizedBox(height: 4),
        _buildNavButton(
          context: context,
          ref: ref,
          icon: FluentIcons.game,
          title: locale.side_button_roulette_unit,
          pageId: 'unit_roulette',
          isSelected: selectedPage == 'unit_roulette',
          isCollapsed: isCollapsed,
        ),
        const SizedBox(height: 4),
        _buildNavButton(
          context: context,
          ref: ref,
          icon: FluentIcons.settings,
          title: locale.side_button_settings,
          pageId: 'settings',
          isSelected: selectedPage == 'settings',
          isCollapsed: isCollapsed,
        ),
      ],
    );
  }

  Widget _buildNavButton({
    required BuildContext context,
    required WidgetRef ref,
    required IconData icon,
    required String title,
    required String pageId,
    required bool isSelected,
    required bool isCollapsed,
  }) {
    return SizedBox(
      width: isCollapsed ? 50 : double.infinity,
      height: 45,
      child: Button(
        onPressed: () {
          ref.read(selectedPageProvider.notifier).state = pageId;
        },
        style: ButtonStyle(
          backgroundColor: isSelected 
            ? ButtonState.all(Colors.blue.withOpacity(0.2))
            : ButtonState.all(Colors.transparent),
          padding: ButtonState.all(
            isCollapsed 
              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
              : const EdgeInsets.symmetric(horizontal: 12, vertical: 14)
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: isCollapsed ? 0 : 30),
          child: Row(
            mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: isCollapsed ? 24 : 20,
                color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.7),
              ),
              if (!isCollapsed) ...[
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.7),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
