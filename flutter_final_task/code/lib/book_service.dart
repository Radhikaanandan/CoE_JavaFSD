import 'dart:convert';
import 'package:http/http.dart' as http;
import 'book_model.dart';

class BookService {
  static const String apiKey = "AIzaSyD9HF5ZdLnsg3V0pfbFxwEfQkjiTdmWbvI";

  static Future<List<Book>> fetchBooks(String query) async {
    final url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['items'] != null) {
        return (data['items'] as List).map((book) => Book.fromJson(book)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to load books");
    }
  }
}
