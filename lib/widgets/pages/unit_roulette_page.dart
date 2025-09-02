import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ordr_dc/l10n/app_localizations.dart';
import 'package:ordr_dc/widgets/unit_roulette_widget.dart';
import 'package:ordr_dc/data/game_units.dart';

class UnitRoulettePage extends ConsumerWidget {
  const UnitRoulettePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUnits = ref.watch(selectedUnitsProvider);
    final previousUnits = ref.watch(previousUnitsProvider);
    final rouletteState = ref.watch(unitRouletteStateProvider);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          // 메인 룰렛 위젯
          const Expanded(
            child: Center(
              child: UnitRouletteWidget(),
            ),
          ),
          
          // 이전 뽑기 결과 (하단)
          if (previousUnits.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        FluentIcons.history,
                        size: 16,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      const SizedBox(width: 8),
                                             Text(
                         '이전 뽑기 결과',
                         style: TextStyle(
                           fontSize: 14,
                           fontWeight: FontWeight.w500,
                           color: Colors.grey.withOpacity(0.7),
                         ),
                       ),
                    ],
                  ),
                  const SizedBox(height: 12),
                                     Wrap(
                     spacing: 8,
                     runSpacing: 8,
                     children: previousUnits.map((unit) => _buildRecentUnitChip(unit)).toList(),
                   ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecentUnitChip(GameUnit unit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getTierColor(unit.tier).withOpacity(0.1),
        border: Border.all(
          color: _getTierColor(unit.tier).withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _getTierColor(unit.tier),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            unit.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _getTierColor(unit.tier),
            ),
          ),
        ],
      ),
    );
  }

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
}
