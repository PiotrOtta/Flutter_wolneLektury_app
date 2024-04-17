import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'dart:convert';

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

class BookListElement extends StatefulWidget {
  const BookListElement(
      {super.key,
      required this.bookTitle,
      required this.thumbnailUrl,
      this.description});

  final String bookTitle;
  final String? description;
  final String thumbnailUrl;

  @override
  State<BookListElement> createState() => _BookListElementState();
}

class _BookListElementState extends State<BookListElement> {
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    Color color = _isFavourite ? Colors.red : Colors.black;
    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 6, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromARGB(255, 244, 244, 244)),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4, top: 4, left: 16, right: 16),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 190, 190, 190),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(-2, 4), // Shadow position
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: widget.thumbnailUrl
                        .isNotEmpty // Sprawdzasz, czy URL obrazka nie jest pusty
                    ? Image.network(
                        widget.thumbnailUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      )
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
                  _isFavourite = !_isFavourite;
                })
              },
              child: AvatarGlow(
                  repeat: false,
                  animate: _isFavourite,
                  glowColor: Colors.red,
                  curve: Curves.ease,
                  glowRadiusFactor: 1.5,
                  glowCount: _isFavourite ? 1 : 0,
                  duration: _isFavourite
                      ? const Duration(milliseconds: 800)
                      : const Duration(milliseconds: 0),
                  child: Container(
                    decoration: const BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                    child: Icon(
                      _isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: color,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
