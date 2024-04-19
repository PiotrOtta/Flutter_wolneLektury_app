class BookDetailsDto {
  final String title;
  final String author;
  final String thumbnailUrl;
  final String fileUrl;

  BookDetailsDto({
    required this.title, 
    required this.author, 
    required this.thumbnailUrl,
    required this.fileUrl
  });

  static List<BookDetailsDto?> bookFavourites = [];

  factory BookDetailsDto.fromJson(Map<String, dynamic> json) {
    var href = json['href'];
    int lastSlashIndex = href.lastIndexOf('/');
    int secondLastSlashIndex = href.substring(0, lastSlashIndex).lastIndexOf('/');
    var fileName = href.substring(secondLastSlashIndex + 1, lastSlashIndex);

    return BookDetailsDto(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      thumbnailUrl: json['simple_thumb'] ?? '',
      fileUrl: "https://wolnelektury.pl/media/book/txt/$fileName.txt",
    );
  }
}
