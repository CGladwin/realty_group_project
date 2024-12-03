import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:realty_group_project/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('User adds a new listing', (WidgetTester tester) async {
    // Launch the app.
    await tester.pumpWidget(const MyApp());

    // Navigate to Add Listing Page using a FloatingActionButton key.
    final addButton = find.byKey(const Key('add_button')); // Updated to use Key.
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // Fill out the form fields.
    await tester.enterText(find.byKey(const Key('address_field')), '123 Main St');
    await tester.enterText(find.byKey(const Key('beds_field')), '3');
    await tester.enterText(find.byKey(const Key('baths_field')), '2');
    await tester.enterText(find.byKey(const Key('square_feet_field')), '1500');
    await tester.enterText(find.byKey(const Key('price_field')), '350000');
    await tester.enterText(
        find.byKey(const Key('image_url_field')), 'https://example.com/image.jpg');

    // Submit the form.
    final submitButton = find.byKey(const Key('submit_button'));
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Verify that the listing appears on the main page.
    expect(find.text('123 Main St'), findsOneWidget);
    expect(find.text('3 beds, 2 baths, 1500 sqft'), findsOneWidget);
    expect(find.text('\$350,000.00'), findsOneWidget);
  });
}
