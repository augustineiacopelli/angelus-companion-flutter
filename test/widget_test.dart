import 'package:flutter_test/flutter_test.dart';

import 'package:angelus_companion/main.dart';

void main() {
  testWidgets('home screen renders the title and the begin control',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AngelusApp());
    await tester.pump(const Duration(milliseconds: 120));

    expect(find.text('ANGELUS COMPANION'), findsOneWidget);
    expect(find.text('BEGIN'), findsOneWidget);
  });
}