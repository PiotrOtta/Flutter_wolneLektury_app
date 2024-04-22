import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wolne_lektury_client/models/book_details_dto.dart';
import 'package:wolne_lektury_client/models/suggestion_dto.dart';
import 'package:wolne_lektury_client/screens/book_details.dart';
import 'package:wolne_lektury_client/services/wolne_lektury_api_connector.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<StatefulWidget> createState() => _CustomSearchBarState();

}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  List<SuggestionDto> _suggestions = [];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _getSuggestions(String query) async {
    if (query.isNotEmpty) {
      var uri = 'https://wolnelektury.pl/szukaj/hint/?max=10&term=${Uri.encodeFull(query)}';
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData != null && jsonData is List && jsonData.isNotEmpty) {
          var suggestions = jsonData.where((item) => item['type'] == "book").map((item) => SuggestionDto.fromJson(item));
          setState(() {
            _suggestions = List<SuggestionDto>.from(suggestions);
          });
        } else {
          setState(() {
            _suggestions = [];
          });
        }

      } else {
        throw Exception('Failed to load suggestions');
      }
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  Future<void> _switchToBookDetailsScreen(SuggestionDto suggestion) async {
    try {
      BookDetailsDto book = await _getBookDetails(suggestion);
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(
              bookTitle: book.title, 
              author: book.author, 
              thumbnailUrl: book.thumbnailUrl, 
              favorite: false, 
              fileUrl: book.fileUrl
            )
          )
        );
      }

    } catch (e) {
      print('Error fetching book: $e');
    }

  }

  Future<BookDetailsDto> _getBookDetails(SuggestionDto suggestion) async {
    return await WolneLekturyApiConnector.fetchBookByPathParam(pathParam: suggestion.extractLastPathParam());
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        viewOnChanged: (value) {
          _getSuggestions(value);
        },
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            // controller: _textEditingController,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onTap: () {
              controller.openView();
            },
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          return _suggestions.map((suggestion) {
            return ListTile(
              title: Text(suggestion.title),
              onTap: () {
                setState(() {
                  _switchToBookDetailsScreen(suggestion);
                });
              },
            );
          }).toList();
        },
      ),
    );
  }
}
