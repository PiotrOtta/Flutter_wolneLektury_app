import 'package:flutter/material.dart';
import 'package:wolne_lektury_client/services/wolne_lektury_api_connector.dart';

class BookReaderScreen extends StatefulWidget {
  final String fileUrl;
  final String title;

  const BookReaderScreen(
      {super.key, required this.fileUrl, required this.title});

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  
  Future<String> _fetchTextFile() async {
  return await WolneLekturyApiConnector.fetchBookText(widget.fileUrl);
  }


  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<String>(
        future: _fetchTextFile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Scrollbar(
              controller: scrollController,
              child: ListView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.vertical,
                controller: scrollController,
                children: [
                  Text(
                    snapshot.data!,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
