import 'package:ordr_dc/data/game_units_improved.dart';

/// 유닛 배열 관리 예제들
class ArrayManagementExamples {
  
  /// 1. 기본 배열 조작
  static void basicArrayOperations() {
    print('=== 기본 배열 조작 ===');
    
    // 모든 유닛 가져오기
    final allUnits = GameUnitsDatabase.getAllUnits();
    print('전체 유닛 개수: ${allUnits.length}');
    
    // 배열 슬라이싱
    final firstFive = GameUnitsDatabase.getFirstUnits(5);
    print('처음 5개 유닛: ${firstFive.map((u) => u.name).toList()}');
    
    // 배열 범위 선택
    final rangeUnits = GameUnitsDatabase.getUnitsInRange(5, 10);
    print('5-10번째 유닛: ${rangeUnits.map((u) => u.name).toList()}');
  }

  /// 2. 배열 필터링과 검색
  static void arrayFilteringAndSearch() {
    print('\n=== 배열 필터링과 검색 ===');
    
    // 이름으로 검색
    final searchResults = GameUnitsDatabase.searchUnitsByName('드래곤');
    print('드래곤 검색 결과: ${searchResults.map((u) => u.name).toList()}');
    
    // 티어별 필터링
    final legendaryUnits = GameUnitsDatabase.filterUnits((unit) => unit.tier == '전설');
    print('전설 유닛들: ${legendaryUnits.map((u) => u.name).toList()}');
    
    // 특정 티어들 필터링
    final highTierUnits = GameUnitsDatabase.filterUnits((unit) => 
        unit.tier == '전설' || unit.tier == '초월' || unit.tier == '불멸');
    print('고급 티어 유닛들: ${highTierUnits.map((u) => '${u.name}(${u.tier})').toList()}');
  }

  /// 3. 배열 정렬
  static void arraySorting() {
    print('\n=== 배열 정렬 ===');
    
    // 이름 기준 정렬 (오름차순)
    final sortedByName = GameUnitsDatabase.getUnitsSortedByName(ascending: true);
    print('이름 순 정렬 (상위 5개): ${sortedByName.take(5).map((u) => u.name).toList()}');
    
    // 이름 기준 정렬 (내림차순)
    final sortedByNameDesc = GameUnitsDatabase.getUnitsSortedByName(ascending: false);
    print('이름 역순 정렬 (상위 5개): ${sortedByNameDesc.take(5).map((u) => u.name).toList()}');
  }

  /// 4. 인덱스 기반 접근
  static void indexBasedAccess() {
    print('\n=== 인덱스 기반 접근 ===');
    
    // 티어별 유닛 (인덱스 사용)
    final legendaryUnits = GameUnitsDatabase.getUnitsByTier('전설');
    print('전설 유닛들: ${legendaryUnits.map((u) => u.name).toList()}');
    
    // 다른 티어별 유닛들
    final hiddenUnits = GameUnitsDatabase.getUnitsByTier('히든');
    print('히든 유닛들: ${hiddenUnits.map((u) => u.name).toList()}');
    
    // ID로 직접 접근 (Map 사용)
    final rayleigh = GameUnitsDatabase.getUnitById('unit_001');
    print('레일리 정보: $rayleigh');
  }

  /// 5. 랜덤 선택 (배열 셔플)
  static void randomSelection() {
    print('\n=== 랜덤 선택 ===');
    
    // 단일 랜덤 유닛
    final randomUnit = GameUnitsDatabase.getRandomUnit();
    print('랜덤 유닛: ${randomUnit.name}');
    
    // 중복 없는 랜덤 유닛들 (배열 셔플)
    final randomUnits = GameUnitsDatabase.getRandomUnits(3);
    print('랜덤 3개 유닛: ${randomUnits.map((u) => u.name).toList()}');
    
    // 티어별 랜덤 선택
    final randomLegendary = GameUnitsDatabase.getRandomUnitsByTier('전설', 2);
    print('랜덤 전설 유닛 2개: ${randomLegendary.map((u) => u.name).toList()}');
  }

  /// 6. 배열 통계
  static void arrayStatistics() {
    print('\n=== 배열 통계 ===');
    
    final stats = GameUnitsDatabase.getArrayStats();
    print('전체 통계: $stats');
    
    // 티어별 개수
    final tierCounts = GameUnitsDatabase.getUnitCountByTier();
    print('티어별 개수: $tierCounts');
    
    // 전체 유닛 개수
    final totalCount = GameUnitsDatabase.getUnitCount();
    print('전체 유닛 개수: $totalCount');
  }

  /// 7. 배열 변환
  static void arrayTransformation() {
    print('\n=== 배열 변환 ===');
    
    // ID 배열로 변환
    final unitIds = GameUnitsDatabase.getUnitIds();
    print('유닛 ID 배열: ${unitIds.take(5).toList()}...');
    
    // ID 배열을 유닛 배열로 변환
    final selectedIds = ['unit_001', 'unit_002', 'unit_003'];
    final selectedUnits = GameUnitsDatabase.getUnitsByIds(selectedIds);
    print('선택된 유닛들: ${selectedUnits.map((u) => u.name).toList()}');
    
    // JSON 변환
    final jsonData = GameUnitsDatabase.toJson();
    print('JSON 데이터 크기: ${jsonData.length}개 항목');
  }

  /// 8. 고급 배열 조작
  static void advancedArrayOperations() {
    print('\n=== 고급 배열 조작 ===');
    
    final allUnits = GameUnitsDatabase.getAllUnits();
    
    // 그룹화 (티어별)
    final groupedByTier = <String, List<GameUnit>>{};
    for (final unit in allUnits) {
      groupedByTier.putIfAbsent(unit.tier, () => []).add(unit);
    }
    print('티어별 그룹화: ${groupedByTier.map((k, v) => MapEntry(k, v.length))}');
    
    // 티어별 유닛 이름 목록
    final tierNames = <String, List<String>>{};
    for (final unit in allUnits) {
      tierNames.putIfAbsent(unit.tier, () => []).add(unit.name);
    }
    print('티어별 유닛 이름들: ${tierNames.map((k, v) => MapEntry(k, v.take(3).toList()))}');
    
    // 체이닝 (여러 조건 조합)
    final result = allUnits
        .where((unit) => unit.tier == '전설' || unit.tier == '초월' || unit.tier == '불멸')
        .where((unit) => unit.name.contains('초월'))
        .map((unit) => '${unit.name}(${unit.tier})')
        .toList();
    print('초월 관련 유닛들: $result');
  }

  /// 모든 예제 실행
  static void runAllExamples() {
    basicArrayOperations();
    arrayFilteringAndSearch();
    arraySorting();
    indexBasedAccess();
    randomSelection();
    arrayStatistics();
    arrayTransformation();
    advancedArrayOperations();
  }
}
