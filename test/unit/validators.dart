import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/core/extensions/validate.dart';

void main() {
  test('validateEmail returns null for valid email', () {
    final result = validateEmailAddress('test@example.com');
    expect(result, true);
  });

  test('validateEmail returns error message for invalid email', () {
    final result = validateEmailAddress('test@');
    expect(result, false);
  });
}
