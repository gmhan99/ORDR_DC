import 'dart:math';

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

  /// 유닛을 Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tier': tier,
    };
  }

  /// Map에서 유닛 생성
  factory GameUnit.fromMap(Map<String, dynamic> map) {
    return GameUnit(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      tier: map['tier'] ?? '',
    );
  }

  @override
  String toString() {
    return 'GameUnit(id: $id, name: $name, tier: $tier)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GameUnit && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// 유닛 배열을 효율적으로 관리하는 클래스
class GameUnitsDatabase {
  // 유닛 데이터를 Map으로 관리 (ID로 빠른 접근)
  static final Map<String, GameUnit> _unitsMap = {};
  
  // 티어별 유닛 인덱스
  static final Map<String, List<String>> _tierIndex = {};
  
  // 유닛 배열 (순서 보장)
  static final List<GameUnit> _unitsList = [];

  /// 유닛 데이터 초기화
  static void _initializeUnits() {
    if (_unitsMap.isNotEmpty) return; // 이미 초기화됨

    final units = [
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

    // 배열과 Map에 유닛 추가
    for (final unit in units) {
      _unitsList.add(unit);
      _unitsMap[unit.id] = unit;
      
      // 인덱스 업데이트
      _tierIndex.putIfAbsent(unit.tier, () => []).add(unit.id);
    }
  }

  /// 모든 유닛 반환 (배열)
  static List<GameUnit> getAllUnits() {
    _initializeUnits();
    return List.unmodifiable(_unitsList);
  }

  /// 유닛 배열을 ID 배열로 변환
  static List<String> getUnitIds() {
    _initializeUnits();
    return _unitsList.map((unit) => unit.id).toList();
  }

  /// ID 배열을 유닛 배열로 변환
  static List<GameUnit> getUnitsByIds(List<String> ids) {
    _initializeUnits();
    return ids.map((id) => _unitsMap[id]).where((unit) => unit != null).cast<GameUnit>().toList();
  }

  /// 티어별 유닛 반환 (인덱스 사용)
  static List<GameUnit> getUnitsByTier(String tier) {
    _initializeUnits();
    final ids = _tierIndex[tier] ?? [];
    return getUnitsByIds(ids);
  }



  /// ID로 특정 유닛 찾기 (Map 사용으로 O(1) 접근)
  static GameUnit? getUnitById(String id) {
    _initializeUnits();
    return _unitsMap[id];
  }

  /// 배열에서 유닛 검색 (이름으로)
  static List<GameUnit> searchUnitsByName(String name) {
    _initializeUnits();
    return _unitsList.where((unit) => 
      unit.name.toLowerCase().contains(name.toLowerCase())
    ).toList();
  }

  /// 배열에서 유닛 필터링 (조건부)
  static List<GameUnit> filterUnits(bool Function(GameUnit) condition) {
    _initializeUnits();
    return _unitsList.where(condition).toList();
  }

  /// 배열 정렬 (이름 기준)
  static List<GameUnit> getUnitsSortedByName({bool ascending = true}) {
    _initializeUnits();
    final sorted = List<GameUnit>.from(_unitsList);
    sorted.sort((a, b) => ascending 
      ? a.name.compareTo(b.name)
      : b.name.compareTo(a.name)
    );
    return sorted;
  }

  /// 랜덤 유닛 선택 (배열 인덱스 사용)
  static GameUnit getRandomUnit() {
    _initializeUnits();
    final random = Random();
    return _unitsList[random.nextInt(_unitsList.length)];
  }

  /// 중복되지 않는 랜덤 유닛들 선택 (배열 셔플)
  static List<GameUnit> getRandomUnits(int count) {
    _initializeUnits();
    if (count <= 0 || count > _unitsList.length) {
      return [];
    }

    final shuffled = List<GameUnit>.from(_unitsList);
    shuffled.shuffle(Random());
    return shuffled.take(count).toList();
  }

  /// 티어별 중복되지 않는 랜덤 유닛들 선택
  static List<GameUnit> getRandomUnitsByTier(String tier, int count) {
    final tierUnits = getUnitsByTier(tier);
    if (count <= 0 || count > tierUnits.length) {
      return [];
    }

    final shuffled = List<GameUnit>.from(tierUnits);
    shuffled.shuffle(Random());
    return shuffled.take(count).toList();
  }

  /// 배열 슬라이싱 (범위 선택)
  static List<GameUnit> getUnitsInRange(int start, int end) {
    _initializeUnits();
    if (start < 0 || end > _unitsList.length || start >= end) {
      return [];
    }
    return _unitsList.sublist(start, end);
  }

  /// 배열에서 처음 N개 유닛
  static List<GameUnit> getFirstUnits(int count) {
    _initializeUnits();
    return _unitsList.take(count).toList();
  }

  /// 배열에서 마지막 N개 유닛
  static List<GameUnit> getLastUnits(int count) {
    _initializeUnits();
    return _unitsList.reversed.take(count).toList();
  }

  /// 사용 가능한 모든 티어 반환
  static List<String> getAllTiers() {
    _initializeUnits();
    return _tierIndex.keys.toList();
  }



  /// 유닛 개수 반환
  static int getUnitCount() {
    _initializeUnits();
    return _unitsList.length;
  }

  /// 티어별 유닛 개수 반환
  static Map<String, int> getUnitCountByTier() {
    _initializeUnits();
    return _tierIndex.map((tier, ids) => MapEntry(tier, ids.length));
  }



  /// 배열 통계 정보
  static Map<String, dynamic> getArrayStats() {
    _initializeUnits();
    return {
      'totalUnits': _unitsList.length,
      'tierCounts': getUnitCountByTier(),
    };
  }

  /// 배열을 JSON으로 변환
  static List<Map<String, dynamic>> toJson() {
    _initializeUnits();
    return _unitsList.map((unit) => unit.toMap()).toList();
  }

  /// JSON에서 배열 복원
  static void fromJson(List<Map<String, dynamic>> json) {
    _unitsList.clear();
    _unitsMap.clear();
    _tierIndex.clear();

    for (final data in json) {
      final unit = GameUnit.fromMap(data);
      _unitsList.add(unit);
      _unitsMap[unit.id] = unit;
      _tierIndex.putIfAbsent(unit.tier, () => []).add(unit.id);
    }
  }
}
