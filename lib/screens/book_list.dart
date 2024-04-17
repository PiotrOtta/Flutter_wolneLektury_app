import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wolne_lektury_client/models/book_details_dto.dart';
import 'package:wolne_lektury_client/services/wolne_lektury_api_connector.dart';
import 'package:wolne_lektury_client/widgets/book_list_element.dart';
import 'package:wolne_lektury_client/widgets/search_bar.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<BookDetailsDto> books = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<BookDetailsDto> fetchedBooks =
          await WolneLekturyApiConnector.fetchBooks();

      setState(() {
        books = fetchedBooks;
      });
    } catch (e) {
      print('Error fetching books: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20.0),
        Expanded(
            child: Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(top: 60, bottom: 60),
              itemCount: books.length,
              itemBuilder: (context, index) {
                return BookListElement(
                  bookTitle: books[index].title,
                  thumbnailUrl: books[index].thumbnailUrl,
                );
              },
            ),
            const CustomSearchBar(),
          ],
        ))
        // const SizedBox(child: CustomSearchBar()),
      ],
    );
  }
}
