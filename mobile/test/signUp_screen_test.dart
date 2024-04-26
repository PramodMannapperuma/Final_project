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

    // testWidgets('Invalid fields prevent form submission', (WidgetTester tester) async {
    //   // Build the widget
    //   await tester.pumpWidget(MaterialApp(home: SignupScreen()));
    //
    //   // Tap 'Next' without filling in any fields
    //   await tester.tap(find.byKey(const Key('next_step_button_0')));
    //   await tester.pump();
    //
    //   // Validate error messages for step 1
    //   expect(find.text('Please enter your first name'), findsOneWidget);
    //   expect(find.text('Please enter your last name'), findsOneWidget);
    //
    //   // Tap 'Next' again without filling in step 1 fields
    //   await tester.tap(find.byKey(const Key('next_step_button_1')));
    //   await tester.pump();
    //
    //   // Validate error messages for step 2
    //   expect(find.text('Please enter your email'), findsOneWidget);
    //   expect(find.text('Please enter your password'), findsOneWidget);
    //
    //   // Tap 'Next' again without filling in step 2 fields
    //   await tester.tap(find.byKey(const Key('next_step_button_2')));
    //   await tester.pump();
    //
    //   // Validate error message for step 3
    //   expect(find.text('Please select your gender'), findsOneWidget);
    // });

    // testWidgets('Valid fields allow form submission', (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(home: SignupScreen()));
    //
    //   await tester.enterText(find.byKey(Key('firstNameField')), 'John');
    //   await tester.enterText(find.byKey(Key('lastNameField')), 'Doe');
    //   await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
    //   await tester.enterText(find.byKey(Key('passwordField')), 'password');
    //   await tester.tap(find.text('Next'));
    //   await tester.pumpAndSettle();
    //
    //   await tester.tap(find.text('Next'));
    //   await tester.pumpAndSettle();
    //
    //   await tester.tap(find.text('SignUp'));
    //   await tester.pumpAndSettle();
    //
    //   expect(find.byType(LoginScreen), findsOneWidget);
    // });

    testWidgets("Tapping 'Already have an account?' navigates to Login screen", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignupScreen()));

      await tester.tap(find.text("Already have an account? Login"));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
