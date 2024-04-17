
class BookThemesDto {
  final String slug;

  BookThemesDto({
    required this.slug,
  });

  factory BookThemesDto.fromJson(Map<String, dynamic> json) {
    return BookThemesDto(
      slug: json['slug'] ?? '', 
      );
  }
  
}
