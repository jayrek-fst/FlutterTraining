import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fumiya_flutter/widget/alert_dialog_widget.dart';

void main() {
  testWidgets('alert dialog widget test', (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Material(
            child: AlertDialogWidget(
                message: 'testMessage', title: 'testTitle'))));

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('testMessage'), findsOneWidget);
    expect(find.text('testTitle'), findsOneWidget);
  });
}
