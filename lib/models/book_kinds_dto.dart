
class BookKindsDto {
  final String slug;

  BookKindsDto({
    required this.slug,
  });

  factory BookKindsDto.fromJson(Map<String, dynamic> json) {
    return BookKindsDto(
      slug: json['slug'] ?? '', 
      );
  }
  
}
