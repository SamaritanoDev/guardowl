import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = 'AIzaSyCl0smsScNd27sYfywfrC7axiJD5KoTF4M';

class GeminiApiService {
  final String baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent';

  Future<dynamic> getResponse(String prompt) async {
    final url = Uri.parse('$baseUrl?key=$apiKey'); // Replace with actual endpoint path
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer YOUR_API_KEY', // Replace with actual API key
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      // crear un modelo para reemplazar esto
      return result['candidates'][0]['content']['parts'][0]['text']; // Adjust based on actual response structure
    } else {
      throw Exception('Failed to load data');
    }
  }
}
