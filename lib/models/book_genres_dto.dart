
class BookGenresDto {
  final String slug;

  BookGenresDto({
    required this.slug,
  });

  factory BookGenresDto.fromJson(Map<String, dynamic> json) {
    return BookGenresDto(
      slug: json['slug'] ?? '', 
      );
  }
  
}
