import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiApiService {
  final String apiKey;

  GeminiApiService({required this.apiKey});

  final String baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent';

  Future<String> getResponse(String prompt) async {
    final url = Uri.parse('$baseUrl?key=$apiKey');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
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
      // print('Gemini API Response: $result');
      return result['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
