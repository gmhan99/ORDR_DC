/// 게임 유닛 데이터를 관리하는 클래스
class GameUnit {
  final String id;
  final String name;
  final String tier; // 티어 (예: 전설, 히든, 일반 등)

  const GameUnit({
    required this.id,
    required this.name,
    required this.tier,
  });
}

/// 게임 유닛 데이터베이스
class GameUnitsDatabase {
  static const List<GameUnit> _units = [
    // 전설 유닛들
    GameUnit(id: 'unit_001', name: '레일리', tier: '전설'),
    GameUnit(id: 'unit_002', name: '마르코', tier: '전설'),
    GameUnit(id: 'unit_003', name: '센고쿠', tier: '전설'),
    GameUnit(id: 'unit_004', name: '스모커', tier: '전설'),
    GameUnit(id: 'unit_005', name: '시저', tier: '전설'),
    GameUnit(id: 'unit_006', name: '에이스', tier: '전설'),
    GameUnit(id: 'unit_007', name: '울티', tier: '전설'),
    GameUnit(id: 'unit_008', name: '쵸파', tier: '전설'),
    GameUnit(id: 'unit_009', name: '카르가라', tier: '전설'),
    GameUnit(id: 'unit_010', name: '크래커', tier: '전설'),
    GameUnit(id: 'unit_011', name: '킹', tier: '전설'),
    GameUnit(id: 'unit_012', name: '흰수염', tier: '전설'),
    GameUnit(id: 'unit_013', name: '히바리', tier: '전설'),
    GameUnit(id: 'unit_014', name: '드래곤', tier: '전설'),
    GameUnit(id: 'unit_015', name: '라분', tier: '전설'),
    GameUnit(id: 'unit_016', name: '바르톨로메오', tier: '전설'),
    GameUnit(id: 'unit_017', name: '샹크스', tier: '전설'),
    GameUnit(id: 'unit_018', name: '시키', tier: '전설'),
    GameUnit(id: 'unit_019', name: '쿠마', tier: '전설'),
    GameUnit(id: 'unit_020', name: '후지토라', tier: '전설'),
    GameUnit(id: 'unit_021', name: '나미', tier: '전설'),
    GameUnit(id: 'unit_022', name: '네코마무시', tier: '전설'),
    GameUnit(id: 'unit_023', name: '레이쥬', tier: '전설'),
    GameUnit(id: 'unit_024', name: '로브루치', tier: '전설'),
    GameUnit(id: 'unit_025', name: '로우', tier: '전설'),
    GameUnit(id: 'unit_026', name: '루피나이트메어', tier: '전설'),
    GameUnit(id: 'unit_027', name: '게코모리아', tier: '전설'),
    GameUnit(id: 'unit_028', name: '블랙마리아', tier: '전설'),
    GameUnit(id: 'unit_029', name: '상디', tier: '전설'),
    GameUnit(id: 'unit_030', name: '슈가', tier: '전설'),
    GameUnit(id: 'unit_031', name: '시노부', tier: '전설'),
    GameUnit(id: 'unit_032', name: '제파', tier: '전설'),
    GameUnit(id: 'unit_033', name: '조로', tier: '전설'),
    GameUnit(id: 'unit_034', name: '징베', tier: '전설'),
    GameUnit(id: 'unit_035', name: '코비', tier: '전설'),
    GameUnit(id: 'unit_036', name: '토키', tier: '전설'),
    GameUnit(id: 'unit_037', name: '마샬D티치', tier: '전설'),
    GameUnit(id: 'unit_038', name: '핸콕', tier: '전설'),

    // 히든 유닛들
    GameUnit(id: 'unit_039', name: '레베카', tier: '히든'),
    GameUnit(id: 'unit_040', name: '료쿠규', tier: '히든'),
    GameUnit(id: 'unit_041', name: '미호크', tier: '히든'),
    GameUnit(id: 'unit_042', name: '베르고', tier: '히든'),
    GameUnit(id: 'unit_043', name: '사보', tier: '히든'),
    GameUnit(id: 'unit_044', name: '킬러', tier: '히든'),
    GameUnit(id: 'unit_045', name: '봉쿠레', tier: '히든'),
    GameUnit(id: 'unit_046', name: '아오키지', tier: '히든'),
    GameUnit(id: 'unit_047', name: '이완코브', tier: '히든'),
    GameUnit(id: 'unit_048', name: '피셔타이거', tier: '히든'),
    GameUnit(id: 'unit_049', name: '류마', tier: '히든'),
    GameUnit(id: 'unit_050', name: '스튜시', tier: '히든'),
    GameUnit(id: 'unit_051', name: '시류', tier: '히든'),
    GameUnit(id: 'unit_052', name: '아카이누', tier: '히든'),
    GameUnit(id: 'unit_053', name: '캐럿', tier: '히든'),
    GameUnit(id: 'unit_054', name: '키쿠', tier: '히든'),
    GameUnit(id: 'unit_055', name: '레드포스호', tier: '히든'),
    GameUnit(id: 'unit_056', name: '모비딕호', tier: '히든'),
    GameUnit(id: 'unit_057', name: '반더데켄', tier: '히든'),
    GameUnit(id: 'unit_058', name: '발라티에', tier: '히든'),
    GameUnit(id: 'unit_059', name: '방주맥심', tier: '히든'),
    GameUnit(id: 'unit_060', name: '써니호', tier: '히든'),
    GameUnit(id: 'unit_061', name: '블랙마리아왜곡됨', tier: '히든'),
    GameUnit(id: 'unit_062', name: '코알라', tier: '히든'),
    GameUnit(id: 'unit_063', name: '퀸', tier: '히든'),
    GameUnit(id: 'unit_064', name: '페로나왜곡됨', tier: '히든'),

    // 초월 유닛들
    GameUnit(id: 'unit_065', name: '도플라밍고', tier: '초월'),
    GameUnit(id: 'unit_066', name: '로빈', tier: '초월'),
    GameUnit(id: 'unit_067', name: '료쿠규초월', tier: '초월'),
    GameUnit(id: 'unit_068', name: '루피초월', tier: '초월'),
    GameUnit(id: 'unit_069', name: '바질호킨스', tier: '초월'),
    GameUnit(id: 'unit_070', name: '보니', tier: '초월'),
    GameUnit(id: 'unit_071', name: '사보초월', tier: '초월'),
    GameUnit(id: 'unit_072', name: '야마토', tier: '초월'),
    GameUnit(id: 'unit_073', name: '우솝', tier: '초월'),
    GameUnit(id: 'unit_074', name: '조로', tier: '초월'),
    GameUnit(id: 'unit_075', name: '징베초월', tier: '초월'),
    GameUnit(id: 'unit_076', name: '쵸파초월', tier: '초월'),
    GameUnit(id: 'unit_077', name: '후지토라초월', tier: '초월'),
    GameUnit(id: 'unit_078', name: '검은수염초월', tier: '초월'),
    GameUnit(id: 'unit_079', name: '나미초월', tier: '초월'),
    GameUnit(id: 'unit_080', name: '로우초월', tier: '초월'),
    GameUnit(id: 'unit_081', name: '루치초월', tier: '초월'),
    GameUnit(id: 'unit_082', name: '스네이크맨', tier: '초월'),
    GameUnit(id: 'unit_083', name: '브룩', tier: '초월'),
    GameUnit(id: 'unit_084', name: '상디초월', tier: '초월'),
    GameUnit(id: 'unit_085', name: '샹크스초월', tier: '초월'),
    GameUnit(id: 'unit_086', name: '시라호시', tier: '초월'),
    GameUnit(id: 'unit_087', name: '아오키지초월', tier: '초월'),
    GameUnit(id: 'unit_088', name: '아카이누초월', tier: '초월'),
    GameUnit(id: 'unit_089', name: '코비초월', tier: '초월'),
    GameUnit(id: 'unit_090', name: '키드', tier: '초월'),
    GameUnit(id: 'unit_091', name: '키자루', tier: '초월'),
    GameUnit(id: 'unit_092', name: '타시기', tier: '초월'),
    GameUnit(id: 'unit_093', name: '프랑키', tier: '초월'),

    // 불멸 유닛들
    GameUnit(id: 'unit_094', name: '거프', tier: '불멸'),
    GameUnit(id: 'unit_095', name: '레일리불멸', tier: '불멸'),
    GameUnit(id: 'unit_096', name: '로져', tier: '불멸'),
    GameUnit(id: 'unit_097', name: '스코퍼가반', tier: '불멸'),
    GameUnit(id: 'unit_098', name: '카이도', tier: '불멸'),
    GameUnit(id: 'unit_099', name: '흰수염불멸', tier: '불멸'),
    GameUnit(id: 'unit_100', name: '드래곤불멸', tier: '불멸'),
    GameUnit(id: 'unit_101', name: '빅맘', tier: '불멸'),
    GameUnit(id: 'unit_102', name: '센고쿠불멸', tier: '불멸'),
    GameUnit(id: 'unit_103', name: '시키불멸', tier: '불멸'),
    GameUnit(id: 'unit_104', name: '제트불멸', tier: '불멸'),

    // 영원 유닛들
    GameUnit(id: 'unit_105', name: '니카', tier: '영원'),
    GameUnit(id: 'unit_106', name: '버기', tier: '영원'),
    GameUnit(id: 'unit_107', name: '카벤딧슈', tier: '영원'),
    GameUnit(id: 'unit_108', name: '류마영원', tier: '영원'),
    GameUnit(id: 'unit_109', name: '미호크', tier: '영원'),
    GameUnit(id: 'unit_110', name: '비비', tier: '영원'),
    GameUnit(id: 'unit_111', name: '에이스영원', tier: '영원'),
    GameUnit(id: 'unit_112', name: '오뎅', tier: '영원'),
    GameUnit(id: 'unit_113', name: '우타', tier: '영원'),
    GameUnit(id: 'unit_114', name: '핸콕영원', tier: '영원'),

    // 제한됨 유닛들
    GameUnit(id: 'unit_115', name: '레드필드', tier: '제한됨'),
    GameUnit(id: 'unit_116', name: '레베카제한', tier: '제한됨'),
    GameUnit(id: 'unit_117', name: '마르코제한', tier: '제한됨'),
    GameUnit(id: 'unit_118', name: '시노부제한', tier: '제한됨'),
    GameUnit(id: 'unit_119', name: '아인', tier: '제한됨'),
    GameUnit(id: 'unit_120', name: '알비다', tier: '제한됨'),
    GameUnit(id: 'unit_121', name: '에넬', tier: '제한됨'),
    GameUnit(id: 'unit_122', name: '카타쿠리', tier: '제한됨'),
    GameUnit(id: 'unit_123', name: '크로커다일', tier: '제한됨'),
    GameUnit(id: 'unit_124', name: '킹제한', tier: '제한됨'),
  ];

  /// 모든 유닛 반환
  static List<GameUnit> getAllUnits() {
    return List.unmodifiable(_units);
  }

  /// 티어별 유닛 반환
  static List<GameUnit> getUnitsByTier(String tier) {
    return _units.where((unit) => unit.tier == tier).toList();
  }



  /// ID로 특정 유닛 찾기
  static GameUnit? getUnitById(String id) {
    try {
      return _units.firstWhere((unit) => unit.id == id);
    } catch (e) {
      return null;
    }
  }

  /// 랜덤 유닛 선택
  static GameUnit getRandomUnit() {
    final random = DateTime.now().millisecondsSinceEpoch % _units.length;
    return _units[random];
  }

  /// 중복되지 않는 랜덤 유닛들 선택
  static List<GameUnit> getRandomUnits(int count) {
    if (count <= 0 || count > _units.length) {
      return [];
    }

    final List<GameUnit> availableUnits = List.from(_units);
    final List<GameUnit> selectedUnits = [];

    for (int i = 0; i < count; i++) {
      if (availableUnits.isEmpty) break;
      
      final random = DateTime.now().millisecondsSinceEpoch % availableUnits.length;
      selectedUnits.add(availableUnits.removeAt(random));
    }

    return selectedUnits;
  }

  /// 티어별 중복되지 않는 랜덤 유닛들 선택
  static List<GameUnit> getRandomUnitsByTier(String tier, int count) {
    final tierUnits = getUnitsByTier(tier);
    if (count <= 0 || count > tierUnits.length) {
      return [];
    }

    final List<GameUnit> availableUnits = List.from(tierUnits);
    final List<GameUnit> selectedUnits = [];

    for (int i = 0; i < count; i++) {
      if (availableUnits.isEmpty) break;
      
      final random = DateTime.now().millisecondsSinceEpoch % availableUnits.length;
      selectedUnits.add(availableUnits.removeAt(random));
    }

    return selectedUnits;
  }

  /// 사용 가능한 모든 티어 반환
  static List<String> getAllTiers() {
    return _units.map((unit) => unit.tier).toSet().toList();
  }



  /// 유닛 개수 반환
  static int getUnitCount() {
    return _units.length;
  }

  /// 티어별 유닛 개수 반환
  static Map<String, int> getUnitCountByTier() {
    final Map<String, int> counts = {};
    for (final unit in _units) {
      counts[unit.tier] = (counts[unit.tier] ?? 0) + 1;
    }
    return counts;
  }
}
