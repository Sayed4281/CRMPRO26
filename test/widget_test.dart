import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:crmpro26/main.dart';

void main() {
  testWidgets(
      'Overview text and Select Date button exist and button can be tapped',
      (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Check if 'Overview' text is present somewhere on screen.
    expect(find.textContaining('Overview'), findsOneWidget);

    // Find the 'Select Date' button by its text.
    final selectDateButton = find.text('Select Date');
    expect(selectDateButton, findsOneWidget);

    // Tap the 'Select Date' button.
    await tester.tap(selectDateButton);
    await tester.pumpAndSettle();

    // Optionally check if date picker dialog appeared:
    expect(find.byType(Dialog), findsOneWidget);
  });
}
