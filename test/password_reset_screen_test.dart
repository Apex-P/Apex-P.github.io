import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:apex_p/screens/password_reset_screen.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

class _App extends StatelessWidget {
  const _App({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => MaterialApp(home: child);
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  setUpAll(() async {
    // Initialise Supabase with dummy values so the widget tree can build
    // without making real network calls.
    await Supabase.initialize(
      url: 'https://example.supabase.co',
      anonKey: 'dummy-anon-key',
    );
  });

  group('PasswordResetScreen – request-reset form (no session)', () {
    testWidgets('renders the request-reset form', (tester) async {
      await tester.pumpWidget(const _App(child: PasswordResetScreen()));

      expect(find.text('Forgot your password?'), findsOneWidget);
      expect(find.text('Send Reset Link'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('shows error when e-mail field is empty', (tester) async {
      await tester.pumpWidget(const _App(child: PasswordResetScreen()));

      await tester.tap(find.text('Send Reset Link'));
      await tester.pump();

      expect(find.text('Please enter your e-mail address.'), findsOneWidget);
    });

    testWidgets('shows error for invalid e-mail format', (tester) async {
      await tester.pumpWidget(const _App(child: PasswordResetScreen()));

      await tester.enterText(find.byType(TextFormField), 'not-an-email');
      await tester.tap(find.text('Send Reset Link'));
      await tester.pump();

      expect(find.text('Please enter a valid e-mail address.'), findsOneWidget);
    });

    testWidgets('no validation error for a well-formed e-mail', (tester) async {
      await tester.pumpWidget(const _App(child: PasswordResetScreen()));

      await tester.enterText(
          find.byType(TextFormField), 'user@example.com');
      // Validate the form without pressing the button (which would trigger a
      // network call).
      final formState = tester
          .state<FormState>(find.byType(Form));
      expect(formState.validate(), isTrue);
    });
  });
}
