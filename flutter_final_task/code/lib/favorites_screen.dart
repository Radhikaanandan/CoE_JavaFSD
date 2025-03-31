import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> removeFromFavorites(String docId) async {
    if (user == null) return;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("favorites")
        .doc(docId)
        .delete();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Book removed from Favorites!")),
    );

    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Favorite Books")),
      body: user == null
          ? Center(child: Text("Please log in to view favorites."))
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(user!.uid)
                  .collection("favorites")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No favorite books added."));
                }

                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    var book = doc.data() as Map<String, dynamic>;
                    return ListTile(
                      leading: book["imageLinks"] != null
                          ? Image.network(book["imageLinks"]["thumbnail"])
                          : Icon(Icons.book, size: 40),
                      title: Text(book["title"] ?? "No Title"),
                      subtitle: Text(book["authors"]?.join(", ") ?? "No Author"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeFromFavorites(doc.id),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
    );
  }
}
