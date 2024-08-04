import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiApiService {
  final String baseUrl =
      'https://your-gemini-endpoint.com/api'; // Replace with actual Gemini endpoint URL

  Future<String> getResponse(String prompt) async {
    final url = Uri.parse(
        '$baseUrl/your-endpoint'); // Replace with actual endpoint path
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_API_KEY', // Replace with actual API key
      },
      body: jsonEncode({'prompt': prompt}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['response']; // Adjust based on actual response structure
    } else {
      throw Exception('Failed to load data');
    }
  }
}
