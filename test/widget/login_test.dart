import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travel_app/representation/screen/login/login_screen.dart';
import 'package:travel_app/firebase_auth_impleentation/firebase_auth_services.dart';

// Mock FirebaseAuthServices
class MockFirebaseAuthServices extends Mock implements FirebaseAuthServices {}

void main() {
  late MockFirebaseAuthServices mockAuth;

  setUp(() {
    mockAuth = MockFirebaseAuthServices();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: LoginScreen(),
    );
  }

  testWidgets('LoginScreen has a title and login form', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Verify that our counter starts at 0.
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Sign in to continue.'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Email validation works correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final emailField = find.widgetWithText(TextField, 'Email');

    // Enter invalid email
    await tester.enterText(emailField, 'invalid-email');
    await tester.pump();

    // Check if the border is red (indicating invalid input)
    final container = find.ancestor(
      of: emailField,
      matching: find.byType(Container),
    );
    final containerDecoration = tester.widget<Container>(container).decoration as BoxDecoration;
    expect(containerDecoration.border!.top.color, Colors.red);

    // Enter valid email
    await tester.enterText(emailField, 'valid@email.com');
    await tester.pump();

    // Check if the border is green (indicating valid input)
    final updatedContainerDecoration = tester.widget<Container>(container).decoration as BoxDecoration;
    expect(updatedContainerDecoration.border!.top.color, Colors.green);
  });

  testWidgets('Password field is obscured', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final passwordField = find.widgetWithText(TextField, 'Password');
    expect(tester.widget<TextField>(passwordField).obscureText, true);
  });

  testWidgets('Login button press calls FirebaseAuthServices', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Enter email and password
    await tester.enterText(find.widgetWithText(TextField, 'Email'), 'test@example.com');
    await tester.enterText(find.widgetWithText(TextField, 'Password'), 'password');

    // Tap the login button
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Verify that the signInWithEmailAndPassword method was called
    verify(mockAuth.signInWithEmailAndPassword('test@example.com', 'password')).called(1);
  });
}