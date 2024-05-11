import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/auth/login.dart';
import 'package:mobile/auth/signUp.dart';

void main() {
  group('SignupScreen Widget Tests', () {
    testWidgets('Signup form renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignupScreen()));

      expect(find.text('First Name'), findsOneWidget);
      expect(find.text('Last Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Gender'), findsOneWidget);
      // expect(find.text('Next'), findsOneWidget);
      expect(find.text("Already have an account? Login"), findsOneWidget);
    });

    testWidgets("Tapping 'Already have an account?' navigates to Login screen", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignupScreen()));

      await tester.tap(find.text("Already have an account? Login"));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });

  });
}
