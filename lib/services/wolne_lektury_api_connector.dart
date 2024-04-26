import 'package:wolne_lektury_client/models/book_details_dto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wolne_lektury_client/models/book_epochs_dto.dart';
import 'package:wolne_lektury_client/models/book_genres_dto.dart';
import 'package:wolne_lektury_client/models/book_kinds_dto.dart';

class WolneLekturyApiConnector {

    static const String baseUrl = 'https://wolnelektury.pl/api';

  static Future<List<BookDetailsDto>> fetchBooks({int count = 10, String? selectedAuthor, String? selectedEpoch, String? selectedGenre, String? selectedKind}) async {
    String query = 'books/?count=$count';


    if(selectedAuthor != null && selectedAuthor.isNotEmpty){
      selectedAuthor = selectedAuthor.replaceAll(' ', '-');

      selectedAuthor = selectedAuthor.toLowerCase();

      selectedAuthor = selectedAuthor.replaceAll('ą', 'a');
      selectedAuthor = selectedAuthor.replaceAll('ć', 'c');
      selectedAuthor = selectedAuthor.replaceAll('ę', 'e');
      selectedAuthor = selectedAuthor.replaceAll('ł', 'l');
      selectedAuthor = selectedAuthor.replaceAll('ń', 'n');
      selectedAuthor = selectedAuthor.replaceAll('ó', 'o');
      selectedAuthor = selectedAuthor.replaceAll('ś', 's');
      selectedAuthor = selectedAuthor.replaceAll('ż', 'z');
      selectedAuthor = selectedAuthor.replaceAll('ź', 'z');

      query = 'authors/$selectedAuthor/$query';
    }
    
    if(selectedEpoch != null && selectedEpoch.isNotEmpty){
      query = 'epochs/$selectedEpoch/$query';
    }

    if(selectedGenre != null && selectedGenre.isNotEmpty){
      query = 'genres/$selectedGenre/$query';
    }

    if(selectedKind != null && selectedKind.isNotEmpty){
      query = 'kinds/$selectedKind/$query';
    }

      query = '$baseUrl/$query';

    final response = await http.get(Uri.parse(query));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => BookDetailsDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  static Future<BookDetailsDto> fetchBookByPathParam({required String pathParam}) async {
    final response = await http.get(Uri.parse('$baseUrl/books/$pathParam'));
    if (response.statusCode == 200) {
      dynamic data = json.decode(utf8.decode(response.bodyBytes));
      return BookDetailsDto.fromJsonDetailed(data);
    } else {
      throw Exception('Failed to load books');
    }
  }

  static Future<String> fetchBookText(String fileUrl) async {
    if (fileUrl.isEmpty) {
      return "Nie znaleziono książki w wersji tekstowej";
    } else {
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load text file');
      }
    }
  }

  static Future<List<BookEpochsDto>> fetchBookEpochs() async {
    final response = await http.get(Uri.parse('$baseUrl/epochs/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => BookEpochsDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load book epochs');
    }
  }

  static Future<List<BookGenresDto>> fetchBookGenres() async {
    final response = await http.get(Uri.parse('$baseUrl/genres/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => BookGenresDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load book genres');
    }
  }

  static Future<List<BookKindsDto>> fetchBookKinds() async {
    final response = await http.get(Uri.parse('$baseUrl/kinds/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => BookKindsDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load book kinds');
    }
  }

}
