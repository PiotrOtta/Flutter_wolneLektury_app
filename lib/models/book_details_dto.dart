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

  // decode response from the query like books/?count=10
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

  // decode response from the query like books/specifc-book-name
  factory BookDetailsDto.fromJsonDetailed(Map<String, dynamic> json) {
    List<dynamic> authors = json['authors'];
    String firstAuthorName = '';
    if (authors.isNotEmpty) {
      firstAuthorName = authors[0]['name'];
    }

    return BookDetailsDto(
      title: json['title'] ?? '',
      author: firstAuthorName,
      thumbnailUrl: json['simple_thumb'] ?? '',
      fileUrl: json['txt'],
    );
  }
}
