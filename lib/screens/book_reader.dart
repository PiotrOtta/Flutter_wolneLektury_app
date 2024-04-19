import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookReaderScreen extends StatefulWidget {
  final String fileUrl;
  final String title;

  const BookReaderScreen({super.key, required this.fileUrl, required this.title});

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  Future<String> _fetchTextFile() async {
    final response = await http.get(Uri.parse(widget.fileUrl));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load text file');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Scrollbar(
                child: ListView(
                  children: [
                    Text(
                      snapshot.data!,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}