import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'book_detail_screen.dart';
import 'favorites_screen.dart'; 

class BookScreen extends StatefulWidget {
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  TextEditingController searchController = TextEditingController();
  List books = [];
  bool isLoading = false;

  final String apiKey = "AIzaSyD9HF5ZdLnsg3V0pfbFxwEfQkjiTdmWbvI"; 
  Future<void> fetchBooks(String query) async {
    setState(() {
      isLoading = true;
    });

    final url = "https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          books = data["items"] ?? [];
        });
      } else {
        throw Exception("Failed to load books");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void saveToFavorites(BuildContext context, Map<String, dynamic> book) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("favorites")
        .add(book)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Book added to Favorites!")),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Books"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Enter book title",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    fetchBooks(searchController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  var book = books[index]["volumeInfo"];
                  return ListTile(
                    leading: book["imageLinks"] != null
                        ? Image.network(book["imageLinks"]["thumbnail"])
                        : Icon(Icons.book, size: 40),
                    title: Text(book["title"] ?? "No Title"),
                    subtitle: Text(book["authors"] != null
                        ? book["authors"].join(", ")
                        : "No Author"),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        saveToFavorites(context, book);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
