import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  List songs = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchMusic();
  }

  Future<void> fetchMusic() async {
    setState(() {
      isLoading = true;
    });

    final url = "https://deezerdevs-deezer.p.rapidapi.com/playlist/%7Bid%7D"; 

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          songs = data["data"] ?? [];
        });
      } else {
        throw Exception("Failed to load music");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Deezer Music")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                var song = songs[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: song["album"]["cover"] != null
                        ? Image.network(song["album"]["cover"], width: 60, height: 60, fit: BoxFit.cover)
                        : Icon(Icons.music_note, size: 60),
                    title: Text(song["title"] ?? "No Title", maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Text(song["artist"]["name"] ?? "Unknown Artist"),
                    trailing: Icon(Icons.play_arrow, color: Colors.green),
                    onTap: () {
                      
                    },
                  ),
                );
              },
            ),
    );
  }
}
