import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wolne_lektury_client/widgets/book_list_element.dart';
import 'package:wolne_lektury_client/widgets/search_bar.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 20.0),
      const SizedBox(child: CustomSearchBar()),
      Expanded(
        child: ListView(children: const [
          BookListElement(bookTitle: "Wiedźmin 1"),
          BookListElement(bookTitle: "Wiedźmin 2"),
          BookListElement(bookTitle: "Wiedźmin 3"),
        ]),
      )
    ]);
  }
}
