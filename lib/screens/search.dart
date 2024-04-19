import 'package:flutter/material.dart';
import 'package:wolne_lektury_client/models/book_collections_dto.dart';
import 'package:wolne_lektury_client/models/book_epochs_dto.dart';
import 'package:wolne_lektury_client/models/book_genres_dto.dart';
import 'package:wolne_lektury_client/models/book_kinds_dto.dart';
import 'package:wolne_lektury_client/models/book_themes_dto.dart';
import 'package:wolne_lektury_client/services/wolne_lektury_api_connector.dart';
import 'package:wolne_lektury_client/widgets/custom_elevated_button.dart';


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
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Autor',
                  fillColor: const Color.fromARGB(158, 235, 235, 235), // Ustawienie koloru tła pola Dropdown
                  filled: true, // Włączenie wypełnienia
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none, // Usunięcie zewnętrznej linii obramowania
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Epoki',
                fillColor: const Color.fromARGB(158, 235, 235, 235), // Ustawienie koloru tła pola Dropdown
                filled: true, // Włączenie wypełnienia
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none, // Usunięcie zewnętrznej linii obramowania
                ),
              ),
              items: _buildDropdownItems(bookEpoch),
              onChanged: (value) {},
              menuMaxHeight: 400,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Gatunek',
                fillColor: const Color.fromARGB(158, 235, 235, 235), // Ustawienie koloru tła pola Dropdown
                filled: true, // Włączenie wypełnienia
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none, // Usunięcie zewnętrznej linii obramowania
                ),
              ),
              items: _buildDropdownItems(bookGenre),
              onChanged: (value) {},
              menuMaxHeight: 400,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Rodzaj',
                fillColor: const Color.fromARGB(158, 235, 235, 235), // Ustawienie koloru tła pola Dropdown
                filled: true, // Włączenie wypełnienia
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none, // Usunięcie zewnętrznej linii obramowania
                ),
              ),
              items: _buildDropdownItems(bookKind),
              onChanged: (value) {},
              menuMaxHeight: 400,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Motyw i temat',
                fillColor: const Color.fromARGB(158, 235, 235, 235), // Ustawienie koloru tła pola Dropdown
                filled: true, // Włączenie wypełnienia
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none, // Usunięcie zewnętrznej linii obramowania
                ),
              ),
              items: _buildDropdownItems(booksTheme),
              onChanged: (value) {},
              menuMaxHeight: 400,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Kolekcje',
                fillColor: const Color.fromARGB(158, 235, 235, 235), // Ustawienie koloru tła pola Dropdown
                filled: true, // Włączenie wypełnienia
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none, // Usunięcie zewnętrznej linii obramowania
                ),
              ),
              items: _buildDropdownItems(booksCollection),
              onChanged: (value) {},
              menuMaxHeight: 400,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 32),
          CustomElevatedButton(
            buttonText: 'Filtruj',
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/navigation");
            },
          ),
          CustomElevatedButton(
            buttonText: 'Cofnij',
            onPressed: () {
            },
            backgroundColor: Colors.white,
            textColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}