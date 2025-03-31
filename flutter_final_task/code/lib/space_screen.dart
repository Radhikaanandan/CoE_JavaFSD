import 'package:flutter/material.dart';
import 'space_service.dart';

class SpaceScreen extends StatefulWidget {
  @override
  _SpaceScreenState createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  late Future<List<Map<String, String>>> spaceFacts;

  @override
  void initState() {
    super.initState();
    spaceFacts = SpaceService.getSpaceFacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🌌 Space Facts")),
      body: FutureBuilder<List<Map<String, String>>>(
        future: spaceFacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No space facts available."));
          }

          final facts = snapshot.data!;
          return ListView.builder(
            itemCount: facts.length,
            itemBuilder: (context, index) {
              final fact = facts[index];
              return Card(
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fact["imageUrl"]!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.network(
                              fact["imageUrl"]!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fact["title"]!,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            fact["explanation"]!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
