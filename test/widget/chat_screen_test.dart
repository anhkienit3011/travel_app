import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/representation/screen/chat_screen.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('ChatScreen sends and displays messages', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ChatScreen()));
    await tester.enterText(find.byType(TextField), 'Hello');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();
    expect(find.text('Hello'), findsOneWidget);
  });
}
