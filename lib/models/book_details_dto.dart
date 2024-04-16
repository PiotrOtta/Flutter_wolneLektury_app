
class BookDetailsDto {
  final String title;
  final String author;

  BookDetailsDto({
    required this.title,
    required this.author
  });

  factory BookDetailsDto.fromJson(Map<String, dynamic> json) {
    return BookDetailsDto(
      title: json['title'] ?? '', 
      author: json['author'] ?? '',
      );
  }
  
}
