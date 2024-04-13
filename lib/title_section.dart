import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

class TitleSection extends StatefulWidget {
  const TitleSection(
      {super.key, required this.bookTitle, this.description, this.base64Image});
  final String bookTitle;
  final String? description;
  final String? base64Image;

  @override
  State<TitleSection> createState() => _TitleSectionGestureDetector();
}

class _TitleSectionGestureDetector extends State<TitleSection> {
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
        padding: const EdgeInsets.only(bottom: 16, top: 4, left: 16, right: 16),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 12, top: 6),
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
                child: Image.asset(
                  'assets/images/placeholder.png',
                  width: 80,
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
              child: Row(
                children: [
                  AvatarGlow(
                      repeat: false,
                      animate: _isFavourite,
                      glowColor: Colors.red,
                      curve: Curves.fastOutSlowIn,
                      glowRadiusFactor: 1.2,
                      glowCount: _isFavourite ? 1 : 0,
                      duration: _isFavourite
                          ? const Duration(milliseconds: 800)
                          : const Duration(milliseconds: 0),
                      child: Container(
                        decoration: const BoxDecoration(
                            // color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        child: Icon(
                          Icons.favorite,
                          color: color,
                        ),
                      )),
                  Container(
                    width: 6,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(_isFavourite ? '1' : '0',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: color,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
