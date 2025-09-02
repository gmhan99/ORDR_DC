import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ordr_dc/l10n/app_localizations.dart';
import 'package:ordr_dc/widgets/layout.dart';
import 'package:ordr_dc/widgets/side_bar.dart';
import 'package:ordr_dc/widgets/pages/rule_roulette_page.dart';
import 'package:ordr_dc/widgets/pages/unit_roulette_page.dart';
import 'package:ordr_dc/widgets/pages/settings_page.dart';
 

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(selectedPageProvider);
    final locale = AppLocalizations.of(context);

    return Layout(
      child: Column(
        children: [
          // ===== 상단 헤더 바 영역 =====
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  // 좌측: 사이드바 토글 버튼 + 앱 로고
                  Row(
                    children: [
                      // 사이드바 토글 버튼
                      _buildSidebarToggleButton(ref),
                      const SizedBox(width: 8),
                      Text(
                        locale.app_title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // 중앙: 링크 버튼들
                  Row(
                    children: [
                      _buildTopLinkButton(
                        icon: FluentIcons.link,
                        label: locale.top_link_official_site,
                        onPressed: () {
                          // 공식 사이트 링크
                          print('공식 사이트 클릭됨');
                        },
                      ),
                      const SizedBox(width: 16),
                      _buildTopLinkButton(
                        icon: FluentIcons.document,
                        label: locale.top_link_guide,
                        onPressed: () {
                          // 가이드 링크
                          print('가이드 클릭됨');
                        },
                      ),
                      const SizedBox(width: 16),
                      _buildTopLinkButton(
                        icon: FluentIcons.people,
                        label: locale.top_link_community,
                        onPressed: () {
                          // 커뮤니티 링크
                          print('커뮤니티 클릭됨');
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  // 우측: 종료 버튼
                  _buildExitButton(locale),
                ],
              ),
            ),
          ),
          // ===== 하단 메인 영역 (좌측 사이드바 + 우측 콘텐츠) =====
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== 좌측 사이드바 영역 =====
                Container(
                  width: ref.watch(sidebarCollapsedProvider) ? 80 : 288,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      right: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 네비게이션 메뉴 버튼들
                        const SideBar(),
                      ],
                    ),
                  ),
                ),
                // ===== 우측 메인 콘텐츠 영역 =====
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: _buildPageContent(selectedPage),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(String selectedPage) {
    switch (selectedPage) {
      case 'home':
        return _buildHomePage();
      case 'rule_roulette':
        return const RuleRoulettePage();
      case 'unit_roulette':
        return const UnitRoulettePage();
      case 'settings':
        return const SettingsPage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    final locale = AppLocalizations.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 환영 메시지 카드
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.welcome_title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    locale.welcome_description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 기능 소개 카드들
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeatureCard(
                          icon: FluentIcons.game,
                          title: locale.feature_rule_roulette_title,
                          description: locale.feature_rule_roulette_description,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildFeatureCard(
                          icon: FluentIcons.game,
                          title: locale.feature_unit_roulette_title,
                          description: locale.feature_unit_roulette_description,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildFeatureCard(
                          icon: FluentIcons.settings,
                          title: locale.feature_settings_title,
                          description: locale.feature_settings_description,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopLinkButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Button(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: ButtonState.all(Colors.transparent),
        padding: ButtonState.all(const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey.withOpacity(0.7),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExitButton(AppLocalizations locale) {
    return Button(
      onPressed: () => _showExitDialog(locale),
      style: ButtonStyle(
        backgroundColor: ButtonState.all(Colors.transparent),
        padding: ButtonState.all(const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FluentIcons.cancel,
            size: 16,
            color: Colors.red.withOpacity(0.8),
          ),
          const SizedBox(width: 6),
          Text(
            locale.exit_button,
            style: TextStyle(
              fontSize: 14,
              color: Colors.red.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showExitDialog(AppLocalizations locale) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(locale.exit_dialog_title),
        content: Text(locale.exit_dialog_content),
        actions: [
          Button(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(locale.exit_dialog_cancel),
          ),
          Button(
            onPressed: () {
              Navigator.of(context).pop();
              // 프로그램 종료
              SystemNavigator.pop();
            },
            style: ButtonStyle(
              backgroundColor: ButtonState.all(Colors.red),
            ),
            child: Text(
              locale.exit_dialog_confirm,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // 사이드바 토글 버튼
  Widget _buildSidebarToggleButton(WidgetRef ref) {
    final isCollapsed = ref.watch(sidebarCollapsedProvider);
    
    return SizedBox(
      width: 32,
      height: 32,
      child: Button(
        onPressed: () {
          ref.read(sidebarCollapsedProvider.notifier).state = !isCollapsed;
        },
        style: ButtonStyle(
          backgroundColor: ButtonState.all(Colors.transparent),
          padding: ButtonState.all(EdgeInsets.zero),
        ),
        child: Icon(
          isCollapsed ? FluentIcons.chevron_right : FluentIcons.chevron_left,
          size: 20,
          color: Colors.blue,
        ),
      ),
    );
  }
}