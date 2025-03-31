import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  NewsDetailScreen({required this.article});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article["urlToImage"] != null
                ? Image.network(article["urlToImage"], height: 200, width: double.infinity, fit: BoxFit.cover)
                : Icon(Icons.image, size: 200),
            SizedBox(height: 10),
            Text(article["title"] ?? "No Title", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(article["description"] ?? "No Description", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (article["url"] != null) {
                  _launchURL(article["url"]);
                }
              },
              child: Text("Read Full Article"),
            ),
          ],
        ),
      ),
    );
  }
}
