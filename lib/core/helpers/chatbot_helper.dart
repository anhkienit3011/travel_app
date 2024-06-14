import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DialogflowHelper {
  static final String _apiKey = dotenv.env['DIALOGFLOW_API_KEY'] ?? '';

  static Future<String?> getChatbotResponse(String message) async {
    try {
      final response = await http.post(
        Uri.parse('https://dialogflow.googleapis.com/v2/projects/chatbot-flutter-trui/agent/sessions/default:detectIntent'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          "queryInput": {
            "text": {
              "text": message,
              "languageCode": "en"
            }
          }
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['queryResult']['fulfillmentText'];
      } else {
        print('Failed to get response: ${response.statusCode}');
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Exception: $e');
      return 'Error: $e';
    }
  }
}
