import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/auth/login.dart';
import 'package:mobile/auth/signUp.dart';
import 'package:mobile/Home.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('Login form renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text("Don't have an account? Sign up"), findsOneWidget);
    });

    testWidgets('Invalid email shows error', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      await tester.tap(find.text('Login'));
      await tester.pump();

      expect(find.text('Please enter your email'), findsOneWidget);
    });


    testWidgets("Tapping 'Sign up' navigates to SignUp screen", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      await tester.tap(find.text("Don't have an account? Sign up"));
      await tester.pumpAndSettle();

      expect(find.byType(SignupScreen), findsOneWidget);
    });

  });
}
