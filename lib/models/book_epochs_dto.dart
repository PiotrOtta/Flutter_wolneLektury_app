
class BookEpochsDto {
  final String slug;

  BookEpochsDto({
    required this.slug,
  });

  factory BookEpochsDto.fromJson(Map<String, dynamic> json) {
    return BookEpochsDto(
      slug: json['slug'] ?? '', 
      );
  }
  
}
