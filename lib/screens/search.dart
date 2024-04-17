import 'package:flutter/material.dart';
import 'package:wolne_lektury_client/models/book_collections_dto.dart';
import 'package:wolne_lektury_client/models/book_epochs_dto.dart';
import 'package:wolne_lektury_client/models/book_genres_dto.dart';
import 'package:wolne_lektury_client/models/book_kinds_dto.dart';
import 'package:wolne_lektury_client/models/book_themes_dto.dart';
import 'package:wolne_lektury_client/services/wolne_lektury_api_connector.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<String> bookEpoch = [];
  List<String> bookGenre = [];
  List<String> bookKind = [];
  List<String> booksTheme = [];
  List<String> booksCollection = [];
  
  @override
  void initState() {
    super.initState();
    fetchDropdownsData();
  }

  Future<void> fetchDropdownsData() async {
    try {
      List<BookEpochsDto> fetchedEpochs =
          await WolneLekturyApiConnector.fetchBookEpochs();

      List<BookGenresDto> fetchedGenres =
          await WolneLekturyApiConnector.fetchBookGenres();

      List<BookKindsDto> fetchedKinds =
          await WolneLekturyApiConnector.fetchBookKinds();

      List<BookThemesDto> fetchedThemes =
          await WolneLekturyApiConnector.fetchBookThemes();

      List<BookCollectionsDto> fetchedCollections =
          await WolneLekturyApiConnector.fetchBookCollections();

      setState(() {
        bookEpoch = fetchedEpochs.map((dto) => dto.slug).toList();
        bookGenre = fetchedGenres.map((dto) => dto.slug).toList();
        bookKind = fetchedKinds.map((dto) => dto.slug).toList();
        booksTheme = fetchedThemes.map((dto) => dto.slug).toList();
        booksCollection = fetchedCollections.map((dto) => dto.title).toList();
      });

    } catch (e) {
      print('Error fetching book search dropdowns: $e');
    }
  }
  
  List<DropdownMenuItem<String>> _buildDropdownItems(List<String> values) {
    return values.map((value) {
      return DropdownMenuItem(
        value: value,
        child: Text(value),
      );
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const Padding(
            padding:  EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Autor'),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Epoki'),
              items: _buildDropdownItems(bookEpoch),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Gatunek'),
              items: _buildDropdownItems(bookGenre),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Rodzaj'),
              items: _buildDropdownItems(bookKind),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Motyw i temat'),
              items: _buildDropdownItems(booksTheme),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Kolekcje'),
              items: _buildDropdownItems(booksCollection),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement filter action
                },
                child: const Text('Filter'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement reset action
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}