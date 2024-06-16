import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/representation/screen/login/signup_screen.dart';



void main() {
  testWidgets('SignUpScreen UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

    // Verify that our SignUpScreen is rendered
    expect(find.byType(SignUpScreen), findsOneWidget);

    // Verify that the welcome text is present
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Sign up to get started.'), findsOneWidget);

    // Verify that all input fields are present
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('First Name'), findsOneWidget);
    expect(find.text('Last Name'), findsOneWidget);
    expect(find.text('Date of Bith'), findsOneWidget);
    expect(find.text('Address'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);

    // Verify that the sign up button is present
    expect(find.text('Sign Up'), findsOneWidget);

    // Verify that the login link is present
    expect(find.text('Already have an account?'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Email validation test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

    // Find the email TextField
    final emailField = find.widgetWithText(TextField, 'Email');

    // Enter an invalid email
    await tester.enterText(emailField, 'invalid-email');
    await tester.pump();

    // Check if the border color is red (indicating invalid email)
    final emailContainer = tester.widget<Container>(find.ancestor(
      of: emailField,
      matching: find.byType(Container),
    ).first);
    expect(emailContainer.decoration, isA<BoxDecoration>());
    final BoxDecoration decoration = emailContainer.decoration as BoxDecoration;
    expect(decoration.border!.top.color, Colors.red);

    // Enter a valid email
    await tester.enterText(emailField, 'valid@email.com');
    await tester.pump();

    // Check if the border color is green (indicating valid email)
    final updatedEmailContainer = tester.widget<Container>(find.ancestor(
      of: emailField,
      matching: find.byType(Container),
    ).first);
    expect(updatedEmailContainer.decoration, isA<BoxDecoration>());
    final BoxDecoration updatedDecoration = updatedEmailContainer.decoration as BoxDecoration;
    expect(updatedDecoration.border!.top.color, Colors.green);
  });
}