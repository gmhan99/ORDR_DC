import 'package:fluent_ui/fluent_ui.dart';
import 'package:ordr_dc/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 현재 선택된 페이지를 관리하는 Provider
final selectedPageProvider = StateProvider<String>((ref) => 'home');

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context);
    final selectedPage = ref.watch(selectedPageProvider);

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
        ),
        const SizedBox(height: 8),
        _buildNavButton(
          context: context,
          ref: ref,
          icon: FluentIcons.game,
          title: locale.side_button_roulette_rule,
          pageId: 'rule_roulette',
          isSelected: selectedPage == 'rule_roulette',
        ),
        const SizedBox(height: 8),
        _buildNavButton(
          context: context,
          ref: ref,
          icon: FluentIcons.game,
          title: locale.side_button_roulette_unit,
          pageId: 'unit_roulette',
          isSelected: selectedPage == 'unit_roulette',
        ),
        const SizedBox(height: 8),
        _buildNavButton(
          context: context,
          ref: ref,
          icon: FluentIcons.settings,
          title: locale.side_button_settings,
          pageId: 'settings',
          isSelected: selectedPage == 'settings',
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
  }) {
    return SizedBox(
      width: double.infinity,
      child: Button(
        onPressed: () {
          ref.read(selectedPageProvider.notifier).state = pageId;
        },
        style: ButtonStyle(
          backgroundColor: isSelected 
            ? ButtonState.all(Colors.blue.withOpacity(0.2))
            : ButtonState.all(Colors.transparent),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.7),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.7),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
