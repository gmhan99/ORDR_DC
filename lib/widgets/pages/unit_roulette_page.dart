import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ordr_dc/l10n/app_localizations.dart';

class UnitRoulettePage extends ConsumerWidget {
  const UnitRoulettePage({super.key});

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
                    '기물 룰렛',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '게임 기물을 랜덤하게 선택하는 룰렛입니다.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Button(
                    onPressed: () {
                      // 룰렛 돌리기 기능 구현
                      print('기물 룰렛 돌리기: 랜덤 기물이 선택되었습니다!');
                    },
                    child: const Text('룰렛 돌리기'),
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
