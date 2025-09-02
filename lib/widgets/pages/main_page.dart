import 'package:fluent_ui/fluent_ui.dart';
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

    return Layout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 좌측 사이드바
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                right: BorderSide(
                  color: Colors.grey[200],
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 앱 제목
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Row(
                      children: [
                        Icon(
                          FluentIcons.playlist_music,
                          size: 32,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'ORDR DC',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 네비게이션 버튼들
                  const SideBar(),
                ],
              ),
            ),
          ),
          // 메인 콘텐츠 영역
          Expanded(
            child: _buildPageContent(selectedPage),
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
          Row(
            children: [
              Icon(
                FluentIcons.home,
                size: 32,
                color: Colors.blue,
              ),
              const SizedBox(width: 16),
              Text(
                locale.side_button_home,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // 환영 메시지 카드
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORDR DC Season 2에 오신 것을 환영합니다!',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '좌측 메뉴에서 원하는 기능을 선택하여 사용하실 수 있습니다.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 기능 소개 카드들
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeatureCard(
                          icon: FluentIcons.game,
                          title: '규칙 룰렛',
                          description: '게임 규칙을 랜덤하게 선택',
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildFeatureCard(
                          icon: FluentIcons.game,
                          title: '기물 룰렛',
                          description: '게임 기물을 랜덤하게 선택',
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildFeatureCard(
                          icon: FluentIcons.settings,
                          title: '설정',
                          description: '애플리케이션 설정 관리',
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
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}