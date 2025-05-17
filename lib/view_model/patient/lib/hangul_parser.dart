const List<String> consnants = [
  'ㄱ',
  'ㄲ',
  'ㄴ',
  'ㄷ',
  'ㄸ',
  'ㄹ',
  'ㅁ',
  'ㅂ',
  'ㅃ',
  'ㅅ',
  'ㅆ',
  'ㅇ',
  'ㅈ',
  'ㅉ',
  'ㅊ',
  'ㅋ',
  'ㅌ',
  'ㅍ',
  'ㅎ',
];

String getInitialConsnant(String name) {
  if (name.isEmpty) return '';

  int initialConsnant = name.codeUnitAt(0) - 44032;
  if (initialConsnant < 0 || initialConsnant > 11171) return '';

  int consnantIndex = initialConsnant ~/ 588;
  return consnants[consnantIndex];
}
