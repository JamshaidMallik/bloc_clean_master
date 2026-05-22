import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_clean_master/main.dart';

void main() {
  testWidgets('App shows posts screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Posts'), findsOneWidget);
    expect(find.text('Search posts'), findsOneWidget);
    expect(find.text('Designing a cleaner Flutter workflow'), findsOneWidget);
  });
}
