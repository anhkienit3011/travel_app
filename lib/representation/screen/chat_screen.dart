// lib/representation/screen/chat_screen.dart

import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import '../../core/helpers/chatbot_helper.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add({'user': _controller.text});
    });

    String? response = await ChatbotHelper.getChatbotResponse(_controller.text.trim());

    if (response != null) {
      setState(() {
        _messages.add({'bot': response});
      });
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  if (message.containsKey('user')) {
                    return ListTile(
                      title: Text(message['user']!),
                      subtitle: Text('You'),
                      leading: Icon(Icons.person),
                    );
                  } else {
                    return ListTile(
                      title: Text(message['bot']!),
                      subtitle: Text('Bot'),
                      leading: Icon(Icons.lightbulb),
                    );
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
