import 'dart:convert';
import 'package:http/http.dart' as http;

class SpaceService {
  static Future<List<Map<String, String>>> getSpaceFacts() async {
    final String apiKey = "qATJh46dDqbVgfd1hPkstdqFQ8RcuDgx8xE27bTO";
    final String apiUrl = "https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=5";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        
        return data.map<Map<String, String>>((fact) => {
              "title": fact['title'] ?? "Unknown Title",
              "explanation": fact['explanation'] ?? "No explanation available.",
              "imageUrl": fact['url'] ?? "",
            }).toList(); 
      } else {
        throw Exception("Failed to fetch space facts");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
