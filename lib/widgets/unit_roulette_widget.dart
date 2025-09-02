import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ordr_dc/data/game_units.dart';

/// 유닛 룰렛 상태를 관리하는 Provider
final unitRouletteStateProvider = StateProvider<UnitRouletteState>((ref) => UnitRouletteState.idle);

/// 유닛 룰렛 상태 열거형
enum UnitRouletteState {
  idle,      // 대기 상태
  spinning,  // 돌리는 중
  result,    // 결과 표시
}

/// 선택된 유닛들을 관리하는 Provider
final selectedUnitsProvider = StateProvider<List<GameUnit>>((ref) => []);

/// 뽑을 유닛 개수를 관리하는 Provider
final drawCountProvider = StateProvider<int>((ref) => 1);

/// 선택된 티어를 관리하는 Provider
final selectedTierProvider = StateProvider<String?>((ref) => null);

/// 이전 뽑기 결과를 관리하는 Provider
final previousUnitsProvider = StateProvider<List<GameUnit>>((ref) => []);

/// 유닛 룰렛 위젯
class UnitRouletteWidget extends ConsumerWidget {
  const UnitRouletteWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rouletteState = ref.watch(unitRouletteStateProvider);
    final selectedUnits = ref.watch(selectedUnitsProvider);
    final drawCount = ref.watch(drawCountProvider);
    final selectedTier = ref.watch(selectedTierProvider);

    // 화면 크기에 따른 동적 비율 계산
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // 화면 크기에 따른 flex 비율 조정
    int leftFlex, rightFlex;
    if (screenWidth < 1200) {
      // 작은 화면: 룰렛 영역을 더 작게
      leftFlex = 2;
      rightFlex = 3;
    } else if (screenWidth < 1600) {
      // 중간 화면: 균등한 비율
      leftFlex = 1;
      rightFlex = 1;
    } else {
      // 큰 화면: 룰렛 영역을 더 크게
      leftFlex = 3;
      rightFlex = 2;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 좌측: 룰렛 영역
        Expanded(
          flex: leftFlex,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 티어 선택기
                  _buildTierSelector(ref, selectedTier),
                  const SizedBox(height: 24),
                  
                  // 뽑을 개수 설정
                  _buildDrawCountSelector(ref, drawCount),
                  const SizedBox(height: 24),
                  
                                     // 룰렛 영역
                   Container(
                     width: screenWidth < 1200 ? 150 : (screenWidth < 1600 ? 200 : 250),
                     height: screenWidth < 1200 ? 150 : (screenWidth < 1600 ? 200 : 250),
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       border: Border.all(
                         color: Colors.green,
                         width: screenWidth < 1200 ? 3 : 4,
                       ),
                       color: Colors.green.withOpacity(0.1),
                     ),
                     child: Center(
                       child: _buildRouletteContent(rouletteState, selectedUnits),
                     ),
                   ),
                  const SizedBox(height: 24),
                  
                                     // 룰렛 버튼
                   _buildRouletteButton(ref, rouletteState, screenWidth),
                ],
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // 우측: 결과 표시 영역
        Expanded(
          flex: rightFlex,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   // 결과 표시 영역
                                       if (rouletteState == UnitRouletteState.result && selectedUnits.isNotEmpty)
                      _buildResultCard(context, selectedUnits)
                    else
                      _buildEmptyResultCard(),
                 ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 티어 선택기
  Widget _buildTierSelector(WidgetRef ref, String? selectedTier) {
    final tiers = ['전설', '히든', '초월', '불멸', '영원', '제한됨'];
    final tierShortNames = ['전', '히', '초', '불', '영', '제'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '티어 선택:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // 최상위 버튼
            _buildTierChip(
              '최상위',
              selectedTier == '최상위',
              () => ref.read(selectedTierProvider.notifier).state = '최상위',
            ),
            // 각 티어 버튼들
            ...tiers.asMap().entries.map((entry) {
              final index = entry.key;
              final tier = entry.value;
              final shortName = tierShortNames[index];
              return _buildTierChip(
                shortName,
                selectedTier == tier,
                () => ref.read(selectedTierProvider.notifier).state = tier,
              );
            }),
          ],
        ),
      ],
    );
  }

  /// 티어 칩 위젯
  Widget _buildTierChip(String shortName, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected 
            ? _getTierColorForShortName(shortName)
            : Colors.grey.withOpacity(0.1),
          border: Border.all(
            color: isSelected 
              ? _getTierColorForShortName(shortName)
              : Colors.grey.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          shortName,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

  /// 뽑을 개수 선택기
  Widget _buildDrawCountSelector(WidgetRef ref, int drawCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '뽑을 개수: ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Button(
          onPressed: drawCount > 1 ? () => ref.read(drawCountProvider.notifier).state = drawCount - 1 : null,
          child: const Text('-'),
        ),
        const SizedBox(width: 8),
        Container(
          width: 40,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              drawCount.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Button(
          onPressed: drawCount < 7 ? () => ref.read(drawCountProvider.notifier).state = drawCount + 1 : null,
          child: const Text('+'),
        ),
      ],
    );
  }

  /// 룰렛 내용 구성
  Widget _buildRouletteContent(UnitRouletteState state, List<GameUnit> selectedUnits) {
    switch (state) {
      case UnitRouletteState.idle:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FluentIcons.people,
              size: 48,
              color: Colors.green,
            ),
            const SizedBox(height: 8),
            Text(
              '유닛을 뽑아보세요!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        );
      
      case UnitRouletteState.spinning:
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
              '유닛 뽑는 중...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        );
      
      case UnitRouletteState.result:
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
              '${selectedUnits.length}개 뽑음!',
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
  Widget _buildRouletteButton(WidgetRef ref, UnitRouletteState state, double screenWidth) {
    final selectedTier = ref.watch(selectedTierProvider);
    
    String buttonText;
    if (state == UnitRouletteState.spinning) {
      buttonText = '유닛 뽑는 중...';
    } else if (state == UnitRouletteState.result) {
      buttonText = '다시 뽑기';
    } else {
      if (selectedTier == null) {
        buttonText = '유닛 뽑기';
      } else {
        buttonText = '${selectedTier} 뽑기';
      }
    }
    
         return SizedBox(
       width: screenWidth < 1200 ? 150 : (screenWidth < 1600 ? 200 : 250),
       child: Button(
        onPressed: state == UnitRouletteState.spinning ? null : () => _spinRoulette(ref),
        style: ButtonStyle(
          backgroundColor: ButtonState.all(
            state == UnitRouletteState.spinning 
              ? Colors.grey.withOpacity(0.3)
              : Colors.green,
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: state == UnitRouletteState.spinning 
              ? Colors.grey
              : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// 빈 결과 카드 구성
  Widget _buildEmptyResultCard() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FluentIcons.people,
              size: 48,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              '룰렛을 돌려서\n유닛을 뽑아보세요!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

    /// 결과 카드 구성
  Widget _buildResultCard(BuildContext context, List<GameUnit> selectedUnits) {
    // 화면 크기에 따른 동적 높이 계산
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // 유닛 개수에 따른 동적 높이 계산
    final unitCount = selectedUnits.length;
    final unitHeight = 80.0; // 각 유닛 항목의 실제 높이 (패딩 + 마진 포함)
    final padding = 24.0; // 패딩
    
    double calculatedHeight = (unitCount * unitHeight) + padding;
    
    double minHeight, maxHeight;
    if (screenWidth < 1200) {
      // 작은 화면: 더 작은 높이
      minHeight = 200;
      maxHeight = screenHeight * 0.7; // 화면 높이의 70%
    } else if (screenWidth < 1600) {
      // 중간 화면: 기본 높이
      minHeight = 270;
      maxHeight = screenHeight * 0.8; // 화면 높이의 80%
    } else {
      // 큰 화면: 더 큰 높이
      minHeight = 350;
      maxHeight = screenHeight * 0.9; // 화면 높이의 90%
    }
    
    // 계산된 높이가 최소 높이보다 작으면 최소 높이 사용
    if (calculatedHeight < minHeight) {
      calculatedHeight = minHeight;
    }
    
    // 계산된 높이가 최대 높이보다 크면 최대 높이 사용
    if (calculatedHeight > maxHeight) {
      calculatedHeight = maxHeight;
    }
    
    return Container(
      width: double.infinity,
      height: calculatedHeight,
             child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            ...selectedUnits.asMap().entries.map((entry) {
              final index = entry.key;
              final unit = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getTierColor(unit.tier).withOpacity(0.1),
                  border: Border.all(
                    color: _getTierColor(unit.tier).withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getTierColor(unit.tier),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${unit.name}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _getTierColor(unit.tier),
                            ),
                          ),
                          Text(
                            unit.tier,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  /// 티어별 색상 반환
  Color _getTierColor(String tier) {
    switch (tier) {
      case '전설':
        return Colors.red;
      case '히든':
        return Colors.orange;
      case '초월':
        return Colors.green;
      case '불멸':
        return Colors.black;
      case '영원':
        return Colors.purple;
      case '제한됨':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  /// 티어 칩용 색상 반환
  Color _getTierColorForChip(String tier) {
    switch (tier) {
      case '전설':
        return Colors.red;
      case '히든':
        return Colors.orange;
      case '초월':
        return Colors.green;
      case '불멸':
        return Colors.black;
      case '영원':
        return Colors.purple;
      case '제한됨':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  /// 짧은 이름으로 티어 색상 반환
  Color _getTierColorForShortName(String shortName) {
    switch (shortName) {
      case '최상위':
        return Colors.blue;
      case '전':
        return Colors.red;
      case '히':
        return Colors.orange;
      case '초':
        return Colors.green;
      case '불':
        return Colors.black;
      case '영':
        return Colors.purple;
      case '제':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  /// 룰렛 돌리기 함수
  void _spinRoulette(WidgetRef ref) {
    final drawCount = ref.read(drawCountProvider);
    final selectedTier = ref.read(selectedTierProvider);
    
    // 룰렛 상태를 돌리는 중으로 변경
    ref.read(unitRouletteStateProvider.notifier).state = UnitRouletteState.spinning;
    
    // 2초 후 결과 표시
    Future.delayed(const Duration(seconds: 2), () {
      List<GameUnit> randomUnits;
      
      // 선택된 티어에 따라 유닛 선택
      if (selectedTier == null) {
        // 전체 유닛에서 랜덤 선택
        randomUnits = GameUnitsDatabase.getRandomUnits(drawCount);
      } else if (selectedTier == '최상위') {
        // 최상위 티어들(초월, 불멸, 영원, 제한됨)에서 랜덤 선택
        final topTierUnits = <GameUnit>[];
        topTierUnits.addAll(GameUnitsDatabase.getUnitsByTier('초월'));
        topTierUnits.addAll(GameUnitsDatabase.getUnitsByTier('불멸'));
        topTierUnits.addAll(GameUnitsDatabase.getUnitsByTier('영원'));
        topTierUnits.addAll(GameUnitsDatabase.getUnitsByTier('제한됨'));
        
        // 중복 없이 랜덤 선택
        topTierUnits.shuffle();
        randomUnits = topTierUnits.take(drawCount).toList();
      } else {
        // 특정 티어에서 랜덤 선택
        randomUnits = GameUnitsDatabase.getRandomUnitsByTier(selectedTier, drawCount);
      }
      
      // 이전 결과를 저장 (현재 결과가 있으면)
      final currentUnits = ref.read(selectedUnitsProvider);
      if (currentUnits.isNotEmpty) {
        ref.read(previousUnitsProvider.notifier).state = List.from(currentUnits);
      }
      
      // 선택된 유닛들 설정
      ref.read(selectedUnitsProvider.notifier).state = randomUnits;
      
      // 룰렛 상태를 결과로 변경
      ref.read(unitRouletteStateProvider.notifier).state = UnitRouletteState.result;
    });
  }
}
