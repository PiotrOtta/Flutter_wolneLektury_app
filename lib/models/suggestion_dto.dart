class SuggestionDto {
  final String type;
  final String title;
  final String url;

  SuggestionDto({
    required this.type,
    required this.title,
    required this.url
  });

  factory SuggestionDto.fromJson(Map<String, dynamic> json) {

    return SuggestionDto(
      title: json['label'] ?? '',
      type: json['type'] ?? '',
      url: json['url'] ?? '',
    );
  }

  String getDirectUriString() {
    String uriPathParam = extractLastPathParam();
    return 'https://wolnelektury.pl/api/books/$uriPathParam';
  }


String extractLastPathParam() {
  List<String> parts = url.split('/');
  if (parts.isNotEmpty && parts.last.isEmpty) {
    parts.removeLast();
  }
  return parts.isNotEmpty ? parts.last : '';
}  

}
