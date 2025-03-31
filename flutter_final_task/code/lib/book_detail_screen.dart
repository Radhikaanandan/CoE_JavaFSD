import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book["title"] ?? "Book Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: book["imageLinks"] != null
                  ? Image.network(book["imageLinks"]["thumbnail"], height: 200)
                  : Icon(Icons.book, size: 100),
            ),
            SizedBox(height: 20),
            Text(
              book["title"] ?? "No Title",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              book["authors"] != null ? "By: ${book["authors"].join(", ")}" : "Author: Unknown",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10),
            Text(
              book["description"] ?? "No Description Available",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
