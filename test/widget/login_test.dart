// test/widget/login_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:travel_app/representation/screen/login/login_screen.dart';
import 'package:travel_app/firebase_auth_impleentation/firebase_auth_services.dart'; // Adjust the import path based on your project structure

void main() {
  late MockFirebaseAuth mockAuth;
  late FirebaseAuthServices authService;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    authService = FirebaseAuthServices(auth: mockAuth);
  });

  testWidgets('Login button triggers Firebase Auth sign-in', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(),
      // Inject your mock auth service
      builder: (context, child) {
        return MockFirebaseAuthServices(auth: mockAuth, child: child!);
      },
    ));

    final emailField = find.byType(TextField).at(0);
    final passwordField = find.byType(TextField).at(1);
    final loginButton = find.text('Login');

    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password');
    await tester.tap(loginButton);
    await tester.pump();

    // Check if the user was signed in
    expect(authService.currentUser?.email, 'test@example.com');
  });

  testWidgets('Validate email address shows error on invalid input', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(),
      builder: (context, child) {
        return MockFirebaseAuthServices(auth: mockAuth, child: child!);
      },
    ));

    final emailField = find.byType(TextField).at(0);
    await tester.enterText(emailField, 'invalid-email');
    await tester.pump();

    // Your implementation to check for validation, for example,
    // Assuming you are using BoxDecoration color change to show invalid input.
    final container = find.ancestor(
      of: emailField,
      matching: find.byType(Container),
    );

    final containerDecoration = tester.widget<Container>(container).decoration as BoxDecoration;
    expect(containerDecoration.border?.top.color, Colors.red);
  });
}
