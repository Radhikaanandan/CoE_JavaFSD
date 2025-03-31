import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'news_detail_screen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List newsArticles = [];
  bool isLoading = false;
  final String apiKey = "7d58288a4dac48599a154324dfb0e9f5"; 
  String selectedCategory = "general"; 
  String selectedLanguage = "en"; 

  final List<String> categories = [
    "general", "business", "sports", "technology", "entertainment", "health", "science"
  ];

  final Map<String, String> languages = {
    "English": "en",
    "Español (Spanish)": "es",
    "Français (French)": "fr",
    "Deutsch (German)": "de",
    "हिन्दी (Hindi)": "hi",
  };

  @override
  void initState() {
    super.initState();
  }

  Future<List> fetchNews() async {
    final url =
        "https://newsapi.org/v2/top-headlines?category=$selectedCategory&language=$selectedLanguage&apiKey=$apiKey";

    print("Fetching news from: $url"); 

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["articles"] != null && data["articles"].isNotEmpty) {
          return data["articles"];
        } else {
          print("⚠️ No articles found for language: $selectedLanguage");
          return [];
        }
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  void saveToFavorites(BuildContext context, Map<String, dynamic> article) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please log in to save favorites.")),
      );
      return;
    }

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("favorites_news")
        .add(article)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("News added to Favorites!")),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local News"),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.language),
            onSelected: (String newLang) {
              setState(() {
                selectedLanguage = newLang;
              });
            },
            itemBuilder: (context) {
              return languages.entries.map((entry) {
                return PopupMenuItem<String>(
                  value: entry.value,
                  child: Text(entry.key),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: categories.map((category) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
                    label: Text(
                      category.toUpperCase(),
                      style: TextStyle(color: selectedCategory == category ? Colors.white : Colors.black),
                    ),
                    selected: selectedCategory == category,
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.grey[300],
                    onSelected: (bool selected) {
                      if (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          Expanded(
            child: FutureBuilder<List>(
              future: fetchNews(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error loading news"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text(
                    "No news available for the selected language.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var article = snapshot.data![index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: article["urlToImage"] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(article["urlToImage"], width: 80, height: 80, fit: BoxFit.cover),
                                )
                              : Icon(Icons.image, size: 80),
                          title: Text(article["title"] ?? "No Title", maxLines: 2, overflow: TextOverflow.ellipsis),
                          subtitle: Text(article["description"] ?? "No Description", maxLines: 2, overflow: TextOverflow.ellipsis),
                          trailing: IconButton(
                            icon: Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              saveToFavorites(context, article);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailScreen(article: article),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
