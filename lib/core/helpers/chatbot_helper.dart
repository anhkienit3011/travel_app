import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatbotHelper {
  static final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  static final Uri _apiUrl = Uri.parse('https://api.openai.com/v1/chat/completions');

  static Future<String?> getChatbotResponse(String message) async {
    try {
      final response = await http.post(
        _apiUrl,
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo', // Change to the correct model
          'messages': [
            {'role': 'system', 'content': 'You are a helpful assistant.'},
            {'role': 'user', 'content': message},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['choices'][0]['message']['content']?.trim();
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
