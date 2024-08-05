import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiApiService {
  final String baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent';

  Future<String> getResponse(String prompt) async {
    final url = Uri.parse(
        '$baseUrl?key=YOUR_API_KEY'); // Replace with actual endpoint path
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_API_KEY', // Replace with actual API key
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": $prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['response']; // Adjust based on actual response structure
    } else {
      throw Exception('Failed to load data');
    }
  }
}
