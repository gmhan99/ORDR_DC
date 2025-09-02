import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ordr_dc/l10n/app_localizations.dart';
import 'package:ordr_dc/widgets/layout.dart';
import 'package:ordr_dc/widgets/side_bar.dart';
import 'package:ordr_dc/widgets/pages/rule_roulette_page.dart';
import 'package:ordr_dc/widgets/pages/unit_roulette_page.dart';
import 'package:ordr_dc/widgets/pages/settings_page.dart';
import 'package:ordr_dc/config/urls.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
 

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
                         onPressed: () => _openUrl(AppUrls.officialSite),
                       ),
                       const SizedBox(width: 16),
                       _buildTopLinkButton(
                         icon: FluentIcons.document,
                         label: locale.top_link_guide,
                         onPressed: () => _openUrl(AppUrls.guide),
                       ),
                       const SizedBox(width: 16),
                       _buildTopLinkButton(
                         icon: FluentIcons.git_graph,
                         label: locale.top_link_community,
                         onPressed: () => _openUrl(AppUrls.community),
                       ),
                    ],
                  ),
                  const Spacer(),
                  // 우측: 설정 버튼 + 종료 버튼
                  _buildSettingsButton(locale),
                  const SizedBox(width: 8),
                  _buildExitButton(locale),
                ],
              ),
            ),
          ),
          // ===== 하단 메인 영역 (좌측 사이드바 + 우측 콘텐츠) =====
          Expanded(
            child: Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                // ===== 좌측 사이드바 영역 =====
                Consumer(
                  builder: (context, ref, child) {
                    final isCollapsed = ref.watch(sidebarCollapsedProvider);
                    return AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        width: isCollapsed ? 80 : 260,
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
                    );
                  },
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
              // 프로그램 종료 (데스크톱 환경)
              exit(0);
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

  // 설정 버튼
  Widget _buildSettingsButton(AppLocalizations locale) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Button(
        onPressed: () {
          _showSettingsDialog(locale);
        },
        style: ButtonStyle(
          backgroundColor: ButtonState.all(Colors.transparent),
          padding: ButtonState.all(EdgeInsets.zero),
        ),
        child: Icon(
          FluentIcons.settings,
          size: 20,
          color: Colors.grey.withOpacity(0.7),
        ),
      ),
    );
  }

  // 설정 다이얼로그 표시
  void _showSettingsDialog(AppLocalizations locale) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(locale.settings_title),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 언어 설정
              Text(
                locale.settings_language_title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                locale.settings_language_subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 16),
              
              // 테마 설정
              Text(
                locale.settings_theme_title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                locale.settings_theme_subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 16),
              
              // 앱 정보
              Text(
                locale.settings_info_title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                locale.settings_info_subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Button(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(locale.exit_dialog_cancel),
          ),
        ],
      ),
    );
  }

  // URL 열기 함수
  Future<void> _openUrl(String url) async {
    if (AppUrls.isValidUrl(url)) {
      try {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          print('URL을 열 수 없습니다: $url');
        }
      } catch (e) {
        print('URL 열기 오류: $e');
      }
    } else {
      print('유효하지 않은 URL: $url');
    }
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