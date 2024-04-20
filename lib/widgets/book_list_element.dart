import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'dart:convert';

import 'package:wolne_lektury_client/models/book_details_dto.dart';
import 'package:wolne_lektury_client/screens/book_details.dart';

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

class BookListElement extends StatefulWidget {
  BookListElement(
      {super.key,
      required this.bookTitle,
      required this.thumbnailUrl,
      required this.author,
      required this.fileUrl,
      this.description,
      this.favorite = false});

  final String bookTitle;
  final String? description;
  final String thumbnailUrl;
  final String author;
  final String fileUrl;
  bool favorite;

  @override
  State<BookListElement> createState() => _BookListElementState();
}

class _BookListElementState extends State<BookListElement>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  dispose() {
    _controller.dispose(); // Bez tego śmierć :)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = widget.favorite ? Colors.red : Colors.black;
    return InkWell(
        onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookDetailsScreen(
                            author: widget.author,
                            bookTitle: widget.bookTitle,
                            thumbnailUrl: widget.thumbnailUrl,
                            favorite: widget.favorite,
                            fileUrl: widget.fileUrl,
                          )))
            },
        onHover: (value) => {
              setState(() {
                isAnimating = value;
              }),
              if (value) {_controller.forward()} else {_controller.reverse()}
            },
        child: Container(
          margin: const EdgeInsets.only(top: 6, bottom: 6, left: 20, right: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: const Color.fromARGB(255, 244, 244, 244)),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 4, top: 4, left: 16, right: 16),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
                  width: 90,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 210, 210, 210),
                        spreadRadius: 0.6,
                        blurRadius: 8,
                        offset: Offset(0, 0), // Shadow position
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: widget.thumbnailUrl
                            .isNotEmpty // Sprawdzasz, czy URL obrazka nie jest pusty
                        ? getBookWithCover(widget.thumbnailUrl)
                        : Image.asset(
                            'assets/images/placeholder.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Expanded(
                  /*1*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*2*/
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          widget.bookTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (widget.description?.isNotEmpty ?? false) ...[
                        Text(
                          widget.description!,
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                /*3*/
                GestureDetector(
                    onTap: () => {
                          setState(() {
                            BookDetailsDto? book = BookDetailsDto.bookFavourites
                                .firstWhere(
                                    (element) =>
                                        element?.title == widget.bookTitle,
                                    orElse: () => null);
                            if (BookDetailsDto.bookFavourites.isNotEmpty &&
                                book != null) {
                              BookDetailsDto.bookFavourites.remove(book);
                            } else {
                              BookDetailsDto.bookFavourites.add(BookDetailsDto(
                                  title: widget.bookTitle,
                                  author: widget.author,
                                  thumbnailUrl: widget.thumbnailUrl,
                                  fileUrl: widget.fileUrl));
                            }
                            widget.favorite = !widget.favorite;
                          })
                        },
                    child: AvatarGlow(
                      repeat: false,
                      animate: widget.favorite,
                      glowColor: Colors.red,
                      curve: Curves.ease,
                      glowRadiusFactor: 0.6,
                      glowCount: widget.favorite ? 1 : 0,
                      duration: widget.favorite
                          ? const Duration(milliseconds: 800)
                          : const Duration(milliseconds: 0),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: const BoxDecoration(
                                // color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            child: Icon(
                              widget.favorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: color,
                            ),
                          )),
                    ))
              ],
            ),
          ),
        ));
  }

  Widget getBookWithCover(thumbnailUrl) => Stack(
        children: [
          Positioned(
            left: 11,
            top: 4,
            child: RotationTransition(
              // turns: const AlwaysStoppedAnimation(6 / 360),
              turns: Tween(begin: 0.0, end: 2 / 360).animate(CurvedAnimation(
                  parent: _controller, curve: Curves.fastOutSlowIn)),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: AnimatedContainer(
                  height: 80,
                  width: isAnimating ? 62 : 60,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                ),
              ),
            ),
          ),
          Positioned(
            left: 9,
            top: 4,
            child: RotationTransition(
              // turns: const AlwaysStoppedAnimation(6 / 360),
              turns: Tween(begin: 0.0, end: 4 / 360).animate(CurvedAnimation(
                  parent: _controller, curve: Curves.fastOutSlowIn)),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: AnimatedContainer(
                  height: 80,
                  width: isAnimating ? 61 : 60,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 248, 225, 1),
                  ),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                ),
              ),
            ),
          ),
          RotationTransition(
              // turns: const AlwaysStoppedAnimation(6 / 360),
              turns: Tween(begin: 0.0, end: 6 / 360).animate(CurvedAnimation(
                  parent: _controller, curve: Curves.fastOutSlowIn)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedContainer(
                  height: 80,
                  width: isAnimating ? 56 : 60,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  child: Image.network(
                    thumbnailUrl,
                    width: 60,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
        ],
      );
}
