/// 앱에서 사용하는 URL 설정을 관리하는 클래스
class AppUrls {
  // 공식 사이트 URL
  static const String officialSite = 'https://ordr.co.kr/';
  
  // 가이드 URL
  static const String guide = 'https://ordr-dc.com/guide';
  
  // 커뮤니티 URL
  static const String community = 'https://ordr-dc.com/community';
  
  // URL 유효성 검사
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
  
  // 모든 URL 목록
  static List<String> getAllUrls() {
    return [officialSite, guide, community];
  }
}
