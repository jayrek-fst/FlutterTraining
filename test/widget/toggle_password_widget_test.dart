import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fumiya_flutter/widget/toggle_password_widget.dart';

void main() {
  testWidgets(
      'Toggle password suffix icon widget displays visibility off rounded',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: TogglePasswordSuffixIconWidget(isToggle: true)));

    expect(find.byIcon(Icons.visibility_off_rounded), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('Toggle password suffix icon widget displays visibility rounded',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: TogglePasswordSuffixIconWidget(isToggle: false)));

    expect(find.byIcon(Icons.visibility_rounded), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });
}
