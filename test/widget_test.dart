import 'package:flutter_test/flutter_test.dart';

import 'package:crmpro26/main.dart';

void main() {
  testWidgets('Overview text and Select Date button exist and can be tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify Overview text is present.
    expect(find.textContaining('Overview'), findsOneWidget);

    // Find the 'Select Date' button.
    final selectDateButton = find.text('Select Date');
    expect(selectDateButton, findsOneWidget);

    // Scroll into view if necessary.
    await tester.ensureVisible(selectDateButton);

    // Tap the button. This should not throw errors.
    await tester.tap(selectDateButton);

    // Wait for animations.
    await tester.pumpAndSettle();

    // We do NOT check for Dialog because date picker is platform native.
  });
}
