import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fumiya_flutter/widget/elevated_button_widget.dart';

void main() {
  testWidgets('Elevated button widget test', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: ElevatedButtonWidget(label: 'Login', onPressed: () {})));

    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
