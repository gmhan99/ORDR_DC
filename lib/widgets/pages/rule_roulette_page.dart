import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ordr_dc/l10n/app_localizations.dart';

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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.rule_roulette_title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    locale.rule_roulette_description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Button(
                    onPressed: () {
                      // 룰렛 돌리기 기능 구현
                      print('규칙 룰렛 돌리기: 랜덤 규칙이 선택되었습니다!');
                    },
                    child: Text(locale.rule_roulette_button),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
