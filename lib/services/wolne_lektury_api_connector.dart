import 'package:wolne_lektury_client/models/book_collections_dto.dart';
import 'package:wolne_lektury_client/models/book_details_dto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wolne_lektury_client/models/book_epochs_dto.dart';
import 'package:wolne_lektury_client/models/book_genres_dto.dart';
import 'package:wolne_lektury_client/models/book_kinds_dto.dart';
import 'package:wolne_lektury_client/models/book_themes_dto.dart';

class WolneLekturyApiConnector {

    static const String baseUrl = 'https://wolnelektury.pl/api';

  static Future<List<BookDetailsDto>> fetchBooks({int count = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl/books/?count=$count'));
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

  static Future<List<BookThemesDto>> fetchBookThemes() async {
    final response = await http.get(Uri.parse('$baseUrl/themes/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => BookThemesDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load book themes');
    }
  }

  static Future<List<BookCollectionsDto>> fetchBookCollections() async {
    final response = await http.get(Uri.parse('$baseUrl/collections/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => BookCollectionsDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load book collections');
    }
  }
}
