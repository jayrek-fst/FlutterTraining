import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fumiya_flutter/util/asset_path_util.dart';
import 'package:fumiya_flutter/widget/common_widget.dart';

void main() {
  testWidgets('customAppBar test', (tester) async {
    await tester.pumpWidget(
        MaterialApp(home: customAppBar(title: 'titleTest', onTap: () {})));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('titleTest'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  testWidgets('subscriptionBenefitsItem test', (tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Material(child: Builder(builder: (context) {
      return subscriptionBenefitsItem(context, 'test');
    }))));

    const image = AssetImage(AssetPathUtil.checkBoxImagePath);

    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('test'), findsOneWidget);
    expect(find.image(image), findsOneWidget);
  });

  testWidgets('imageAssetCheckTrue test', (tester) async {
    await tester.pumpWidget(MaterialApp(home: imageAssetCheckTrue()));

    const image = AssetImage(AssetPathUtil.checkBoxImagePath);

    expect(find.image(image), findsOneWidget);
  });

  testWidgets('itemLinkWidget test', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: itemLinkWidget('itemLink', () {})));

    expect(find.byType(Row), findsOneWidget);
    expect(find.text('・itemLink'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward_ios_outlined), findsOneWidget);
  });

  testWidgets('progressDialog test', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Stack(children: [progressDialog()])));

    expect(find.byType(Positioned), findsOneWidget);
  });

  testWidgets('otherListItem test', (tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Material(child: otherListItem(title: 'titleTest'))));

    expect(find.byType(Column), findsOneWidget);
    expect(find.text('titleTest'), findsOneWidget);
  });

  testWidgets('circularAddIcon test', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Stack(children: [circularAddIcon()])));

    expect(find.byType(Positioned), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('tutorialBody test', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (context) {
      return tutorialBody(
          context: context,
          message: 'testMessage',
          label: 'testLabel',
          image: AssetPathUtil.tutorialImage2Path,
          onPressed: () {});
    })));

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.text('testMessage'), findsOneWidget);
    expect(find.text('testLabel'.toUpperCase()), findsOneWidget);
  });
}
