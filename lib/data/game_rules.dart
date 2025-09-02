/// 게임 규칙 데이터를 관리하는 클래스
class GameRule {
  final String id;
  final String name;
  final String description;

  const GameRule({
    required this.id,
    required this.name,
    required this.description,
  });
}

/// 게임 규칙 데이터베이스
class GameRulesDatabase {
  static const List<GameRule> _rules = [
    GameRule(
      id: 'rule_001',
      name: '아이템깐부전',
      description: '아이템을 사용하는 상위 필수',
    ),
    GameRule(
      id: 'rule_002',
      name: '원딜전(악몽)',
      description: '악몽 난이도에서 1상위',
    ),
    GameRule(
      id: 'rule_003',
      name: '강원랜디',
      description: '먼가엄청많음',
    ),
    GameRule(
      id: 'rule_004',
      name: '4인강제상위전',
      description: '상위 한개 골라서 그거 가야댐',
    ),
    GameRule(
      id: 'rule_005',
      name: '꼭!가야할캐릭',
      description: '',
    ),
    GameRule(
      id: 'rule_006',
      name: '신세계보상치기',
      description: '말그대로',
    ),
    GameRule(
      id: 'rule_007',
      name: '지츠다이스룰',
      description: '상위 4개 골라서 주사위 굴린다음에 숫자 높은사람 순서대로 고르는거임',
    ),
    GameRule(
      id: 'rule_008',
      name: '변질된악몽',
      description: '말그대로',
    ),
    GameRule(
      id: 'rule_009',
      name: '너의상위는',
      description: '상위 0~4골라서 개수',
    ),
    GameRule(
      id: 'rule_010',
      name: '이유닛필수에요(4전설+4히든)',
      description: '말그대로',
    ),
    GameRule(
      id: 'rule_011',
      name: '이유닛금지에요(7전설+7히든)',
      description: '말그대로',
    ),
    GameRule(
      id: 'rule_012',
      name: '인생의고도전',
      description: '5 + 1~10 / 돈도박어쩌고 있었는데',
    ),
  ];

  /// 모든 규칙 반환
  static List<GameRule> getAllRules() {
    return List.unmodifiable(_rules);
  }

  /// 랜덤 규칙 선택
  static GameRule getRandomRule() {
    final random = DateTime.now().millisecondsSinceEpoch % _rules.length;
    return _rules[random];
  }
}
