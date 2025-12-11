import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets("AppBar görünür mü", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
        ),
      ),
    );

    expect(find.text("Test Title"), findsOneWidget);
  });
}
