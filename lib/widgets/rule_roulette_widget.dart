import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ordr_dc/data/game_rules.dart';

/// 룰렛 상태를 관리하는 Provider
final rouletteStateProvider = StateProvider<RouletteState>((ref) => RouletteState.idle);

/// 룰렛 상태 열거형
enum RouletteState {
  idle,      // 대기 상태
  spinning,  // 돌리는 중
  result,    // 결과 표시
}

/// 선택된 규칙을 관리하는 Provider
final selectedRuleProvider = StateProvider<GameRule?>((ref) => null);

/// 규칙 룰렛 위젯
class RuleRouletteWidget extends ConsumerWidget {
  const RuleRouletteWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rouletteState = ref.watch(rouletteStateProvider);
    final selectedRule = ref.watch(selectedRuleProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 룰렛 제목
            Text(
              '규칙 룰렛',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // 룰렛 영역
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 4,
                ),
                color: Colors.blue.withOpacity(0.1),
              ),
              child: Center(
                child: _buildRouletteContent(rouletteState, selectedRule),
              ),
            ),
            const SizedBox(height: 24),
            
            // 룰렛 버튼
            _buildRouletteButton(ref, rouletteState),
            const SizedBox(height: 16),
            
            // 결과 표시 영역
            if (rouletteState == RouletteState.result && selectedRule != null)
              _buildResultCard(selectedRule),
          ],
        ),
      ),
    );
  }

  /// 룰렛 내용 구성
  Widget _buildRouletteContent(RouletteState state, GameRule? selectedRule) {
    switch (state) {
      case RouletteState.idle:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FluentIcons.game,
              size: 48,
              color: Colors.blue,
            ),
            const SizedBox(height: 8),
            Text(
              '룰렛을 돌려보세요!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        );
      
      case RouletteState.spinning:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: ProgressRing(
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '룰렛 돌리는 중...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        );
      
      case RouletteState.result:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FluentIcons.accept,
              size: 48,
              color: Colors.green,
            ),
            const SizedBox(height: 8),
            Text(
              '결과!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        );
    }
  }

  /// 룰렛 버튼 구성
  Widget _buildRouletteButton(WidgetRef ref, RouletteState state) {
    return SizedBox(
      width: 200,
      child: Button(
        onPressed: state == RouletteState.spinning ? null : () => _spinRoulette(ref),
        style: ButtonStyle(
          backgroundColor: ButtonState.all(
            state == RouletteState.spinning 
              ? Colors.grey.withOpacity(0.3)
              : Colors.blue,
          ),
        ),
        child: Text(
          state == RouletteState.spinning 
            ? '룰렛 돌리는 중...'
            : state == RouletteState.result
              ? '다시 돌리기'
              : '룰렛 돌리기',
          style: TextStyle(
            color: state == RouletteState.spinning 
              ? Colors.grey
              : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// 결과 카드 구성
  Widget _buildResultCard(GameRule selectedRule) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  FluentIcons.trophy,
                  color: Colors.orange,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '선택된 규칙',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              selectedRule.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            if (selectedRule.description.isNotEmpty)
              Text(
                selectedRule.description,
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

  /// 룰렛 돌리기 함수
  void _spinRoulette(WidgetRef ref) {
    // 룰렛 상태를 돌리는 중으로 변경
    ref.read(rouletteStateProvider.notifier).state = RouletteState.spinning;
    
    // 2초 후 결과 표시
    Future.delayed(const Duration(seconds: 2), () {
      // 랜덤 규칙 선택
      final randomRule = GameRulesDatabase.getRandomRule();
      
      // 선택된 규칙 설정
      ref.read(selectedRuleProvider.notifier).state = randomRule;
      
      // 룰렛 상태를 결과로 변경
      ref.read(rouletteStateProvider.notifier).state = RouletteState.result;
    });
  }
}
