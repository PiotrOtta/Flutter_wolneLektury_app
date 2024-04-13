import 'package:wolne_lektury_client/models/book_details_dto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WolneLekturyApiConnector {

    static const String baseUrl = 'https://wolnelektury.pl/api/books/';

  static Future<List<BookDetailsDto>> fetchBooks({int count = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl?count=$count'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => BookDetailsDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }  
}
