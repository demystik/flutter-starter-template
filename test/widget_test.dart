import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_design_system/main.dart';

void main() {
  testWidgets('App smoke test loads login page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    // Verify that login title and sign-in button are present.
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
