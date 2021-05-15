import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz/main.dart';
import 'package:quiz/pages/home.dart';

void main() {
  testWidgets('Assert home page buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Application());

    // Verify that there are 3 disabled buttons
    expect(
        tester
            .widget<ElevatedButton>(find.byKey(Key(SOLO_BUTTON_TEXT)))
            .enabled,
        isFalse);
    expect(
        tester
            .widget<ElevatedButton>(find.byKey(Key(LOBBY_CREATION_BUTTON_TEXT)))
            .enabled,
        isFalse);
    expect(
        tester
            .widget<ElevatedButton>(find.byKey(Key(LOBBY_JOINING_BUTTON_TEXT)))
            .enabled,
        isFalse);
  });
}
