
class BookCollectionsDto {
  final String title;

  BookCollectionsDto({
    required this.title,
  });

  factory BookCollectionsDto.fromJson(Map<String, dynamic> json) {
    return BookCollectionsDto(
      title: json['title'] ?? '', 
      );
  }
  
}
