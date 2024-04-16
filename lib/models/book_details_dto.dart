
class BookDetailsDto {
  final String title;
  final String author;
  final String thumbnailUrl;

  BookDetailsDto({
    required this.title,
    required this.author,
    required this.thumbnailUrl
  });

  factory BookDetailsDto.fromJson(Map<String, dynamic> json) {
    return BookDetailsDto(
      title: json['title'] ?? '', 
      author: json['author'] ?? '',
      thumbnailUrl: json['simple_thumb'] ?? '',
      );
  }
  
}
