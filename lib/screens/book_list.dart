import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wolne_lektury_client/models/book_details_dto.dart';
import 'package:wolne_lektury_client/services/wolne_lektury_api_connector.dart';
import 'package:wolne_lektury_client/widgets/book_list_element.dart';
import 'package:wolne_lektury_client/widgets/search_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  static const _pageSize = 10;

  final PagingController<int, BookDetailsDto> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  int lastValue = 0;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = (await WolneLekturyApiConnector.fetchBooks(
              count: pageKey > 0 ? pageKey : 10))
          .sublist(lastValue);
      final isLastPage = newItems.length < _pageSize;
      lastValue = pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PagedListView<int, BookDetailsDto>(
          padding: const EdgeInsets.only(top: 60, bottom: 60),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<BookDetailsDto>(
            itemBuilder: (context, item, index) => BookListElement(
              author: item.author,
              bookTitle: item.title,
              thumbnailUrl: item.thumbnailUrl,
              fileUrl: item.fileUrl,
              favorite: BookDetailsDto.bookFavourites.firstWhere(
                          (element) => element?.title == item.title,
                          orElse: () => null) !=
                      null
                  ? true
                  : false,
            ),
          ),
        ),
        const CustomSearchBar(),
      ],
    );
  }
}
