import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fumiya_flutter/util/string_constants.dart';
import 'package:fumiya_flutter/widget/text_form_field_widget.dart';

void main() {
  testWidgets('Text form field widget test', (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Material(
            child: TextFormFieldWidget(
                name: StringConstants.nickName,
                textInputType: TextInputType.text,
                hint: 'testHint',
                initialValue: 'testInitialValue'))));

    expect(find.byType(FormBuilderTextField), findsOneWidget);
    expect(find.text('testHint'), findsOneWidget);
    expect(find.text('testInitialValue'), findsOneWidget);
  });
}
