import 'dart:convert';
import 'package:http/http.dart' as http;

class QuotesService {
  static const String apiKey = 'NRag+o2OXRyANLWoOswKpw==ezyMvJ6uBfa6iKRb'; 
  static const String apiUrl = 'https://api.api-ninjas.com/v1/quotes';

  Future<String> fetchQuote() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData[0]['quote']; 
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
