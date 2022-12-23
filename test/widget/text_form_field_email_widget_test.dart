import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fumiya_flutter/util/string_constants.dart';
import 'package:fumiya_flutter/widget/text_form_field_email_widget.dart';

void main() {
  testWidgets('Text form field email widget test', (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Material(
            child: TextFormFieldEmailWidget(
                name: StringConstants.nickName,
                title: 'titleTest',
                hint: 'testHint'))));

    expect(find.byType(Column), findsOneWidget);
    expect(find.text('titleTest'), findsOneWidget);
    expect(find.text('testHint'), findsOneWidget);
  });
}
