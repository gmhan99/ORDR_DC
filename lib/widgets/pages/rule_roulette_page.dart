import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ordr_dc/l10n/app_localizations.dart';
import 'package:ordr_dc/widgets/rule_roulette_widget.dart';

class RuleRoulettePage extends ConsumerWidget {
  const RuleRoulettePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 페이지 제목
          Text(
            locale.rule_roulette_title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            locale.rule_roulette_description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 32),
          
          // 룰렛 위젯
          const Center(
            child: RuleRouletteWidget(),
          ),
        ],
      ),
    );
  }
}
