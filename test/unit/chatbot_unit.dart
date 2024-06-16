import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/representation/screen/chat_screen.dart'; // Adjust the import path as per your project

void main() {
  testWidgets('Send "hi" and expect response from bot', (WidgetTester tester) async {
    // Build ChatScreen widget
    await tester.pumpWidget(MaterialApp(
      home: ChatScreen(),
    ));

    // Find the text field and enter "hi"
    await tester.enterText(find.byType(TextField), 'hi');

    // Find the send button and tap it
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump(); // Rebuild the widget after tapping the send button

    // Verify if the response is "How can I help you?"
    expect(find.text('How can I help you?'), findsOneWidget);
  });
}
