import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:travel_app/core/constants/color_constants.dart';
// import 'dart:convert';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _initializeDialogFlowtter();
  }

  Future<void> _initializeDialogFlowtter() async {
    try {
      // Load the credentials from the JSON file
      // final credentials = await rootBundle.loadString('assets/chatbot-flutter-trui-c285e0da61a0.json');
      // final credentialsMap = jsonDecode(credentials);

      // Initialize DialogFlowtter using the credentials
      dialogFlowtter = DialogFlowtter(jsonPath: 'assets/chatbot-flutter-trui-c285e0da61a0.json');
    } catch (error) {
      print('Error initializing DialogFlowtter: $error');
    }
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      messages.add({
        'message': Message(text: DialogText(text: [_controller.text])),
        'isUserMessage': true,
      });
    });

    final text = _controller.text;
    _controller.clear();

    try {
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: text)),
      );

      if (response.message != null) {
        setState(() {
          messages.add({
            'message': response.message!,
            'isUserMessage': false,
          });
        });
      }
    } catch (error) {
      print('Error sending message: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(child: MessagesScreen(messages: messages)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: ColorPalette.primaryColor,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MessagesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final bool isUserMessage = message['isUserMessage'];
        return Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: isUserMessage
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(isUserMessage ? 0 : 20),
                    topLeft: Radius.circular(isUserMessage ? 20 : 0),
                  ),
                  color: isUserMessage
                      ? ColorPalette.primaryColor
                      : ColorPalette.primaryColor,
                ),
                constraints: BoxConstraints(maxWidth: w * 2 / 3),
                child: Text(
                  message['message'].text.text[0],
                  style: TextStyle(
                    color: isUserMessage ? Colors.white : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
