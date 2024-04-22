import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<StatefulWidget> createState() => _CustomSearchBarState();

}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> _suggestions = [];

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
          var bookTitles = jsonData.where((item) => item['type'] == "book").map((item) => item['label']);
          if (bookTitles.isNotEmpty) {
            setState(() {
              _suggestions = List<String>.from(bookTitles);
            });
          }
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
          return _suggestions.map((label) {
            return ListTile(
              title: Text(label),
              onTap: () {
                setState(() {
                  controller.closeView(label);
                });
              },
            );
          }).toList();
        },
      ),
    );
  }
}
