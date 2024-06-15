import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/representation/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('HomePage displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    expect(find.text('Top Destinations'), findsOneWidget);
  });
}
