import 'package:flutter/material.dart';
import 'package:wolne_lektury_client/models/book_epochs_dto.dart';
import 'package:wolne_lektury_client/models/book_genres_dto.dart';
import 'package:wolne_lektury_client/models/book_kinds_dto.dart';
import 'package:wolne_lektury_client/screens/navigation.dart';
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

      setState(() {
        bookEpoch = fetchedEpochs.map((dto) => dto.slug).toList();
        bookGenre = fetchedGenres.map((dto) => dto.slug).toList();
        bookKind = fetchedKinds.map((dto) => dto.slug).toList();
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
  String selectedAuthor = '';
  String selectedEpoch = '';
  String selectedGenre = '';
  String selectedKind = '';

    return SingleChildScrollView(
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
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
                onChanged: (value) 
                {
                  if(value.isNotEmpty){
                    selectedAuthor = value;
                  }
                },
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
                onChanged: (value) 
                {
                  if(value != null && value.isNotEmpty){
                    selectedEpoch = value;
                  }
                },
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
                onChanged: (value) 
                {
                  if(value != null && value.isNotEmpty){
                    selectedGenre = value;
                  }
                },
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
                onChanged: (value) 
                {
                  if(value != null && value.isNotEmpty){
                    selectedKind = value;
                  }
                },
                menuMaxHeight: 400,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 32),
            CustomElevatedButton(
              buttonText: 'Filtruj',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationScreen(
                      selectedAuthor: selectedAuthor,
                      selectedEpoch: selectedEpoch,
                      selectedGenre: selectedGenre,
                      selectedKind: selectedKind
                    ),
                  ),
                );
              },
            ),
            CustomElevatedButton(
              buttonText: 'Cofnij',
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/navigation");
              },
              backgroundColor: Colors.white,
              textColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}