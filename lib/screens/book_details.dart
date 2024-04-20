import 'package:flutter/material.dart';
import 'package:wolne_lektury_client/screens/book_reader.dart';
import 'package:wolne_lektury_client/widgets/custom_elevated_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen(
      {super.key,
      required this.bookTitle,
      required this.author,
      this.description,
      required this.thumbnailUrl,
      required this.favorite,
      required this.fileUrl});

  final String bookTitle;
  final String author;
  final String? description;
  final String thumbnailUrl;
  final bool favorite;
  final String fileUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(bookTitle)
      // ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: thumbnailUrl.isNotEmpty
                ? getImageFromNetwork()
                : getPlaceholderImage(),
          ),
          Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    AnimatedTextKit(
                      isRepeatingAnimation: false,
                      displayFullTextOnTap: true,
                      animatedTexts: [
                        TypewriterAnimatedText(author,
                            textStyle: const TextStyle(
                                fontSize: 22.0, color: Colors.grey),
                            speed: const Duration(milliseconds: 70)),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      bookTitle,
                      style: const TextStyle(fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomElevatedButton(
                        buttonText: "czytaj",
                        backgroundColor: Colors.blueAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookReaderScreen(
                                      fileUrl: fileUrl, title: bookTitle)));
                        }),
                    CustomElevatedButton(
                        buttonText: "cofnij",
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget getPlaceholderImage() => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        child: Image.asset('assets/images/placeholder.png',
            width: 80, height: 80, fit: BoxFit.cover),
      );

  Widget getImageFromNetwork() => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Image.network(
          thumbnailUrl,
          fit: BoxFit.fitWidth,
        ),
      );
}
