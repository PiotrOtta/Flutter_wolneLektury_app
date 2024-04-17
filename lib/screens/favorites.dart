import 'package:flutter/material.dart';
import 'package:wolne_lektury_client/models/book_details_dto.dart';
import 'package:wolne_lektury_client/widgets/book_list_element.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Stack(
          children: [
            BookDetailsDto.bookFavourites.length == 0
                ? const Center(
                    child: Text("Nie dodałeś jeszcze ulubionych książek"),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 60),
                    itemCount: BookDetailsDto.bookFavourites.length,
                    itemBuilder: (context, index) {
                      return BookListElement(
                        bookTitle:
                            BookDetailsDto.bookFavourites[index]?.title ?? '',
                        thumbnailUrl: BookDetailsDto
                                .bookFavourites[index]?.thumbnailUrl ??
                            '',
                        favorite: true,
                      );
                    },
                  ),
          ],
        ))
        // const SizedBox(child: CustomSearchBar()),
      ],
    );
  }
}
