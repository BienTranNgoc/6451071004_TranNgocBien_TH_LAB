// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jobspot/apps/app.dart';
import 'package:jobspot/utils/app_strings.dart';

void main() {
  testWidgets('shows splash then onboarding screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const JobspotApp());

    expect(find.text(AppStrings.appName), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText() == 'Find Your\nDream Job\nHere!',
      ),
      findsOneWidget,
    );
  });
}
